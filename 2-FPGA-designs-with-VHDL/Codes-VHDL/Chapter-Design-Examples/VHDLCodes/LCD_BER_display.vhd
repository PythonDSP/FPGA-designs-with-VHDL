-- LCD_BER_display.vhd
-- Message displayed on LCD and values are take from other entities

--------------------------------------------------
-- Message | Values (from other designs)
-- Errors= | 0x03F
-- Bits=   | 0x00000003F 
--------------------------------------------------

-- ASCII HEX TABLE
-- Hex Low Hex Digit
-- Value 0  1 2 3 4 5 6 7 8 9 A B C D E F
--------------------------------------------------
--H 2 |  SP ! " # $ % & ' ( ) * + , - . /
--i 3 |  0  1 2 3 4 5 6 7 8 9 : ; < = > ?
--g 4 |  @  A B C D E F G H I J K L M N O
--h 5 |  P  Q R S T U V W X Y Z [ \ ] ^ _
--  6 |  `  a b c d e f g h i j k l m n o
--  7 |  p  q r s t u v w x y z { | } ~ DEL
--------------------------------------------------      

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.LCD_SSD_display_pkg.all;

entity LCD_BER_display is
generic (
    -- dont go below 5000 as LCD will refresh very fast and we can see the values on LCD
    clk_dvd : natural := 50000; 
    max_count : natural := 16
    ); 
port(
    CLOCK_50, reset : in std_logic;
    error_val : in unsigned(11 downto 0);
    total_bits : in unsigned(31 downto 0);
    LCD_RS, LCD_RW : out std_logic;
    LCD_EN : out std_logic;
    LCD_ON, LCD_BLON : out std_logic; -- LCD ON, Backlight ON
    LCD_DATA : out unsigned(7 downto 0)
); 
end entity;  

architecture arch of LCD_BER_display is 
    -- FSM for lcd display
    type stateType is (init1, init2, init3, init4, clearDisplay, displayControl, Line1, Line2, writeData_row1, writeData_row2, returnHome);
    signal state_reg, state_next : stateType; 
    signal input_lcd : unsigned(7 downto 0);
     
    signal count : natural := 0;
    signal char_count_reg, char_count_next : natural := 0;

    -- read the new input values after displaying the current values
    signal error_val_reg, error_val_next : unsigned(11 downto 0);  
    signal total_bits_reg, total_bits_next : unsigned(31 downto 0); 

    -- clock for LCD
    signal lcd_clock : std_logic;
     
    -- 16X2 LCD : ASCII-format
    type character_string is array ( 0 to 31 ) of unsigned( 7 downto 0 );
    signal LCD_display_string : character_string;

begin
    -- Data to be displayed : 
    LCD_display_string <= (

        -- use spaces (X"20) for blank positions, then update these blank posistion 
        -- with desired values e.g. in row 1 we udpated the blank position with switch value
        -- and in row 2, blank space is replaced by counting

        -- Line 1
        X"45",X"72",X"72",X"6F",X"72",X"73",X"3D",X"20",  -- Errors= 
        X"30",X"78",X"20",X"20",X"20",X"20",X"20",X"20",  -- 0x 6-spaces

        -- Line 2
        X"42",X"69",X"74",X"73",X"3D",X"20",X"30",X"78",  -- Bits= 0x
        X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20"  -- 8 spaces        
    );

    -- lcd display settings
    LCD_ON <= '1';
    LCD_BLON <= '1'; 
    LCD_EN <= lcd_clock;

    -- clock divider which is used as "enable" signal for LCD
    -- this is required as for higher clock-rates, we can not see
    -- the data on the LCD. 
    process(CLOCK_50, reset)
    begin 
        if reset = '1' then 
            count <= 0;
            lcd_clock <= '0';
        elsif (rising_edge(CLOCK_50)) then 
            count <= count + 1; 
            if count = clk_dvd then 
                lcd_clock <= not lcd_clock;
                count <= 0;
            end if; 
        end if;
    end process; 


    -- current states for LCD data
    process(lcd_clock, reset)
    begin 
        if reset = '1' then 
            state_reg <= init1;
            char_count_reg <= 0; 
            total_bits_reg <= (others => '0');
            error_val_reg <= (others => '0');
        elsif (rising_edge(lcd_clock)) then 
            state_reg <= state_next;
            char_count_reg <= char_count_next;
            total_bits_reg <= total_bits_next;
            error_val_reg <= error_val_next;
        end if; 
    end process; 
    

    -- write data on LCD and calculate next-states of LCD
    process(state_reg, char_count_reg, error_val_reg, LCD_display_string, error_val, total_bits, total_bits_reg, input_lcd)
    begin 
        char_count_next <= char_count_reg;
        total_bits_next <= total_bits_reg; 
        error_val_next <= error_val_reg; 
        case state_reg is
            -- extra initialization states are required for proper reset operation
            when init1 =>
                LCD_RS <= '0';
                LCD_RW <= '0';
                LCD_DATA <= "00111000";
                -- change init2 to clearDisplay if extra-init is not required
                state_next <= init2;  
           
            when init2 =>
                LCD_RS <= '0';
                LCD_RW <= '0';
                LCD_DATA <= "00111000";
                state_next <= init3;
          
            when init3 =>
                LCD_RS <= '0';
                LCD_RW <= '0';
                LCD_DATA <= "00111000";
                state_next <= init4;
           
            when init4 =>
                LCD_RS <= '0';
                LCD_RW <= '0';
                LCD_DATA <= "00111000";
                state_next <= clearDisplay;
            
            -- clear display and turn off cursor
            when clearDisplay =>
                LCD_RS <= '0';
                LCD_RW <= '0';
                LCD_DATA <= "00000001";
                state_next <= displayControl;
            
            -- turn on Display and turn off cursor
            when displayControl =>
                LCD_RS <= '0';
                LCD_RW <= '0';
                LCD_DATA <= "00001100";
                state_next <= Line1;

            -- Line 1
            -- write mode with auto-increment address and move cursor to the right
            when Line1 =>
                LCD_RS <= '0';
                LCD_RW <= '0';
                LCD_DATA <= "00000110";
                state_next <= writeData_row1;
            
            -- write data 
            when writeData_row1 =>
                LCD_RS <= '1';
                LCD_RW <= '0';
                state_next <= writeData_row1;
                char_count_next <= char_count_reg + 1;

                if char_count_reg = 10 then -- replace space at position 13 with number
                    LCD_DATA <= binary_to_lcd(error_val_reg(11 downto 8));
                elsif char_count_reg = 11 then
                    LCD_DATA <= binary_to_lcd(error_val_reg(7 downto 4));
                elsif char_count_reg = 12 then
                    LCD_DATA <= binary_to_lcd(error_val_reg(3 downto 0));
                elsif char_count_reg < 15 then
                    LCD_DATA <= LCD_display_string(char_count_reg);
                else -- char_count_reg = 15 then
                    LCD_DATA <= LCD_display_string(char_count_reg);
                    state_next <= Line2;                    
                end if;

            -- Line 2
            when Line2 =>
                LCD_RS <= '0';
                LCD_RW <= '0';
                LCD_DATA <= "11000000";
                state_next <= writeData_row2;   

            -- write data at line 2
            when writeData_row2 =>
                LCD_RS <= '1';
                LCD_RW <= '0';
                state_next <= writeData_row2;
                char_count_next <= char_count_reg + 1;
                 
                if char_count_reg = 24 then -- replace space at position 13 with number
                    LCD_DATA <= binary_to_lcd(total_bits_reg(31 downto 28));
                elsif char_count_reg = 25 then
                    LCD_DATA <= binary_to_lcd(total_bits_reg(27 downto 24));

                elsif char_count_reg = 26 then
                    LCD_DATA <= binary_to_lcd(total_bits_reg(23 downto 20));
                elsif char_count_reg = 27 then
                    LCD_DATA <= binary_to_lcd(total_bits_reg(19 downto 16));
                elsif char_count_reg = 28 then
                    LCD_DATA <= binary_to_lcd(total_bits_reg(15 downto 12));
                elsif char_count_reg = 29 then
                    LCD_DATA <= binary_to_lcd(total_bits_reg(11 downto 8));
                elsif char_count_reg = 30 then
                    LCD_DATA <= binary_to_lcd(total_bits_reg(7 downto 4));
                elsif char_count_reg = 31 then  -- reached to end, hence go to "returnHome"
                    LCD_DATA <= binary_to_lcd(total_bits_reg(3 downto 0));
                    state_next <= returnHome;  
                    char_count_next <= 0;  
                else
                    LCD_DATA <= LCD_display_string(char_count_reg);                             
                end if;

            -- Return write address to first character postion on line 1
            when returnHome =>
                LCD_RS <= '0';
                LCD_RW <= '0';
                LCD_DATA <= "10000000";
                state_next <= writeData_row1;
                error_val_next <= error_val;
                total_bits_next <= total_bits;
        end case; 
    end process;     
end architecture; 

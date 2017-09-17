-- LCD_SSD_display.vhd
-- LCD and Seven-segment-display

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

entity LCD_SSD_display is
generic (clk_dvd : natural := 500000;
        max_count : natural := 16
    ); 
port(
    CLOCK_50, reset : in std_logic;
    SW : in std_logic_vector(3 downto 0);
    LEDG : out std_logic_vector(3 downto 0);
    HEX0 : out std_logic_vector(6 downto 0);
    LCD_RS, LCD_RW : out std_logic;
    LCD_EN : out std_logic;
    LCD_ON, LCD_BLON : out std_logic; -- LCD ON, Backlight ON
    LCD_DATA : out std_logic_vector(7 downto 0)
); 
end entity;  

architecture arch of LCD_SSD_display is 
    -- FSM for lcd display
    type stateType is (init1, init2, init3, init4, clearDisplay, displayControl, Line1, Line2, writeData_row1, writeData_row2, returnHome);
    signal state_reg, state_next : stateType; 
    signal input_lcd : std_logic_vector(7 downto 0);
	 
    signal count : natural := 0;
    signal char_count_reg, char_count_next : natural := 0;
    signal inc_count_reg, inc_count_next : integer := 0;
    
    signal lcd_clock : std_logic;
	 
    signal data1, data2 : std_logic_vector(3 downto 0);

    type character_string is array ( 0 to 31 ) of std_logic_vector( 7 downto 0 );
    signal LCD_display_string : character_string;

begin
	-- Data to be displayed : 
    LCD_display_string <= (

        -- use spaces (X"20) for blank positions, then update these blank posistion 
        -- with desired values e.g. in row 1 we udpated the blank position with switch value
        -- and in row 2, blank space is replaced by counting

        -- Line 1
        X"4D",X"45",X"48",X"45",X"52",X"20",X"20",X"53",  -- -- MEHER  S
        X"57",X"20",X"3D",X"20",X"20",X"20",X"20",X"20",  -- W = 

        -- Line 2
        X"43",X"6F",X"75",X"6E",X"74",X"20",X"3D",X"20",  -- count = 
        X"20",X"20",X"20",X"20",X"20",X"20",X"20",X"20"  -- 8 spaces        
    );

    -- LED display
    LEDG <= SW; 

    -- seven-segment display
    HEX0 <= binary_to_ssd(SW);

    -- lcd display
    LCD_ON <= '1';
    LCD_BLON <= '1'; 
    LCD_EN <= lcd_clock;
    input_lcd <= binary_to_lcd(SW);
	

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


    process(lcd_clock, reset)
    begin 
        if reset = '1' then 
            state_reg <= init1;
            inc_count_reg <= 0;
            char_count_reg <= 0; 
        elsif (rising_edge(lcd_clock)) then 
        	state_reg <= state_next;
            char_count_reg <= char_count_next;
            inc_count_reg <= inc_count_next;
        end if; 
    end process; 
	

    process(state_reg, char_count_reg, inc_count_reg, data1, data2, LCD_display_string, input_lcd)
    begin 
        char_count_next <= char_count_reg;
        inc_count_next <= inc_count_reg;

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

                if char_count_reg = 12 then -- replace space at position 13 with number
                    LCD_DATA <= input_lcd;
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
                 
                if char_count_reg = 24 then -- replace space at location 26 with number
                    -- decimal place of inc_count_reg
				    data1 <= std_logic_vector(to_signed((inc_count_reg / 10) mod 10, 4)); 
                    LCD_DATA <= binary_to_lcd(data1);
                elsif char_count_reg = 25 then 
                    -- unit place of inc_count_reg
				    data2 <= std_logic_vector(to_signed(inc_count_reg mod 10, 4)); 
                    LCD_DATA <= binary_to_lcd(data2);
                    if inc_count_reg = max_count then -- reset if count reach to maximum
                        inc_count_next <= 0; 
                    else
                        inc_count_next <= inc_count_reg + 1; 
                    end if; 
                elsif char_count_reg < 31 then
                    LCD_DATA <= LCD_display_string(char_count_reg);
                else -- char_count_reg = 31 then 
                    LCD_DATA <= LCD_display_string(char_count_reg);
                    char_count_next <= 0;
                    state_next <= returnHome;                    
                end if;

            -- Return write address to first character postion on line 1
            when returnHome =>
                LCD_RS <= '0';
                LCD_RW <= '0';
                LCD_DATA <= "10000000";
                state_next <= writeData_row1;
        end case; 
    end process;	 
end architecture; 

-- LCD_BER_display_top.vhd
-- test the LCD display

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.LCD_SSD_display_pkg.all;

entity LCD_BER_display_top is
generic (
    -- dont go below 5000 as LCD will refresh very fast and we can see the values on LCD
    clk_dvd : natural := 50000; 
    max_count : natural := 16
    ); 
port(
    CLOCK_50, reset : in std_logic;
    SW : in unsigned(11 downto 0);
    LCD_RS, LCD_RW : out std_logic;
    LCD_EN : out std_logic;
    LCD_ON, LCD_BLON : out std_logic; -- LCD ON, Backlight ON
    LCD_DATA : out unsigned(7 downto 0)
); 
end entity;  

architecture arch of LCD_BER_display_top is 
    
begin
   unit_LCD_BER : entity work.LCD_BER_display 
   port map (
        CLOCK_50 => CLOCK_50, 
        reset => reset,
        
        -- convert 6 bits to 12 and 32 bits format
        error_val => to_unsigned(to_integer(SW(5 downto 0)),12),
        total_bits =>to_unsigned(to_integer(SW(11 downto 6)),32),

        -- LCD control
        LCD_RS => LCD_RS,
        LCD_RW => LCD_RW,
        LCD_EN => LCD_EN,
        LCD_ON => LCD_ON,
        LCD_BLON => LCD_BLON,
        LCD_DATA => LCD_DATA
    );

end architecture; 

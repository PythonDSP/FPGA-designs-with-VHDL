-- error_lcd_connection_v1.vhd
-- version : 1
-- Meher Krishna Patel
-- Date : 21-Sep-2017

-- connects the error_counter_v1.vhd and LCD_BER_display.vhd to display
-- BER on the LCD

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity error_lcd_connection_v1 is
generic ( 
    -- total number of errors
    num_of_errors : unsigned(11 downto 0) := to_unsigned(200, 12)
);
port(
    clk_error, clk_LCD, reset : in std_logic;
    tx_bit, detected_bit : in std_logic; 
    --total_errors : out unsigned(11 downto 0);
    --total_bits : out unsigned(31 downto 0);

    LCD_RS, LCD_RW : out std_logic;
    LCD_EN : out std_logic;
    LCD_ON, LCD_BLON : out std_logic; -- LCD ON, Backlight ON
    LCD_DATA : out unsigned(7 downto 0)
); 
end entity;

architecture arch of error_lcd_connection_v1 is 
    signal total_errors_reg : unsigned(11 downto 0);
    signal total_bits_reg : unsigned(31 downto 0);
begin 
    unit_error_counter : entity work.error_counter_v1
        generic map (num_of_errors => num_of_errors)
        port map (
                clk => clk_error,
                reset => reset, 
                tx_bit => tx_bit,
                detected_bit => detected_bit,
                total_errors => total_errors_reg,
                total_bits => total_bits_reg
         );

    unit_LCD_BER : entity work.LCD_BER_display 
   port map (
        CLOCK_50 => clk_LCD, 
        reset => reset,
        
        -- convert 6 bits to 12 and 32 bits format
        error_val => total_errors_reg,
        total_bits => total_bits_reg,

        -- LCD control
        LCD_RS => LCD_RS,
        LCD_RW => LCD_RW,
        LCD_EN => LCD_EN,
        LCD_ON => LCD_ON,
        LCD_BLON => LCD_BLON,
        LCD_DATA => LCD_DATA
    );

end arch; 

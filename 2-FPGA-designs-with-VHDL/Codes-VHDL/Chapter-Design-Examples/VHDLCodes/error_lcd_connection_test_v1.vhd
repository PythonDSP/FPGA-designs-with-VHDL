-- error_lcd_connection_test_v1.vhd

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity error_lcd_connection_test_v1 is
generic ( 
    -- total number of errors
    num_of_errors : unsigned(11 downto 0) := to_unsigned(100, 12)
);
port(
    CLOCK_50, reset_n : in std_logic;
    SW : in std_logic_vector(1 downto 0); -- 1 tx bit, 0 detected bit 

    LCD_RS, LCD_RW : out std_logic;
    LCD_EN : out std_logic;
    LCD_ON, LCD_BLON : out std_logic; -- LCD ON, Backlight ON
    LCD_DATA : out unsigned(7 downto 0)
); 
end entity;

architecture arch of error_lcd_connection_test_v1 is 
    signal total_errors_reg : unsigned(11 downto 0);
    signal total_bits_reg : unsigned(31 downto 0);
    signal clk_error, clk_LCD, reset : std_logic;
begin 
    reset <= not reset_n; 
    
    unit_error_counter : entity work.error_lcd_connection_v1
        generic map (num_of_errors => num_of_errors)
        port map (
            clk_error => clk_error,
            clk_LCD => clk_LCD, 
            reset => reset, 
            tx_bit => SW(1),
            detected_bit => SW(0),


            -- LCD control
            LCD_RS => LCD_RS,
            LCD_RW => LCD_RW,
            LCD_EN => LCD_EN,
            LCD_ON => LCD_ON,
            LCD_BLON => LCD_BLON,
            LCD_DATA => LCD_DATA
    );

    	-- 1 ms clock
	unit_clockTick : entity work.clockTick
	generic map (
			M => 5000000, 
			N => 26
		)
	port map (
		clk => CLOCK_50,
		reset => reset, 
		clkPulse => clk_error -- clk_error
	);
    
    clk_LCD <= CLOCK_50;  -- clk_LCD
end arch; 

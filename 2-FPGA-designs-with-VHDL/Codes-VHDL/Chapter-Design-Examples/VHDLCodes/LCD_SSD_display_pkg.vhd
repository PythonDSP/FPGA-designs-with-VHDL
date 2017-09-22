-- LCD_SSD_display_pkg.vhd
-- LCD and Seven-segment-display
library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package LCD_SSD_display_pkg is
	-- binary to seven-segment format
	function binary_to_ssd (
					signal switch : unsigned
				)
			return unsigned;
			
	-- binary to LCD format
	function binary_to_lcd (
					signal switch : unsigned
				)
			return unsigned; 	
end LCD_SSD_display_pkg; 

		
package body LCD_SSD_display_pkg is
    -- begin function "binary_to_ssd"
    function binary_to_ssd (
            -- list all input here
            signal switch : unsigned(3 downto 0)
            )
        -- only one value can be return
        return unsigned is variable sevenSegment : unsigned(6 downto 0);
    begin 
        case switch is 
            -- active low i.e. 0:display & 1:no display
            when "0000" => sevenSegment := "1000000"; -- 0, 
            when "0001" => sevenSegment := "1111001"; -- 1
            when "0010" => sevenSegment := "0100100"; -- 2
            when "0011" => sevenSegment := "0110000"; -- 3 
            when "0100" => sevenSegment := "0011001"; -- 4
            when "0101" => sevenSegment := "0010010"; -- 5
            when "0110" => sevenSegment := "0000010"; -- 6
            when "0111" => sevenSegment := "1111000"; -- 7
            when "1000" => sevenSegment := "0000000"; -- 8
            when "1001" => sevenSegment := "0010000"; -- 9
            when "1010" => sevenSegment := "0001000"; -- a
            when "1011" => sevenSegment := "0000011"; -- b
            when "1100" => sevenSegment := "1000110"; -- c
            when "1101" => sevenSegment := "0100001"; -- d
            when "1110" => sevenSegment := "0000110"; -- e
            when others => sevenSegment := "0001110"; -- f
        end case;
        return sevenSegment;
    end binary_to_ssd; -- end function "binary_to_ssd"

	 
	 -- begin function "binary_to_lcd"
    function binary_to_lcd (
            -- list all input here
            signal switch : unsigned(3 downto 0)
            )
        -- only one value can be return
        return unsigned is variable lcdDisplay : unsigned(7 downto 0);
    begin 
        case switch is 
            when "0000" => lcdDisplay := "00110000"; -- 0, active low i.e. 0:display & 1:no display
            when "0001" => lcdDisplay := "00110001"; -- 1
            when "0010" => lcdDisplay := "00110010"; -- 2
            when "0011" => lcdDisplay := "00110011"; -- 3 
            when "0100" => lcdDisplay := "00110100"; -- 4
            when "0101" => lcdDisplay := "00110101"; -- 5
            when "0110" => lcdDisplay := "00110110"; -- 6
            when "0111" => lcdDisplay := "00110111"; -- 7
            when "1000" => lcdDisplay := "00111000"; -- 8
            when "1001" => lcdDisplay := "00111001"; -- 9
            when "1010" => lcdDisplay := "01000001"; -- a
            when "1011" => lcdDisplay := "01000010"; -- b
            when "1100" => lcdDisplay := "01000011"; -- c
            when "1101" => lcdDisplay := "01000100"; -- d
            when "1110" => lcdDisplay := "01000101"; -- e
            when others => lcdDisplay := "01000110"; -- f
        end case;
        return lcdDisplay;
    end binary_to_lcd; -- end function "binary_to_lcd"
end LCD_SSD_display_pkg ; 

-- hexToSevenSegment.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hexToSevenSegment is
	port(
		hexNumber : in std_logic_vector(3 downto 0);
		sevenSegmentActiveLow, sevenSegmentActiveHigh : out std_logic_vector(6 downto 0)
	);
end hexToSevenSegment;

architecture arch of hexToSevenSegment is 
	signal sevenSegment : std_logic_vector(6 downto 0);
begin
	with hexNumber select 
		sevenSegment <= 	"1000000" when "0000", -- 0, active low i.e. 0:display & 1:no display
								"1111001" when "0001", -- 1
								"0100100" when "0010", -- 2
								"0110000" when "0011", -- 3 
								"0011001" when "0100", -- 4
								"0010010" when "0101", -- 5
								"0000010" when "0110", -- 6
								"1111000" when "0111", -- 7
								"0000000" when "1000", -- 8
								"0010000" when "1001", -- 9
								"0001000" when "1010", -- a
								"0000011" when "1011", -- b
								"1000110" when "1100", -- c
								"0100001" when "1101", -- d
								"0000110" when "1110", -- e
								"0001110" when others; -- f
	
	sevenSegmentActiveLow <= sevenSegment; -- Seven segment with Active Low
	sevenSegmentActiveHigh <= not sevenSegment; -- Seven segment with Active High
end arch;											 
											 
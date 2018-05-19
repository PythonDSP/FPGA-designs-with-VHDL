--hexToSevenSegment_testCircuit
-- testing circuit for hexToSevenSegment.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hexToSevenSegment_testCircuit is
	port(
		SW : in std_logic_vector(3 downto 0);
		HEX0, HEX1 : out std_logic_vector(6 downto 0)
	);
end hexToSevenSegment_testCircuit;

architecture arch of hexToSevenSegment_testCircuit is
begin
	-- Seven segment with Active Low
	hexToSevenSegment0 : entity work.hexToSevenSegment 
		 port map (hexNumber=>SW, sevenSegmentActiveLow=>HEX0);
			
	-- Seven segment with Active High
	hexToSevenSegment1 : entity work.hexToSevenSegment 
		 port map (hexNumber=>SW, sevenSegmentActiveHigh=>HEX1);
end arch;

											 
											 
											 

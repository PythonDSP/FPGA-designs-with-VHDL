--multiplexerEx.vhd

library ieee;
use ieee.std_logic_1164.all;

entity multiplexerEx is
	port( s: in std_logic_vector(1 downto 0);
			i0, i1, i2, i3: in std_logic;
			y: out std_logic
		); 
end multiplexerEx;

architecture dataflow of multiplexerEx is
begin
	 y <= i0 when s = "00" else
			  i1 when s = "01" else
			  i2 when s = "10" else
			  i3 when s = "11";
end dataflow;
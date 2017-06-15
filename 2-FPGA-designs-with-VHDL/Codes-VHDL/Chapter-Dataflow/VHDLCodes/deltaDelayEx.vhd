--deltaDelayEx.vhd

library ieee;
use ieee.std_logic_1164.all;

entity deltaDelayEx is
	port( x: inout std_logic;
			z: out std_logic
		); 
end deltaDelayEx;

architecture dataflow of deltaDelayEx is
signal s, w: std_logic;
begin
	z <= s;
	s <= x after 0 ns;
--	z <= x and w; -- error: multiple signal assignment not allowed
end dataflow;
		
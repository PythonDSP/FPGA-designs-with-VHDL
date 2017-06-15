--afterDelay.vhd

library ieee;
use ieee.std_logic_1164.all;

entity afterDelay is
	port( x : in std_logic;
			z: out std_logic
		); 
end afterDelay;

architecture dataflow of afterDelay is
signal s: std_logic;
begin
	z <= s after 1 ns;
	s <= x after 1 ns;
end dataflow;
		
-- deltaDelayEx2.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity deltaDelayEx2 is
port(
	x : inout std_logic;
	z : out std_logic
);
end entity;

architecture arch of deltaDelayEx2 is
	signal s : std_logic;
begin
	process(x)
	begin
		-- this line has no effect as value to z is assign below again
		z <= s; -- ignore by the compiler 
		s <= x after 2 ns;
		z <= x and s; -- only last assigment will be considered
	end process; 
end arch; 


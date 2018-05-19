-- latchEx.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity latchEx is 
port(
	a, b : in std_logic;
	large, small : out std_logic
);
end entity;

architecture arch of latchEx is
begin 
	process(a, b)
	begin 
		if (a > b) then 
			large <= a;
		elsif (a < b) then 
			small <= a;
		end if;
	end process;
end arch; 

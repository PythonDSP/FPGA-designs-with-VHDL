-- latchRemoveEx2.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity latchRemoveEx2 is 
port(
	a, b : in std_logic;
	large, small : out std_logic
);
end entity;

architecture arch of latchRemoveEx2 is
begin 
	process(a, b)
	begin 
		-- use default values : no need to define output in each if-elsif-else part
		large <= '0';
		small <= '0';
		if (a > b) then 
			large <= a;
		elsif (a < b) then 
			small <= a;
		end if;
	end process;
end arch; 

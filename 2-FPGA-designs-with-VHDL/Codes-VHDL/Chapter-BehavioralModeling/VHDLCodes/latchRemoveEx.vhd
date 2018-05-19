-- latchRemoveEx.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity latchRemoveEx is 
port(
	a, b : in std_logic;
	large, small : out std_logic
);
end entity;

architecture arch of latchRemoveEx is
begin 
	process(a, b)
	begin 
		-- define all outputs in each if-elsif statement
		-- also include the `else' statement
		if (a > b) then 
			large <= a;
			small <= b;
		elsif (a < b) then 
			large <= b;
			small <= a;		
		else 
			large <= '0';
			small <= '0';
		end if;
	end process;
end arch; 

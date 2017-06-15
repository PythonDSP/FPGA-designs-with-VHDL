--genericEx.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity genericEx is
	generic (
		N: integer := 2; -- define more generics here
		M: std_logic := '1' 
	);
	
	port(
		a, b: in std_logic_vector(N-1 downto 0);
		eq: out std_logic
	);
end genericEx;

architecture arch of genericEx is 
begin
	process(a,b)
	begin	
		if (a=b) then -- compare to numbers
			eq<='1'; -- set eq to 1, if equal
		else 
			eq<='0'; -- otherwise 0
		end if;
	end process;
end arch;
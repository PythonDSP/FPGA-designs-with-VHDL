-- typeConvertEx.vhd

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity typeConvertEx is
	port(
		a: in std_logic_vector(2 downto 0);
		b: in unsigned(2 downto 0);
		c: out std_logic_vector(2 downto 0)
	);
end typeConvertEx;

architecture arch of typeConvertEx is 
begin
--	c <= a and b; -- error: as a and b has different data type
	c <= a and std_logic_vector(b); -- type conversion
end arch;
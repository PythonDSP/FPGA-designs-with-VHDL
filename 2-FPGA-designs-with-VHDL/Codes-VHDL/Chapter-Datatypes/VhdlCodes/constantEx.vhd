-- constantEx.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity constantEx is
	port(
		a, b : in std_logic_vector(3 downto 0);
		z: out std_logic_vector(3 downto 0)
	);
end constantEx;

architecture arch of constantEx is 
	constant N : integer := 3;  -- define constant
	signal x : std_logic_vector(N downto 0); -- use constant
	signal y : std_logic_vector(2**N downto 0); -- use constant
begin
	-- use x and y here
	z <= a and b;
end arch;
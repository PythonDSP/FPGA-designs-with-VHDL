--genericInstantEx.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity genericInstantEx is
	port(
		x, y: in std_logic_vector(3 downto 0); -- 4 bit vector
		z: out std_logic
	);
end genericInstantEx;

architecture arch of genericInstantEx is 
begin
	compare4bit: entity work.genericEx
		generic map (N => 4) -- generic mapping for 4 bit
		port map (a=>x, b=>y, eq=>z); -- port mapping
end arch;
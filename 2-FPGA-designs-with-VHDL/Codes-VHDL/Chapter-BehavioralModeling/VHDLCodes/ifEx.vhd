--ifEx.vhd

library ieee;
use ieee.std_logic_1164.all;

entity ifEx is
	port( s: in std_logic_vector(1 downto 0);
			i0, i1, i2, i3: in std_logic;
			y: out std_logic
		); 
end ifEx;

architecture behave of ifEx is
begin
	process(s)
	begin
		if s = "00" then
			y <= i0;
		elsif s = "01" then
			y <= i1;
		elsif s = "10" then
			y <= i2;
		elsif s = "11" then 
			y <= i3;
		else 
			null; 
		end if;
	end process;
end behave;
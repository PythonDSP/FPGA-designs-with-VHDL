--caseEx.vhd

library ieee;
use ieee.std_logic_1164.all;

entity caseEx is
	port( s: in std_logic_vector(1 downto 0);
			i0, i1, i2, i3: in std_logic;
			y: out std_logic
		); 
end caseEx;

architecture behave of caseEx is
begin
	process(s)
	begin
		case s is
			when "00" =>
				y <= i0;
			when "01" =>
				y <= i1;
			when "10" =>
				y <= i2;
			when "11" =>
				y <= i3;
			when others =>
				null ;
		end case;
	end process;
end behave;
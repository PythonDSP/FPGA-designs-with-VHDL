-- D_FF.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity D_FF is
	port (
		clk, reset, en: in std_logic; -- en: enable
		d : in std_logic;  -- input to D flip flop
		q : out std_logic  -- output of D flip flop
	);
end D_FF;

architecture arch of D_FF is
begin
	process(clk, reset)
	begin
		if (reset = '1') then
			q <= '0';
		elsif (clk'event and clk = '1' and en = '1') then -- check for rising edge of clock
			q <= d;
		else  -- note that else block is not required
			null;  -- do nothing
		end if;
	end process;
end arch;
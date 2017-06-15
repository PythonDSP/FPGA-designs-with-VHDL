-- BasicDFF.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity BasicDFF is
	port (
		clk, reset: in std_logic;
		d : in std_logic;
		q : out std_logic
	);
end basicDFF;

architecture arch of basicDFF is
begin
	process(clk, reset)
	begin
		if (reset = '1') then
			q <= '0';
		elsif (clk'event and clk = '1') then -- check for rising edge of clock
			q <= d;
		else
			null;  -- do nothing
		end if;
	end process;
end arch;
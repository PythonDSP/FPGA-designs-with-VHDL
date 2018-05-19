-- clockTick.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clockTick is 
	-- M = 5000000, N = 23 for 0.1 s
	-- M = 50000000, N = 26 for 1 s
	-- M = 500000000, N = 29 for 10 s
	
	generic (M : integer := 5;  -- generate tick after M clock cycle
				N : integer := 3); -- -- N bits required to count upto M i.e. 2**N >= M
	port(
		clk, reset: in std_logic;
		clkPulse: out std_logic
	);
end clockTick;

architecture arch of clockTick is	
begin
	-- instantiate Mod-M counter
	clockPulse5cycle: entity work.modMCounter
		generic map (M=>M, N=>N)
		port map (clk=>clk, reset=>reset, complete_tick=>clkPulse);
end arch;
-- modMCounter_VisualTest.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modMCounter_VisualTest is 
	generic (
			M : integer := 12; -- count from 0 to M-1
			N : integer := 4   -- N bits required to count upto M i.e. 2**N >= M
	);
	port(
		CLOCK_50, reset: in std_logic;
		HEX0 : out std_logic_vector(6 downto 0);
		LEDR : out std_logic_vector (1 downto 0);
		LEDG : out std_logic_vector(N-1 downto 0)
	);
end modMCounter_VisualTest;

architecture arch of modMCounter_VisualTest is
	signal clk_Pulse1s: std_logic;
	signal count : std_logic_vector(N-1 downto 0);
begin
	-- clock 1 s
	clock_1s: entity work.clockTick
	generic map (M=>50000000, N=>26)
	port map (clk=>CLOCK_50, reset=>reset, 
					clkPulse=>clk_Pulse1s);
					
	LEDR(0) <= clk_Pulse1s; -- display clock pulse of 1 s
	
	-- modMCounter with 1 sec clock pulse
	modMCounter1s: entity work.modMCounter
	generic map (M=>M, N=>N)
	port map (clk=>clk_Pulse1s, reset=>reset, 
					complete_tick=>LEDR(1),count=>count);
					
	LEDG <= count; -- display count on green LEDs
	
	-- display count on seven segment
	hexToSevenSegment0 : entity work.hexToSevenSegment 
		 port map (hexNumber=>count, sevenSegmentActiveLow=>HEX0);
end;
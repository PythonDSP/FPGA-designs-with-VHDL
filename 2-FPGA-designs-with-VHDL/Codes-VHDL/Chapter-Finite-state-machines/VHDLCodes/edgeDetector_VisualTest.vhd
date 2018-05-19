-- edgeDetector_VisualTest.vhd
-- Moore and Mealy visual test

library ieee;
use ieee.std_logic_1164.all; 

entity edgeDetector_VisualTest is
port(
	CLOCK_50, reset : in std_logic;
	SW : in std_logic_vector(1 downto 0);
	LEDR: out std_logic_vector(1 downto 0)
);
end edgeDetector_VisualTest;

architecture arch of edgeDetector_VisualTest is 	
	signal clk_Pulse1s: std_logic;
begin	

	-- clock 1 s
	clock_1s: entity work.clockTick
	generic map (M=>50000000, N=>26)
	port map (clk=>CLOCK_50, reset=>reset, 
					clkPulse=>clk_Pulse1s);
					
	-- edge detector
	edgeDetector_VisualTest : entity work.edgeDetector
		port map (clk=>clk_Pulse1s, reset=>reset, level=>SW(1), 
					Moore_tick=> LEDR(0), Mealy_tick=> LEDR(1));
end arch; 
	
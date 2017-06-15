-- shift_register_visualTest.vhd

-- created by 	: 	Meher Krishna Patel
-- date					: 	22-Dec-16

-- SW[16:15] : used for control

library ieee;
use ieee.std_logic_1164.all;

entity shift_register_visualTest is
	generic (N :integer :=8);
	port(
		CLOCK_50, reset	: in std_logic;
		SW	: in std_logic_vector(16 downto 0);
		LEDR : out std_logic_vector (N-1 downto 0)
	);
end shift_register_visualTest;

architecture arch of shift_register_visualTest is
	signal clk_Pulse1s : std_logic;
begin
	-- clock 1 s
	clock_1s: entity work.clockTick
	generic map (M=>50000000, N=>26)
	port map (clk=>CLOCK_50, reset=>reset, 
					clkPulse=>clk_Pulse1s);
	
	-- shift_register testing with 1 sec clock pulse
	shift_register_1s: entity work.shift_register
	generic map (N=>N)
	port map (clk=>clk_Pulse1s, reset=>reset, 
					data => SW(N-1 downto 0), ctrl => (SW(16 downto 15)),
					q_reg=>LEDR);
end arch;
		

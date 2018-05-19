-- sequence_detector_tb.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity sequence_detector_tb is
end sequence_detector_tb; 

architecture arch of sequence_detector_tb is 
	constant T : time := 20 ps;
	signal clk, reset : std_logic; -- input
	signal x : std_logic;
	signal z_moore_glitch, z_moore_glitch_free : std_logic;
	signal z_mealy_glitch, z_mealy_glitch_free : std_logic;
begin 
	sequence_detector_unit : entity work.sequence_detector
				port map (clk=>clk, reset=>reset, x=>x,
				z_moore_glitch=>z_moore_glitch, z_moore_glitch_free => z_moore_glitch_free,
				z_mealy_glitch=>z_mealy_glitch, z_mealy_glitch_free => z_mealy_glitch_free
			);
				
	-- continuous clock
	process
	begin
		clk <= '0';
		wait for T/2;
		clk <= '1';
		wait for T/2;
	end process;
	
	-- reset = 1 for first clock cycle and then 0
	reset <= '1', '0' after T/2;
	
	x <= '0', '1' after T, '1' after 2*T, '0' after 3*T;   
end; 
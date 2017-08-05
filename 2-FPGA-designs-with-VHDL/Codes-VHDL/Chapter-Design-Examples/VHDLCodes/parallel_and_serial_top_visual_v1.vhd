-- parallel_and_serial_top_visual_v1.vhd

library ieee;
use ieee.std_logic_1164.all; 

library work;

entity parallel_and_serial_top_visual_v1 is 
    port
    (
        reset :  in  std_logic;
        clock_50 :  in  std_logic;
		  -- received signals are displayed on LEDG
        LEDG :  out  std_logic_vector(3 downto 0); 
		  -- transmitted signals are displayed on LEDG
        LEDR :  out  std_logic_vector(3 downto 0)
    );
end parallel_and_serial_top_visual_v1;

architecture bdf_type of parallel_and_serial_top_visual_v1 is 
	signal  clk :  std_logic;
	signal  count :  std_logic_vector(3 downto 0);
	signal  dout :  std_logic;
	signal  e_tick :  std_logic;
	signal  not_e_tick :  std_logic;
begin 

-- register is not empty i.e. read data on this tick
not_e_tick <= not(e_tick);
-- generated count on LEDG, whereas received count on LEDG
LEDR <= count;

-- parallel and serial test
unit_p_and_s : entity work.parallel_and_serial_top_v1
generic map(N => 4)
port map(clk => clk,
         reset => reset,
         LEDG => count,
         LEDR => dout
			);
						
	
-- modMCounter to generate clock-tick and data (i.e. count) for transission
unit_counter : entity work.modMCounter
generic map(M => 9,
            N => 4
            )
port map(clk => e_tick,
         reset => reset,
         count => count);


-- clock tick to see outputs on LEDs
unit_clkTick : entity work.clocktick
generic map(M => 5000000,
            N => 23
            )
port map(clk => clock_50,
         reset => reset,
         clkpulse => clk);

end bdf_type;
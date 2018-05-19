-- parallel_and_serial_top_visual_v1.vhd

library ieee;
use ieee.std_logic_1164.all; 

library work;

entity parallel_and_serial_top_visual_v1 is 
    port
    (
        reset :  in  std_logic;
        CLOCK_50 :  in  std_logic;
		  -- generated count displayed on LEDG
        LEDG :  out  std_logic_vector(3 downto 0); 
		  -- received count displayed on LEDR
        LEDR :  out  std_logic_vector(3 downto 0)
    );
end parallel_and_serial_top_visual_v1;

architecture arch of parallel_and_serial_top_visual_v1 is 
	signal  clk :  std_logic;
begin 

-- parallel and serial conversion test
unit_p_and_s : entity work.parallel_and_serial_top_v1
generic map(M => 7,
				N => 4)
port map(clk => clk,
         reset => reset,
         data_in => LEDR,
         data_out => LEDG
	);
			
			
-- clock tick to see outputs on LEDs
unit_clkTick : entity work.clocktick
generic map(M => 5000000,
            N => 23
            )
port map(clk => clock_50,
         reset => reset,
         clkpulse => clk);

end arch;
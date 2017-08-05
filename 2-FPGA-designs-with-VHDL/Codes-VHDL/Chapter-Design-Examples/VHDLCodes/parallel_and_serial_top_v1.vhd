-- parallel_and_serial_top_v1.vhd

library ieee;
use ieee.std_logic_1164.all; 

library work;

entity parallel_and_serial_top_v1 is 
	generic (M : integer := 11; -- count upto M
				N : integer := 4); -- N bits required to count to M
    port
    (
        reset :  in  std_logic;
        clk :  in  std_logic;
        data_out :  out  std_logic_vector(3 downto 0); 
        data_in :  out  std_logic_vector(3 downto 0)
    );
end parallel_and_serial_top_v1;

architecture arch of parallel_and_serial_top_v1 is 
	signal  count :  std_logic_vector(3 downto 0);
	signal  dout :  std_logic;
	signal  e_tick :  std_logic;
	signal  not_e_tick :  std_logic;
begin 

-- register is not empty i.e. read data on this tick
not_e_tick <= not(e_tick);
-- generated count on data_out, whereas received count on data_out
data_in <= count;

-- parallel to serial conversion
unit_p_to_s : entity work.parallel_to_serial
generic map(N => N)
port map(clk => clk,
         reset => reset,
         data_in => count,
         data_out => dout,
         empty_tick => e_tick);
			
			
-- serial to parallel conversion
unit_s_to_p : entity work.serial_to_parallel
generic map(N => N)
port map(clk => clk,
         reset => reset,
         in_tick => not_e_tick,
         din => dout,
         dout => data_out);

			
-- modMCounter to generate data (i.e. count) for transmission
unit_counter : entity work.modMCounter
generic map(M => M,
            N => N
            )
port map(clk => e_tick,
         reset => reset,
         count => count);

end arch;
-- modMCounter_tb.vhd

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modMCounter_tb is
end modMCounter_tb;


architecture arch of modMCounter_tb is
    constant M : integer := 10;
    constant N : integer := 4;
    constant T : time := 20 ns; 

    signal clk, reset : std_logic;  -- input
    signal complete_tick : std_logic; -- output
    signal count : std_logic_vector(N-1 downto 0);  -- output
begin

    modMCounter_unit : entity work.modMCounter
        generic map (M => M, N => N)
        port map (clk=>clk, reset=>reset, complete_tick=>complete_tick,
                    count=>count);

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

end arch;
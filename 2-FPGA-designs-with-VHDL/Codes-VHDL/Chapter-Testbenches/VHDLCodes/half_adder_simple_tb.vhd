-- half_adder_simple_tb.vhd

library ieee;
use ieee.std_logic_1164.all;


entity half_adder_simple_tb is
end half_adder_simple_tb;

architecture tb of half_adder_simple_tb is
    signal a, b : std_logic;  -- inputs 
    signal sum, carry : std_logic;  -- outputs
begin
    -- connecting testbench signals with half_adder.vhd
    UUT : entity work.half_adder port map (a => a, b => b, sum => sum, carry => carry);

    -- inputs
    -- 00 at 0 ns
    -- 01 at 20 ns, as b is 0 at 20 ns and a is changed to 1 at 20 ns
    -- 10 at 40 ns
    -- 11 at 60 ns
    a <= '0', '1' after 20 ns, '0' after 40 ns, '1' after 60 ns;
    b <= '0', '1' after 40 ns;        
end tb ;

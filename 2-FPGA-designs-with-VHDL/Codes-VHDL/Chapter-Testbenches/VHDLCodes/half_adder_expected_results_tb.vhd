-- half_adder_expected_results_tb.vhd.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity half_adder_expected_results_tb is
end half_adder_expected_results_tb;

architecture tb of half_adder_expected_results_tb is
    
    signal a, b : std_logic; -- input
    signal sum, carry : std_logic; -- output

begin
    UUT : entity work.half_adder port map (a => a, b => b, sum => sum, carry => carry);


    tb1 : process
        constant period: time := 20 ns;
        constant n: integer := 2;
    begin
        for i in  0 to 2**n - 1 loop
            (a, b) <= to_unsigned(i,n);

            wait for period;

            assert ( 
                        (sum = (a xor b)) and 
                        (carry = (a and b)) 
                    )
            report " failed " & " for input a = " & std_logic'image(a) & " and b = " & std_logic'image(b)
            severity error;
        end loop;
        wait;
    end process; 

end tb ; -- tb

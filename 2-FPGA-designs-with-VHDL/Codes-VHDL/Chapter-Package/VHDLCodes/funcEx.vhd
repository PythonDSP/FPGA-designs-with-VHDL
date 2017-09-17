-- funcEx.vhd

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity funcEx is
    generic ( N: integer := 2);
    port (
            x, y : in unsigned(N-1 downto 0);
            s : out unsigned (N-1 downto 0)
        );
end funcEx;

architecture arch of funcEx is
    --sum2Num function: add and subtract two numbers
    function sum2num(
                    -- list all input here
                    signal a: in unsigned(N-1 downto 0); 
                    signal b: in unsigned(N-1 downto 0)
                )
                -- only one value can be return
                return unsigned is variable sum : unsigned(N-1 downto 0);
        begin
         sum := a + b;
         return sum;
     end sum2num; -- function ends
begin   
    s <= sum2num(a=>x, b=>y); -- function call
end arch;
--comparator2Bit.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity comparator2Bit is
  port(
    a, b : in std_logic_vector(1 downto 0);
    eq : out std_logic
  ); 
end comparator2Bit;

architecture dataflow2Bit of comparator2Bit is
  signal s: std_logic_vector(3 downto 0); 
begin
  s(0) <= (not a(1)) and (not a(0)) and (not b(1)) and (not b(0));
  s(1) <= (not a(1)) and a(0) and (not b(1)) and b(0);
  s(2) <= a(1) and (not a(0)) and b(1) and (not b(0));
  s(3) <= a(1) and a(0) and b(1) and b(0);
  
  eq <= s(0) or s(1) or s(2) or s(3);
end dataflow2Bit;  
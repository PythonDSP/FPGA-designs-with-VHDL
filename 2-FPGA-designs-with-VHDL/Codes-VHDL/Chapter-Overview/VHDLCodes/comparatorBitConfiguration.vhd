--comparatorBitConfiguration.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity comparatorBitConfiguration is
  port(
    a, b : in std_logic_vector(1 downto 0);
    eq : out std_logic
  ); 
end comparatorBitConfiguration;


architecture comparator1Bit of comparatorBitConfiguration is
  signal s0, s1: std_logic; 
begin
  s0 <= (not a(0)) and (not b(0));
  s1 <= a(0) and b(0);
  
  eq <= s0 or s1;
end comparator1Bit;


architecture comparator2Bit of comparatorBitConfiguration is
  signal s: std_logic_vector(3 downto 0); 
begin
  s(0) <= (not a(1)) and (not a(0)) and (not b(1)) and (not b(0));
  s(1) <= (not a(1)) and a(0) and (not b(1)) and b(0);
  s(2) <= a(1) and (not a(0)) and b(1) and (not b(0));
  s(3) <= a(1) and a(0) and b(1) and b(0);
  
  eq <= s(0) or s(1) or s(2) or s(3);
end comparator2Bit;  

configuration comp1Bit of comparatorBitConfiguration is
  for comparator1Bit
  end for;
end comp1Bit;

configuration comp2Bit of comparatorBitConfiguration is
  for comparator2Bit
  end for;
end comp2Bit;

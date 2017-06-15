--comparator2BitStruct.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity comparator2BitStruct is
  port(
    a, b : in std_logic_vector(1 downto 0);
    eq : out std_logic
  ); 
end comparator2BitStruct;

architecture structure of comparator2BitStruct is
  signal s0, s1: std_logic; 
begin
  eq_bit0: entity work.comparator1bit
    port map (x=>a(0), y=>b(0), eq=>s0);
  eq_bit1: entity work.comparator1bit
    port map (x=>a(1), y=>b(1), eq=>s1);
      
  eq <= s0 and s1;
end structure;  
--comparator2BitProcess2.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity comparator2BitProcess2 is
  port(
    a, b : in std_logic_vector(1 downto 0);
    eq : out std_logic
  ); 
end comparator2BitProcess2;

architecture procEx2 of comparator2BitProcess2 is
  signal s0, s1: std_logic;
begin
  process(a,b)
  begin 
    if (a(0)=b(0))then
      s0 <= '1';
    else
      s0<='0';
    end if;      
  end process;
  
  process(a,b)
  begin 
    if (a(1)=b(1)) then
      s1 <= '1';
    else
      s1<='0';
    end if;      
  end process;
  
  eq <= s0 and s1;
end procEx2;  
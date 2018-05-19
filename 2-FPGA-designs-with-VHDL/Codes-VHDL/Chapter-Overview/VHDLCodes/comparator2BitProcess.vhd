--comparator2BitProcess.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity comparator2BitProcess is
  port(
    a, b : in std_logic_vector(1 downto 0);
    eq : out std_logic
  ); 
end comparator2BitProcess;

architecture procEx of comparator2BitProcess is
begin
  process(a,b)
  begin 
    if (a(0)=b(0)) and (a(1)=b(1)) then
      eq <= '1'; -- "1" is wrong; as ' and " has different meaning
    else
      eq<='0';
    end if;      
  end process;
end procEx;  
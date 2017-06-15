--packageEx.vhd

library ieee; 
use ieee.std_logic_1164.all;

package packageEx is
  component comparator1Bit 
     port(
        x, y : in std_logic;
        eq : out std_logic
     ); 
    end component;
end package;
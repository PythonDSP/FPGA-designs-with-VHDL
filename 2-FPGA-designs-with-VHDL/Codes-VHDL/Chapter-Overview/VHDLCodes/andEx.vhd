--andEx.vhd

library ieee;
use ieee.std_logic_1164.all;

entity andEx is
  port(
    x, y : in std_logic;
    z: out std_logic
  );
end andEx;

architecture arch of andEx is
begin
  z <= x and y;
end arch;
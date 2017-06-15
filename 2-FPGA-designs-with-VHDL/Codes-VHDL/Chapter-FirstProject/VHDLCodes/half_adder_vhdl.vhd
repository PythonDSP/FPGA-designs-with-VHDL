-- half_adder_vhdl.vhd

library ieee;
use ieee.std_logic_1164.all;

entity half_adder_vhdl is
port(
	a, b : in std_logic;
	sum, carry : out std_logic
);
end half_adder_vhdl;


architecture arch of half_adder_vhdl is
begin
	sum <= a xor b;
	carry <= a and b;
end arch; 
	
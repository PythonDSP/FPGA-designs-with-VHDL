--multiplexerVhdl.vhd

library ieee;
use ieee.std_logic_1164.all;

entity multiplexerVhdl is
	port( s: in std_logic_vector(1 downto 0);
			i0, i1, i2, i3: in std_logic;
			y: out std_logic
		); 
end multiplexerVhdl;

architecture dataflow of multiplexerVhdl is
begin
	with s select
	y <=  i0 when "00",
			  i1 when "01",
			  i2 when "10",
			  i3 when "11", 
			  -- use 'when others' to avoid modelsim error 
			  -- i.e. 'cover only 4 out of 81 cases', which occurs due to
			  -- the logics which can not be synthesized e.g. Forcing unknown 'X' etc. 
			  unaffected when others;
end dataflow;
-- sequence_detector.vhd
-- non-overlap detection : 110
library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sequence_detector is
port(
	clk, reset : in std_logic;
	x : in std_logic; 
	z_mealy_glitch, z_moore_glitch : out std_logic;
	z_mealy_glitch_free, z_moore_glitch_free : out std_logic
);
end entity;

architecture arch of sequence_detector is
	-- Moore
	type stateType_moore is (zero_moore, one_moore, two_moore, three_moore);
	signal state_reg_moore, state_next_moore : stateType_moore; 
	
	-- Mealy
	type stateType_mealy is (zero_mealy, one_mealy, two_mealy);
	signal state_reg_mealy, state_next_mealy : stateType_mealy; 
	
	signal z_moore, z_mealy : std_logic;
begin 
	process(clk, reset)
	begin 
		if reset = '1' then
			state_reg_moore <= zero_moore; 
			state_reg_mealy <= zero_mealy; 
		elsif rising_edge(clk) then
			state_reg_moore <= state_next_moore;
			state_reg_mealy <= state_next_mealy;
		end if; 
	end process; 
	
	-- Moore
	process(state_reg_moore, x) 
	begin 
		z_moore <= '0'; 
		state_next_moore <= state_reg_moore; 
		case state_reg_moore is 
			when zero_moore => 
				if x = '1' then 
					state_next_moore <= one_moore;
				end if; 
			when one_moore => 
				if x = '1' then 
					state_next_moore <= two_moore;
				end if;
			when two_moore =>
				if x = '0' then
					state_next_moore <= three_moore; 
				else 
					state_next_moore <= zero_moore;
				end if;
			when three_moore =>
				z_moore <= '1';
				if x = '0' then 
					state_next_moore <= zero_moore; 
				else
					state_next_moore <= one_moore;
				end if;
		end case;
	end process; 
	
	-- Mealy
	process(state_reg_mealy, x) 
	begin 
		z_mealy <= '0'; 
		state_next_mealy <= state_reg_mealy; 
		case state_reg_mealy is 
			when zero_mealy => 
				if x = '1' then 
					state_next_mealy <= one_mealy;
				end if; 
			when one_mealy => 
				if x = '1' then 
					state_next_mealy <= two_mealy;
				end if;
			when two_mealy =>
				state_next_mealy <= zero_mealy;
				if x = '0' then
					z_mealy <= '1';
				end if;
		end case;
	end process; 
	
	-- D-FF to remove glitches
	process(clk, reset)
	begin
		if reset = '1' then 
			z_mealy_glitch_free <= '0';
			z_moore_glitch_free <= '0';
		elsif rising_edge(clk) then
			z_mealy_glitch_free <= z_mealy; 
			z_moore_glitch_free <= z_moore;
		end if; 
	end process; 
	
z_mealy_glitch <= z_mealy; 
z_moore_glitch <= z_moore;
end architecture; 
	
			
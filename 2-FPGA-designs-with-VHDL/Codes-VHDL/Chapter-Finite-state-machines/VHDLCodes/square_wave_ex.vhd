-- square_wave_ex.vhd

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity square_wave_ex is
generic(
	N : natural := 4; -- Number of bits to represent the time
	on_time : signed(3 downto 0) := "0101";
	off_time : signed(3 downto 0) := "0011"
);
port(
	clk, reset : in std_logic;
	s_wave : out std_logic
);
end entity;

architecture arch of square_wave_ex is
	type stateTypeMoore is (onState, offState);
	signal state_reg, state_next : stateTypeMoore;
	signal t : signed(N-1 downto 0) := (others => '0');
begin 
	process(clk, reset) 
	begin 
		if reset = '1' then 
			state_reg <= offState; 
		elsif rising_edge(clk) then
			state_reg <= state_next;
		end if;
	end process; 
	
	process(clk, reset)
	begin 
		if state_reg /= state_next then 
			t <= (others => '0');
		else
			t <= t + 1;
		end if;
	end process; 

	process(state_reg, t)
	begin 
		case state_reg is
			when offState =>
				s_wave <= '0'; 
				if t = off_time - 1 then 
					state_next <= onState;
				else
					state_next <= offState; 
				end if;
			when onState =>
				s_wave <= '1'; 
				if t = on_time - 1 then
					state_next <= offState;
				else
					state_next <= onState;
				end if;
		end case;
	end process;
end arch; 

-- counterEx.vhd
-- count upto M

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counterEx is 
generic( 
	M : natural := 6;
	N : natural := 4 -- N bits are required for M
	);
port(
	clk, reset : in std_logic;
	out_moore : out std_logic_vector(N-1 downto 0)
);
end entity; 

architecture arch of counterEx is 
	type stateType_moore is (start_moore, count_moore);
	signal state_moore_reg, state_moore_next : stateType_moore;
	signal count_moore_reg, count_moore_next : unsigned(N-1 downto 0);
begin 
	process(clk, reset)
	begin 
		if reset = '1' then
			state_moore_reg <= start_moore;
			count_moore_reg <= (others => '0');
		elsif rising_edge(clk) then
			state_moore_reg <= state_moore_next;
			count_moore_reg <= count_moore_next;
		end if; 
	end process;
	
	process(count_moore_reg, state_moore_reg)
	begin 
		case state_moore_reg is
			when start_moore =>
				count_moore_next <= (others => '0');
				state_moore_next <= count_moore;
			when count_moore =>
				count_moore_next <= count_moore_reg  + 1;
				if (count_moore_reg  + 1) = M - 1 then
					state_moore_next <= start_moore;
				else
					state_moore_next <= count_moore;
				end if;
		end case;
	end process; 
	
	
	out_moore <= std_logic_vector(count_moore_reg);
end arch; 

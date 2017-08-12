-- binaryCounter.vhd
library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binaryCounter is
	generic (
			N : integer := 3 	-- N-bit binary counter
	);
	
	port(
			clk, reset : in std_logic;
			complete_tick : out std_logic; 
			count : out std_logic_vector(N-1 downto 0)
	);
end binaryCounter;


architecture arch of binaryCounter is
	constant MAX_COUNT : integer := 2**N - 1; -- maximum count for N bit
	signal count_reg, count_next : unsigned(N-1 downto 0);
begin
	process(clk, reset)
	begin
		if reset = '1' then 
			count_reg <= (others=>'0');  -- set count to 0 if reset
		elsif	clk'event and clk='1' then
			count_reg <= count_next;  -- assign next value of count
		else  -- note that else block is not required
			null;
		end if;
	end process;
	
	count_next <= count_reg+1;  -- increase the count
	
	-- Generate 'tick' on each maximum count
	complete_tick <= '1' when count_reg = MAX_COUNT else '0';  
	
	count <= std_logic_vector(count_reg);  -- assign value to output port
end arch;
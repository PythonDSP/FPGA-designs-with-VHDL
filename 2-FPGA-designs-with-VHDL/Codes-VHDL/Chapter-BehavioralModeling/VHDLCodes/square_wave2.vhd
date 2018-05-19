-- square_wave2.vhd

-- High : on_duration * time_scale
-- Low  : off_duration * time_scale

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity square_wave2 is
port(
	clk, reset : in std_logic; 
	on_duration, off_duration : in unsigned(2 downto 0);
	out_wave : out std_logic
);
end entity; 

architecture arch of square_wave2 is
	signal count_on_reg, count_on_next, count_off_reg, count_off_next : unsigned(2 downto 0);
	constant time_scale : unsigned(7 downto 0) := unsigned(to_signed(2, 8));
begin
	process(clk, reset)
	begin
		if reset = '1' then 
			count_on_reg <= (others => '0');
			count_off_reg <= (others => '0');
		elsif rising_edge(clk) then
			count_on_reg <= count_on_next;
			count_off_reg <= count_off_next;
		end if;
	end process; 
	
	process(count_on_reg, count_off_reg)
	begin
		count_on_next <= (others => '0');
		count_off_next <= (others => '0');
		out_wave <= '0';
		if count_on_reg < on_duration * time_scale then
			out_wave <= '1';
			count_on_next <= count_on_reg + 1;
			count_off_next <= count_off_reg;
		elsif count_off_reg < off_duration * time_scale - 1 then
			out_wave <= '0';
			count_on_next <= count_on_reg;
			count_off_next <= count_off_reg + 1;
		end if;
	end process; 
end arch; 

				
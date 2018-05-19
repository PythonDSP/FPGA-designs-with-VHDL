-- square_wave.vhd

-- High : on_duration * time_scale
-- Low  : off_duration * time_scale

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity square_wave is
port(
	clk, reset : in std_logic; 
	on_duration, off_duration : in unsigned(2 downto 0);
	out_wave : out std_logic
);
end entity; 

architecture arch of square_wave is
	signal count_on, count_off : unsigned(2 downto 0);
	constant time_scale : unsigned(7 downto 0) := unsigned(to_signed(2, 8));
begin
	process(clk, reset)
	begin
		if reset = '1' then 
			out_wave <= '0';
			count_on <= (others => '0');
			count_off <= (others => '0');
		elsif rising_edge(clk) then
			if count_on < on_duration * time_scale then
				out_wave <= '1';
				count_on <= count_on + 1;
			elsif count_off < off_duration * time_scale - 1 then
				out_wave <= '0';
				count_off <= count_off + 1;
			else
				count_on <= (others => '0');
				count_off <= (others => '0');
			end if;
		end if;
	end process; 
end arch; 

				
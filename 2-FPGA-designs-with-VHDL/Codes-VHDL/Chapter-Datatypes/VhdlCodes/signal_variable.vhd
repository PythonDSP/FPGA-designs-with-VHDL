-- signal_variable.vhd
library ieee; 
use ieee.std_logic_1164.all;

entity signal_variable is 
port (
	clk : in std_logic;
	dout1 : out std_logic
);
end entity;

architecture arch of signal_variable is
	signal a, b, c : std_logic := '0';
begin
	process(clk)  -- process with signals only
	begin 
		if (clk'event and clk='1') then
			a <= '1';
			b <= a;  -- b will be '1' in next clock cycle
		end if;
	end process; 
	
	process(clk)  -- process with variable
		variable v : std_logic := '0';
	begin 
		if (clk'event and clk='1') then
			v := '1';
			c <= v;  -- c will be '1' immidiately
		end if;
	end process;

	dout1 <= c; -- signal can be used anywhere in the code
--	-- error : variable can not be used outside it's process block
--	dout1 <= v; 
end architecture;
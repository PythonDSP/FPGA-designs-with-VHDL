-- manchester_code2.vhd

library ieee;
use ieee.std_logic_1164.all;

entity manchester_code2 is
port(
	clk, din : in std_logic;
	dout : out std_logic
);
end entity;

architecture arch of manchester_code2 is
	signal dout_reg, dout_next : std_logic;
begin 
	process(clk)
	begin 
		-- both rising and falling edge are used as manchester_code uses
		-- both edges of the clock to generate output. 
		
		-- since both edges are used, therefore output will be delayed by
		-- half cycle. 
		
		-- if value is updated at +ve half cycle and `+ve edge' is used to remove
		-- glitches, then there will be `one cycle delay' 
		
		-- if value is updated at +ve half cycle and `-ve edge' is used to remove
		-- glitches, then there will be `half cycle delay' 
		
        -- Note that the design can not be synthesize as both edge are used in single conditional statement
		if rising_edge(clk) or falling_edge(clk) then
--		if (clk'event) then  -- use this or above : both have same meaning
			dout_reg <= dout_next;
		end if;
	end process; 
	
	dout_next <= clk xor din; 
	dout <= dout_reg; 
end arch; 

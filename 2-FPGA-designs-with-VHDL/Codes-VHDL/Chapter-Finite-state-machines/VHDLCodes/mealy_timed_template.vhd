-- mealy_timed_template.vhd

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mealy_timed_template is 
generic (
	param1 : std_logic_vector(...) := <value>;
	param2 : unsigned(...) := <value>
	);
port (
	clk, reset : in std_logic;
	input1, input2, ... : in std_logic_vector(...);
	output1, output2, ... : out signed(...)
);
end entity; 

architecture arch of mealy_timed_template is 
	type stateType is (s0, s1, s2, s3, ...);
	signal state_reg, state_next : stateType; 
	
	-- timer
	constant T1 : natural := <value>;
	constant T2 : natural := <value>;
	constant T3 : natural := <value>;
	...
	signal t : natural;
begin 
	-- state register : state_reg
	-- This process contains sequential part and all the D-FF are 
	-- included in this process. Hence, only 'clk' and 'reset' are 
	-- required for this process. 
	process(clk, reset)
	begin
		if reset = '1' then
			state_reg <= s1;
		elsif (clk) then
			state_reg <= state_next;
		end if;
	end process; 
	
	-- timer 
	process(clk, reset)
	begin 
		if reset = '1' then
			t <= 0;
		elsif rising_edge(clk) then
			if state_reg /= state_next then  -- state is changing
				t <= 0;
			else
				t <= t + 1; 
			end if; 
		end if; 
	end process;
	
	-- next state logic and outputs
	-- This is combinational of the sequential design, 
	-- which contains the logic for next-state and outputs
	-- include all signals and input in sensitive-list except state_next
	process(input1, input2, ..., state_reg) 
	begin 
		state_next <= state_reg; -- default state_next
		-- default outputs
		output1 <= <value>;
		output2 <= <value>;
		...
		case state_reg is
			when s0 =>
				if <condition> and t >= T1-1 then -- if (input1 = '01') then
					output1 <= <value>;
					output2 <= <value>;
					...
					state_next <= s1; 
				elsif <condition> and t >= T2-1 then  -- add all the required conditionstions
					output1 <= <value>;
					output2 <= <value>;
					...
					state_next <= ...; 
				else -- remain in current state
					output1 <= <value>;
					output2 <= <value>;
					...
					state_next <= s0; 
				end if;
			when s1 =>
				...
		end case;
	end process;  
		
	-- optional D-FF to remove glitches
	process(clk, reset)
	begin 
		if reset = '1' then 
			new_output1 <= ... ;
			new_output2 <= ... ;
		elsif rising_edge(clk) then
			new_output1 <= output1; 
			new_output2 <= output2; 
		end if;
	end process; 
end architecture; 
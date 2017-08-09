-- scalarTypeEx.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity scalarTypeEx is
	port(
		clk : in std_logic;
		a, b : in integer range 1 to 5; 
		x : inout integer; 
		
		pA : out integer -- output for process block
	);
end scalarTypeEx;

architecture arch of scalarTypeEx is 
	type voltage_range is range -5 to 5; -- user-defined integer data type
	signal v1, v2, v3, v4 : voltage_range := 0; -- singal of user-defined integer data type
	
	type stateTypes is (posState, negState); -- enumerate data type
	signal currentState : stateTypes; -- signal of enumerate data type
begin

	v1 <= 3;
--	v2 <= 7;  -- error : outside range

	process(clk)
	begin 
		v2 <= v2 + 1;
	end process;
	
	-- enumerate example
	process(x)
	begin
		if(x >= 0) then -- x = 3
			currentState <= posState; -- true
		else 
			currentState <= negState;
		end if;
	end process; 
	
	process(currentState)
	begin
		if (currentState = posState) then -- true
			pA <= 1; -- pA = 1
		else
			pA <= -1;
		end if;
	end process;

end arch;

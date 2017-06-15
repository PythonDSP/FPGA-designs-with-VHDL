-- scalarTypeEx.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity scalarTypeEx is
	port(
		a, b : in integer; -- let a=5, b=2
		x : inout integer; 
		w, y, z : out integer; 
		
		pA : out integer -- output for process block
	);
end scalarTypeEx;

architecture arch of scalarTypeEx is 
	type stateTypes is (posState, negState); -- enumerate data type
	signal currentState : stateTypes; -- signal of enumerate data type
begin

	-- integer example
	w <= a + b; -- 7
	x <= a - b; -- 3
	y <= a * b; -- 10
	z <= a / b; -- 2
	
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

-- scalarTypeEx.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity scalarTypeEx is
	port(
		clk : in std_logic;
		a, b : in integer range 1 to 5; -- input values can be 1 to 5 only
		c : out integer range 1 to 5;
		x : inout integer; 
		
		pA : out integer -- output for process block
	);
end scalarTypeEx;

architecture arch of scalarTypeEx is 
	-- integer type : range 1 to 5
	type voltage_range is range 1 to 5; -- user-defined integer data type
	signal v1, v2, v3, v4 : voltage_range := 1; -- signal of user-defined integer data type
	
	-- integer type : range 10 to 0
	type time_range is range 10 downto 0; -- user-defined integer data type
	signal t1, t2 : time_range := 0; -- signal of user-defined integer data type
	
	-- enumerated type
	type stateTypes is (posState, negState); -- enumerate data type
	signal currentState : stateTypes; -- signal of enumerate data type
begin

-- ######### Integer Example ###############
	v1 <= 3;
--	v2 <= 7;  -- error : outside range

	c <= a + b; 
--	-- a,b and v3 have same range, but they are of different type 
--	v3 <= a + b; -- error 
	
	process(clk)
	begin 
		v3 <= v1 + 1;  -- updating v3 using v1
--		v4 <= v1 + 10; -- simulator will catch error (not the compiler)
	end process;
	
-- ######### Enumerate Example ###############
	process(x)
	begin
		if(x >= 0) then -- let x = 3
			currentState <= posState; -- true
		else 
			currentState <= negState;
		end if;
	end process; 
end arch;

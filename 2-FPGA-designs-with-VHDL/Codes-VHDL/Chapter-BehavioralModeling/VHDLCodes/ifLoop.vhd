--ifLoop.vhd (-- This code is for simulation purpose only)
-- ideally positive or negative clock edge must be used; which will be discussed later.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ifLoop is
  generic ( N: integer := 3);
	port(  clk : in std_logic; -- clock: increase count on each clk
	       x: in unsigned(N downto 0); -- count upto x
			   z: out unsigned(N downto 0) -- display count
		  ); 
end ifLoop;

architecture behave of ifLoop is
	signal count : unsigned(N downto 0):= (others => '0'); -- count signal
	type stateType is (continueState, stopState); --states to continue or stop the count
	signal currentState : stateType;
begin
	process(clk, currentstate, count)
	begin
		if (count <= x) then -- check whether count is completed till x
			currentState <= continueState; -- if not continue the count
		else
			currentState <= stopState; -- else stop further count
		end if;
	end process;
	
	--if we put `count' in below sensitivity list, 
	-- then below process block will work as infinite loop
	process(clk, currentstate) 
	begin
		if (currentState = continueState) then 
			count <= count + 1; -- increase count by 1 if continueState
		else 
		  count <=(others => '0');	-- else set count to zero i.e. for stopState	  
		end if;
	end process;	
	z <= count;	-- show the count on output
end behave;
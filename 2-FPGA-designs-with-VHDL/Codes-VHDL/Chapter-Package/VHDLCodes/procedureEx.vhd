--procedureEx.vhd

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity procedureEx is
	generic ( N: integer := 2);
	port (
			x, y : in unsigned(N-1 downto 0);
			s, d : out unsigned (N-1 downto 0)
		);
end procedureEx;

architecture arch of procedureEx is
signal p: unsigned(N-1 downto 0);

--sum2Num procedure: add and subtract two numbers
procedure sum2num(signal a: in unsigned(N-1 downto 0); 
						signal b: in unsigned(N-1 downto 0);
						signal sum, diff : out unsigned (N-1 downto 0)) is 
	begin
	 sum <= a + b;
	 diff <= a - b;
 end sum2num; -- procedure ends
begin	
	sum2num(a=>x,b=>y,diff=>p,sum=>s); -- procedure call
	d <= p; -- assing signal p to d
end arch;
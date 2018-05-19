--myPackage.vhd

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package myPackage is
	-- contant value to add 1 i.e. num1 + 1 
	constant S : signed (3 downto 0) := "0001";
	
	-- add two number i.e. num1 + num2
	procedure sum2num(signal a: in signed(3 downto 0); 
							signal b: in signed(3 downto 0);
							signal sum : out signed (3 downto 0));
							
	-- singals and types for ifLoop
	signal f : unsigned(2 downto 0):= (others => '0');
	type stateType is (startState, continueState, stopState);
end package;

package body myPackage is
	
	-- procedure for adding two numbers i.e. num1 + num2
	procedure sum2num(signal a: in signed(3 downto 0); 
							signal b: in signed(3 downto 0);
							signal sum : out signed (3 downto 0)) is 
		begin
		 sum <= a + b;
	 end sum2num;
end myPackage;
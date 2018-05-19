-- compositeTypeEx.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity compositeTypeEx is
	port(
		a, b: in std_logic;
		c, d: in std_logic_vector(1 downto 0);
		z : out std_logic_vector(1 downto 0); 
		
		rY : out std_logic;
		rZ : out std_logic_vector(1 downto 0)
	);
end compositeTypeEx;

architecture arch of compositeTypeEx is 
	type newArray is array (0 to 1) of std_logic; -- create Array
	signal arrValue : newArray; -- signal of Array type
	
	type newRecord is -- create Record
	record
		d1, d2 : std_logic;
		v1, v2: std_logic_vector(1 downto 0);
	end record; 
	signal recordValue : newRecord; -- signal of Record type
begin
	-- array example
	arrValue(0) <= a; -- assign value to array
	arrValue(1) <= b;
	
	z <= arrValue(0) & arrValue(1);
	
	-- record example
	recordValue.d1 <= a; -- assign value to record
	recordValue.d2 <= b;
	
	recordValue.v1 <= c;
	recordValue.v2 <= d;
	
	rY <= recordValue.d1 and recordValue.d2;
	rZ <= recordValue.v1 and recordValue.v2;
end arch;

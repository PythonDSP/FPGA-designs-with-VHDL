--ROM_sevenSegment.vhd

-- created by 	: 	Meher Krishna Patel
-- date					: 	25-Dec-16

-- Functionality:
  -- seven-segment display format for Hexadecimal values (i.e. 0-F) are stored in ROM 

-- ports:
	-- addr 			: input port for getting address
	-- data 			: ouput data at location 'addr'
	-- addr_width : total number of elements to store (put exact number)
	-- addr_bits  : bits requires to store elements specified by addr_width
	-- data_width : number of bits in each elements
	
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM_sevenSegment is
	generic(
		addr_width : integer := 16; -- store 16 elements
		addr_bits  : integer := 4; -- required bits to store 16 elements
		data_width : integer := 7 -- each element has 7-bits
		);
port(
	addr : in std_logic_vector(addr_bits-1 downto 0);
	data : out std_logic_vector(data_width-1 downto 0)
);
end ROM_sevenSegment;

architecture arch of ROM_sevenSegment is

	type rom_type is array (0 to addr_width-1) of std_logic_vector(data_width-1 downto 0);
	
	signal sevenSegment_ROM : rom_type := (
								"0000001",  -- 0 : location 0
								"1001111",  -- 1 : location 1
								"0010010",  -- 2 : location 2
								"0000110",  -- 3 : location 3
								"1001100",  -- 4 : location 4
								"0100100",  -- 5 : location 5
								"0100000",  -- 6 : location 6
								"0001111",  -- 7 : location 7
								"0000000",  -- 8 : location 8
								"0000100",  -- 9 : location 9
								"0001000",  -- A : location 10
								"1100000",  -- B : location 11
								"0110001",  -- C : location 12
								"1000010",  -- D : location 13
								"0110000",  -- E : location 14
								"0111000"   -- F : location 15
							);
begin
	data <= sevenSegment_ROM(to_integer(unsigned(addr)));
end arch; 
--ROM_sevenSegment_mif.vhd

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

entity ROM_sevenSegment_mif is
	generic(
		addr_width : integer := 16; -- store 16 elements
		addr_bits  : integer := 4; -- required bits to store 16 elements
		data_width : integer := 7 -- each element has 7-bits
		);
port(
	addr : in std_logic_vector(addr_bits-1 downto 0);
	data : out std_logic_vector(data_width-1 downto 0)
);
end ROM_sevenSegment_mif;

architecture arch of ROM_sevenSegment_mif is

	type rom_type is array (0 to addr_width-1) of std_logic_vector(data_width-1 downto 0);
	signal sevenSegment_ROM : rom_type;

	-- note that 'ram_init_file' is not the user-defined-name (it is attribute name)
	attribute ram_init_file : string; 
	-- "seven_seg_data.mif" is the relative address with respect to project directory
	-- suppose ".mif" file is saved in folder "ROM", then use "ROM/seven_seg_data.mif"
	attribute ram_init_file of sevenSegment_ROM : signal is "seven_seg_data.mif";
begin
	data <= sevenSegment_ROM(to_integer(unsigned(addr)));
end arch; 
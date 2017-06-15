-- dual_port_RAM.vhd

-- created by   :   Meher Krishna Patel
-- date         :   26-Dec-16

-- Functionality:
  -- store and retrieve data from single port RAM

-- ports:
    -- we         : write enable
    -- addr_wr    : address for writing data
	 -- addr_rd     : address for reading
    -- din        : input data to be stored in RAM
    -- data       : output data read from RAM
    -- addr_width : total number of elements to store (put exact number)
    -- addr_bits  : bits requires to store elements specified by addr_width
    -- data_width : number of bits in each elements

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dual_port_RAM is
	generic (
		addr_width : integer := 2;
		data_width : integer := 3 
	);
	
	port(
		clk: in std_logic;
		we : in std_logic;
		addr_wr, addr_rd : in std_logic_vector(addr_width-1 downto 0);
		din : in std_logic_vector(data_width-1 downto 0);
		dout : out std_logic_vector(data_width-1 downto 0)
		);
end dual_port_RAM;

architecture arch of dual_port_RAM is
	type ram_type is array (2**addr_width-1 downto 0) of std_logic_vector (data_width-1 downto 0);
	signal ram_dual_port : ram_type;
begin
	process(clk)
	begin 
		if (clk'event and clk='1') then
			if (we='1') then -- write data to address 'addr_wr'
        -- convert 'addr_wr' type to integer from std_logic_vector
				ram_dual_port(to_integer(unsigned(addr_wr))) <= din;
			end if;
		end if;
	end process;

	-- get address for reading data from 'addr_rd'
  -- convert 'addr_rd' type to integer from std_logic_vector
	dout<=ram_dual_port(to_integer(unsigned(addr_rd)));
end arch;

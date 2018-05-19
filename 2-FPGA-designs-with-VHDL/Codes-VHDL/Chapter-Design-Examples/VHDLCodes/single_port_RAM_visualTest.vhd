-- single_port_RAM_visualTest.vhd

-- created by   :   Meher Krishna Patel
-- date         :   26-Dec-16

-- Functionality:
  -- store and retrieve data from single port RAM

-- ports:
	-- Write Enable (we)	: SW[16]
	-- Address (addr)			: SW[15-14]
	-- din  							: SW[2:0]
	-- dout								: LEDR
	 
use ieee.numeric_std.all;library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity single_port_RAM_visualTest is
	generic (
		ADDR_WIDTH : integer := 2;
		DATA_WIDTH : integer := 3 
	);
	
	port(
		CLOCK_50: in std_logic;
		SW : in std_logic_vector(16 downto 0);
		LEDR : out std_logic_vector(DATA_WIDTH-1 downto 0)
		);
end single_port_RAM_visualTest;

architecture arch of single_port_RAM_visualTest is
begin
	single_port_RAM_test: entity work.single_port_RAM
	port map (clk=>CLOCK_50, we=>SW(16), 
					addr => SW(15 downto 14),
					din => SW(2 downto 0),
					dout =>LEDR);
end arch;

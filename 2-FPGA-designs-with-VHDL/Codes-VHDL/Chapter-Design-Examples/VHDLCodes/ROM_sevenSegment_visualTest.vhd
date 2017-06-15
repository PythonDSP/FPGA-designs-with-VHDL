-- ROM_sevenSegment_visualTest.vhd

-- created by 	: 	Meher Krishna Patel
-- date					: 	25-Dec-16

-- Functionality:
  -- retrieve data from ROM and display on seven-segment device and LEDs

-- ports:
	-- SW : address in binary format
	-- HEX0 : display data on seven segment device
	-- LEDR : display data on LEDs
	
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM_sevenSegment_visualTest is
port(
	SW : in std_logic_vector(3 downto 0);
	HEX0 : out std_logic_vector(6 downto 0);
	LEDR : out std_logic_vector(6 downto 0)
);
end ROM_sevenSegment_visualTest;

architecture arch of ROM_sevenSegment_visualTest is
	-- signal to store received data, so that it can be displayed on 
	-- two devices i.e. seven segment display and LEDs
	signal data : std_logic_vector (6 downto 0);
begin
	seven_segment_ROM: entity work.ROM_sevenSegment
	port map (addr=>SW, data=>data);
	
	HEX0 <= data;  -- display on seven segment devices
	LEDR <= data;  -- display on LEDs
end arch; 
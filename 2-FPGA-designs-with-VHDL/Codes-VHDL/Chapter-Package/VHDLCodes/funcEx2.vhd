-- funcEx2.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity funcEx2 is
port(
    SW : in std_logic_vector(3 downto 0);
    LEDG : out std_logic_vector(3 downto 0);
    HEX0 : out std_logic_vector(6 downto 0)
); 
end entity; 

architecture arch of funcEx2 is
    -- begin function
    function binary_to_ssd (
            -- list all input here
            signal switch : std_logic_vector(3 downto 0)
            )
        -- only one value can be return
        return std_logic_vector is variable sevenSegment : std_logic_vector(6 downto 0);
    begin 
        case switch is 
            -- active low i.e. 0:display & 1:no display
            when "0000" => sevenSegment := "1000000"; -- 0, 
            when "0001" => sevenSegment := "1111001"; -- 1
            when "0010" => sevenSegment := "0100100"; -- 2
            when "0011" => sevenSegment := "0110000"; -- 3 
            when "0100" => sevenSegment := "0011001"; -- 4
            when "0101" => sevenSegment := "0010010"; -- 5
            when "0110" => sevenSegment := "0000010"; -- 6
            when "0111" => sevenSegment := "1111000"; -- 7
            when "1000" => sevenSegment := "0000000"; -- 8
            when "1001" => sevenSegment := "0010000"; -- 9
            when "1010" => sevenSegment := "0001000"; -- a
            when "1011" => sevenSegment := "0000011"; -- b
            when "1100" => sevenSegment := "1000110"; -- c
            when "1101" => sevenSegment := "0100001"; -- d
            when "1110" => sevenSegment := "0000110"; -- e
            when others => sevenSegment := "0001110"; -- f
        end case;
        return sevenSegment;
    end binary_to_ssd;
    -- end function 
begin
    LEDG <= SW; 
    HEX0 <= binary_to_ssd(SW);
end architecture ; -- arch

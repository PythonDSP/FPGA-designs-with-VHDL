-- error_counter_v1.vhd
-- version : 1
-- Meher Krishna Patel
-- Date : 21-Sep-2017

-- counts the pre-defined number of errors and and 
-- number of bits transmitted for the total number of errors

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity error_counter_v1 is 
generic ( 
    -- total number of errors
    num_of_errors : unsigned(11 downto 0) := to_unsigned(200, 12)
);
port(
    clk, reset : in std_logic;
    tx_bit, detected_bit : in std_logic; 
    total_errors : out unsigned(11 downto 0);
    total_bits : out unsigned(31 downto 0)
); 
end entity;

architecture arch of error_counter_v1 is
    signal count_errors : unsigned(11 downto 0) := (others => '0');
    signal count_bits : unsigned(31 downto 0) := (others => '0');

    -- skip first few clocks, so that reset signal settle down, 
    -- it is required for proper BER display on the LCD, otherwise 
    -- error will be calculated while reset is settling down 
    -- This happens becuase, we are manually reseting the system. 
    -- Increase/decrease teh value of skip_clock based on the 'clk' value
    signal skip_clock : unsigned(11 downto 0) := to_unsigned(15, 12);
    signal count_clock : unsigned(11 downto 0);

begin 
    process(clk, reset, tx_bit, detected_bit, count_errors, count_bits, count_errors, count_clock)
    begin 
        if reset = '1' then 
            count_bits <= (others => '0');
            count_errors <= (others => '0');
            count_clock <= (others => '0');
        elsif rising_edge(clk) and (count_errors /= num_of_errors) then 
            -- start when count_clock > skip_clock
            if tx_bit /= detected_bit and (count_clock > skip_clock) then  
                count_bits <= count_bits + 1; 
                count_errors <= count_errors + 1; 
            elsif (count_clock > skip_clock) then
                count_bits <= count_bits + 1;
            else   -- otherwise increase the count_clock
                count_clock <= count_clock + 1; 
            end if;
--        elsif rising_edge(clk) then
--            count_clock <= count_clock + 1;
        end if; 
    end process;

    total_errors <= count_errors;
    total_bits <= count_bits;

end arch; 

            

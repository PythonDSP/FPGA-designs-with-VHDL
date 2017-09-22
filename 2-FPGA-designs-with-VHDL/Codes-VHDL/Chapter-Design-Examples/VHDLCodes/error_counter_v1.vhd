-- error_counter_v1.vhd

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
begin 
    process(clk, reset, tx_bit, detected_bit, count_errors, count_bits, count_errors)
    begin 
        if reset = '1' then -- set the counts to 0
            count_bits <= (others => '0');
            count_errors <= (others => '0');
        -- count till maximum number of errors are reached and then stop counting
        -- if not equal to maximum errors
        elsif rising_edge(clk) and (count_errors /= num_of_errors) then 
            if tx_bit /= detected_bit then -- if error then increase the 
                count_bits <= count_bits + 1;  -- tranmitted bit count
                count_errors <= count_errors + 1; -- and error-count
            else                                -- else (no error) then
                count_bits <= count_bits + 1;   -- increase the ranmitted bit count only
            end if;
        end if; 
    end process;

    total_errors <= count_errors;
    total_bits <= count_bits;

end arch; 

            

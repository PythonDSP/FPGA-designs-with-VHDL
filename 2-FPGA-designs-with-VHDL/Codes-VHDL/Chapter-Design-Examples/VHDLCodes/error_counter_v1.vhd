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
    num_of_errors : unsigned(11 downto 0) := to_unsigned(50, 12);
    -- 6000 for SF = 50; 500 for SF = 100
    skip_clock : unsigned(15 downto 0) := to_unsigned(500, 16)
);
port(
    clk, reset : in std_logic;
    tx_bit, detected_bit : in std_logic; 
    total_errors : out unsigned(11 downto 0);
    total_bits : out unsigned(31 downto 0)
); 
end entity;

architecture arch of error_counter_v1 is
    signal count_errors,count_errors_next : unsigned(11 downto 0) := (others => '0');
    signal count_bits,count_bits_next : unsigned(31 downto 0) := (others => '0');

    -- skip first few clocks, so that reset signal settle down, 
    -- it is required for proper BER display on the LCD, otherwise 
    -- error will be calculated while reset is settling down 
    -- This happens becuase, we are manually reseting the system.  
    
    -- if require, increase/decrease the value of "count_skip_errors"
    signal count_skip_errors : unsigned(31 downto 0) := to_unsigned(20, 32);
    signal count_skip_reg, count_skip_next : unsigned(32 downto 0);
        
    type stateType is (setup, start); --, done);
    signal state_reg, state_next : stateType;
begin 

    process(clk, reset) 
    begin 
        if reset = '1' then 
            count_bits <= (others => '0');
            count_errors <= (others => '0');
            count_skip_reg <= (others => '0');
            state_reg <= setup;
        elsif falling_edge(clk) then 
            count_bits <= count_bits_next;
            count_errors <= count_errors_next;
			count_skip_reg <= count_skip_next;
            state_reg <= state_next;
        end if; 
    end process; 
    
    process(tx_bit, detected_bit, count_errors, count_bits, state_reg, count_skip_reg, count_skip_errors)
    begin 
        count_bits_next <= count_bits;
        count_errors_next <= count_errors;
        count_skip_next <= count_skip_reg;
			state_next <= state_reg;
        case state_reg is 
            when setup => -- do not count error for first few cycles
               if (count_skip_reg /= count_skip_errors) then 
                        count_bits_next <= (others=> '1'); -- display 0xFFF
                        count_errors_next <= (others => '1'); -- display 0xFFFFFFFF
                        count_skip_next <= count_skip_reg + 1; 
                elsif count_skip_reg = count_skip_errors then 
                    count_errors_next <= (others => '0');
                    count_bits_next <= (others => '0');
                    state_next <= start;
                end if; 
            when start =>  -- start counting-errors
                if (count_errors /= num_of_errors) then 
                    if tx_bit /= detected_bit then 
                        count_bits_next <= count_bits + 1;  -- increment values
                        count_errors_next <= count_errors + 1; 
                    elsif tx_bit = detected_bit then
                        count_bits_next <= count_bits + 1;
                        count_errors_next <= count_errors;
                    end if;
                elsif count_errors = num_of_errors then -- if maximum error reached
                    count_bits_next <= count_bits; -- then stop incrementing values
                    count_errors_next <= count_errors;
                 end if; 
					 
        end case; 
    end process;

    -- assign values to output ports
    total_errors <= count_errors;
    total_bits <= count_bits;

end arch; 

            

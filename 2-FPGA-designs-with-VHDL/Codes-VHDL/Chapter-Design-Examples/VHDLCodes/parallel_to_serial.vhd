-- parallel_to_serial.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parallel_to_serial is
generic ( N : integer := 8 );
port (
	clk, reset : in std_logic;
	data_in : in std_logic_vector(N-1 downto 0); -- parallel data
	data_out : out std_logic;  -- serial data
	empty_tick : out std_logic -- 1 = empty, to control other devices
);
end entity; 

architecture arch of parallel_to_serial is
	type operation_type is (idle, convert, done);
	signal state_reg, state_next : operation_type; 
	signal data_reg, data_next : std_logic_vector(N-1 downto 0) := (others => '0');
	signal count_reg, count_next : unsigned(N-1 downto 0);
begin

	-- current register values
	process(clk, reset)
	begin 
		if reset = '1' then 
			state_reg <= idle;
			data_reg <= (others => '0');
			count_reg <= (others => '0');
		elsif (clk'event and clk = '1') then 
			state_reg <= state_next;
			data_reg <= data_next;
			count_reg <= count_next;
		end if;
	end process; 
	
	-- next value in the register 
	-- note that, it is poor style of coding as output data calculation
	-- and next values in register are calculated simultaneously. These
	-- should be done in different process statements. 
	process(state_reg, data_in, count_reg, data_reg)
	begin 
		empty_tick <= '0';
		state_next <= state_reg;
		data_next <= data_reg;
		count_next <= count_reg; 
		case state_reg is 
			when idle =>
					state_next <= convert;
					data_next <= data_in;  -- load the parallel data data
					empty_tick <= '1';
					count_next <= count_reg + 1;
			when convert =>
				count_next <= count_reg + 1; 
				if count_reg = N then -- note that N is used here (not N-1, see reason below)
					-- serial_to_parallel.vhd needs one clock cycle to transfer the converted
					-- data (i.e. parallel data) to next device, therefore it can not update the
					-- current value immediatly after the conversion. Therefore, count_reg = N, 
					-- is used in above line (instead of N-1), so that one extra bit will be added
					-- in the end and will be discarded by serial_to_parallel.vhd as it will not 
					-- read the last value.
					-- Also, data_next is not defined here, as last bit is not, therefore, value of
					-- data_next at count 'N' will be same as at 'N-1'. 
					state_next <= done;
				else
					-- shift the data to right and append zero in the beginning
					data_next <= '0' & data_reg(N-1 downto 1);
				end if;
			when done =>
				count_next <= (others => '0');
				state_next <= idle; 
		end case;
	end process; 		
	
	-- send bit to output port
	data_out <= data_reg(0);
end arch;
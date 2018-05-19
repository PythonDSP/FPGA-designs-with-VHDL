-- serial_to_parallel.vhd

library ieee;
use ieee.std_logic_1164.all;

entity serial_to_parallel is
    generic (
        N : natural := 4
    );

    port (
        clk, reset : in std_logic;
        in_tick : in std_logic;  -- input tick to control the conversion from other device
        din : in std_logic;
        load : out std_logic;  -- use it as tick, to load data immidiately e.g. from FIFO
        done : out std_logic;  -- use it as tick, if data is obtained after one-clock cycle e.g. from generators
        dout : out std_logic_vector(N-1 downto 0)
    );
end entity serial_to_parallel;

architecture arch of serial_to_parallel is
    type state is (idle, store0, store1);
    signal state_reg, state_next : state; 
    signal y_reg, y_next : std_logic_vector(N-1 downto 0);
    signal i_reg, i_next:natural range 0 to N;
begin

	-- update registers
    process(clk, reset)
    begin 
        if(reset = '1') then 
            i_reg <= 0;
            y_reg <= (others=>'0');
        elsif rising_edge(clk) then 
            i_reg <= i_next; 
            y_reg <= y_next; 
        end if;
    end process; 

	-- update states
    process(clk, reset)
    begin 
        if reset='1' then 
            state_reg <= idle;
        elsif rising_edge(clk) then
            state_reg <= state_next;
        end if;
    end process; 

	-- output data calculation
    process(clk, din, y_next, i_next, i_reg, y_reg, state_reg, state_next)
    begin
        y_next<=y_reg;
        case state_reg is
            when idle =>
                i_next<=0;      
                load <= '1';
                done <= '0';
					 
					 -- this loop is used to load the data immidiately in the registers
                if in_tick='1' and din='0' then -- i.e. if first value is zero
                    state_next <= store0; -- then go to store0
                elsif in_tick='1' and din='1' then -- i.e. if first value is one
                    state_next <= store1; -- then go to store1
                else
                    state_next <= idle;
                end if;

				-- input data is 0.
            when store0 =>
                i_next <= i_reg + 1;
                y_next(i_reg) <= '0';
                load <= '0';
                done <= '0';
                if i_reg = N-1 then 
                    state_next <= idle;
                    done <= '1'; 
                elsif din='1' then
                    state_next <= store1;
                else
                    state_next <= store0;
                end if;
				
				-- input data is 1. 
            when store1 =>
                i_next <= i_reg + 1;
                y_next(i_reg) <= '1';
                load <= '0';
                done <= '0';
                if i_reg = N-1 then 
                    state_next <= idle;
                    done <= '1';
                elsif din='0' then
                    state_next <= store0;
                else
                    state_next <= store1; 
                end if;
        end case;
    end process;      

	 -- send data to output
    dout <= y_next when i_reg = N-1;      
end architecture arch;
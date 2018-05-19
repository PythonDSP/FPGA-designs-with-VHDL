-- modMCounter_tb2.vhd

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all; -- require for std_logic etc.

entity modMCounter_tb2 is
end modMCounter_tb2;


architecture arch of modMCounter_tb2 is
    constant M : integer := 3;  -- count upto 2 (i.e. 0 to 2)
    constant N : integer := 4;
    constant T : time := 20 ns; 

    signal clk, reset : std_logic;  -- input
    signal complete_tick : std_logic; -- output
    signal count : std_logic_vector(N-1 downto 0);  -- output

    -- total samples to store in file
    constant num_of_clocks : integer := 30; 
    signal i : integer := 0; -- loop variable
    file output_buf : text; -- text is keyword

begin

    modMCounter_unit : entity work.modMCounter
        generic map (M => M, N => N)
        port map (clk=>clk, reset=>reset, complete_tick=>complete_tick,
                    count=>count);


    -- reset = 1 for first clock cycle and then 0
    reset <= '1', '0' after T/2;

    -- continuous clock
    process 
    begin
        clk <= '0';
        wait for T/2;
        clk <= '1';
        wait for T/2;

        -- store 30 samples in file
        if (i = num_of_clocks) then
            file_close(output_buf);
            wait;
        else
            i <= i + 1;
        end if;
    end process;


    -- save data in file : path is relative to Modelsim-project directory
    file_open(output_buf, "input_output_files/counter_data.csv", write_mode);
    process(clk)
        variable write_col_to_output_buf : line; -- line is keyword
    begin
        if(clk'event and clk='1' and reset /= '1') then  -- avoid reset data
            -- comment below 'if statement' to avoid header in saved file
            if (i = 0) then 
              write(write_col_to_output_buf, string'("clock_tick,count"));
              writeline(output_buf, write_col_to_output_buf);
            end if; 

            write(write_col_to_output_buf, complete_tick);
            write(write_col_to_output_buf, string'(","));
            -- Note that unsigned/signed values can not be saved in file, 
            -- therefore change into integer or std_logic_vector etc.
             -- following line saves the count in integer format
            write(write_col_to_output_buf, to_integer(unsigned(count))); 
            writeline(output_buf, write_col_to_output_buf);
        end if;
    end process;
end arch;
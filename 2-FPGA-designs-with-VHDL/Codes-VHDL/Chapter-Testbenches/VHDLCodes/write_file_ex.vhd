-- write_file_ex.vhd


library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all; -- require for writing std_logic etc.

entity write_file_ex is
end write_file_ex;

architecture tb of write_file_ex is
    signal a : std_logic;

    file output_buf : text;  -- text is keyword
begin     

    tb1 : process
        variable write_col_to_output_buf : line; -- line is keyword
        variable b : integer := 40;
        begin
            a <= '1';  -- assign value to a
            wait for 20 ns; 

            -- if modelsim-project is created, then provide the relative path of 
            -- input-file (i.e. read_file_ex.txt) with respect to main project folder
            file_open(output_buf, "VHDLCodes/input_output_files/write_file_ex.txt",  write_mode); 
            -- else provide the complete path for the input file as show below 
            --file_open(output_buf, "E:/VHDLCodes/input_output_files/write_file_ex.txt",  write_mode); 

            write(write_col_to_output_buf, string'("Printing values"));
            writeline(output_buf, write_col_to_output_buf);  -- write in line 1

            write(write_col_to_output_buf, string'("a = "));
            write(write_col_to_output_buf, a);
            write(write_col_to_output_buf, string'(", b = "));
            write(write_col_to_output_buf, b);
            writeline(output_buf, write_col_to_output_buf);    -- write in new line 2

            write(write_col_to_output_buf, string'("Thank you"));
            writeline(output_buf, write_col_to_output_buf);   -- write in new line 3

            file_close(output_buf);
            wait; -- indefinitely suspend process
        end process;
end tb ; -- tb

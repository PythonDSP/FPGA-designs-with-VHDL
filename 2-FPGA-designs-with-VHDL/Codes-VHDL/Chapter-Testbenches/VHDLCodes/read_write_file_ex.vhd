-- read_write_file_ex.vhd

-- testbench for half adder, 

-- Features included in this code are
    -- inputs are read from csv file, which stores the desired outputs as well
    -- outputs are written to csv file
    -- actual output and calculated outputs are compared
    -- Error message is displayed in the file
    -- header line is skipped while reading the csv file


library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all; -- require for writing/reading std_logic etc.

entity read_write_file_ex is
end read_write_file_ex;

architecture tb of read_write_file_ex is
    signal a, b : std_logic;
    signal sum_actual, carry_actual : std_logic;
    signal sum, carry : std_logic;  -- calculated sum and carry by half_adder

    -- buffer for storing the text from input and for output files
    file input_buf : text;  -- text is keyword
    file output_buf : text;  -- text is keyword

begin     
  UUT : entity work.half_adder port map (a => a, b => b, sum => sum, carry => carry);

  tb1 : process
  variable read_col_from_input_buf : line; -- read lines one by one from input_buf
  variable write_col_to_output_buf : line; -- write lines one by one to output_buf

  variable buf_data_from_file : line;  -- buffer for storind the data from input read-file
  variable val_a, val_b : std_logic; 
  variable val_sum, val_carry: std_logic;
  variable val_comma : character;  -- for commas between data in file

  variable good_num : boolean;
  begin
   
  -- ####################################################################
   -- Reading data

      -- if modelsim-project is created, then provide the relative path of 
      -- input-file (i.e. read_file_ex.txt) with respect to main project folder
      file_open(input_buf, "VHDLCodes/input_output_files/half_adder_input.csv",  read_mode); 
      -- else provide the complete path for the input file as show below 
      -- file_open(input_buf, "E:/VHDLCodes/input_output_files/read_file_ex.txt",  read_mode); 

      -- writing data
      file_open(output_buf, "VHDLCodes/input_output_files/half_adder_output.csv",  write_mode); 

      write(write_col_to_output_buf, 
        string'("#a,b,sum_actual,sum,carry_actual,carry,sum_test_results,carry_test_results"));
      writeline(output_buf, write_col_to_output_buf);

      while not endfile(input_buf) loop
        readline(input_buf, read_col_from_input_buf);
        read(read_col_from_input_buf, val_a, good_num);
        next when not good_num;  -- i.e. skip the header lines

        read(read_col_from_input_buf, val_comma);           -- read in the space character
        read(read_col_from_input_buf, val_b, good_num);  
        assert good_num report "bad value assigned to val_b";

        read(read_col_from_input_buf, val_comma);           -- read in the space character
        read(read_col_from_input_buf, val_sum);
        read(read_col_from_input_buf, val_comma);           -- read in the space character
        read(read_col_from_input_buf, val_carry);

        -- Pass the variable to a signal to allow the ripple-carry to use it
        a <= val_a;
        b <= val_b;
        sum_actual <= val_sum;
        carry_actual <= val_carry;

        wait for 20 ns;  --  to display results for 20 ns

        write(write_col_to_output_buf, a);
        write(write_col_to_output_buf, string'(","));
        write(write_col_to_output_buf, b);
        write(write_col_to_output_buf, string'(","));
        write(write_col_to_output_buf, sum_actual);
        write(write_col_to_output_buf, string'(","));
        write(write_col_to_output_buf, sum);
        write(write_col_to_output_buf, string'(","));
        write(write_col_to_output_buf, carry_actual);
        write(write_col_to_output_buf, string'(","));
        write(write_col_to_output_buf, carry); 
        write(write_col_to_output_buf, string'(","));
        
        -- display Error or OK if results are wrong
        if (sum_actual /= sum) then
          write(write_col_to_output_buf, string'("Error,"));
        else
          write(write_col_to_output_buf, string'(","));  -- write nothing
          
        end if;

        -- display Error or OK based on comparison
        if (carry_actual /= carry) then
          write(write_col_to_output_buf, string'("Error,"));
        else
          write(write_col_to_output_buf, string'("OK,"));
        end if;


        --write(write_col_to_output_buf, a, b, sum_actual, sum, carry_actual, carry);
        writeline(output_buf, write_col_to_output_buf);
      end loop;

      file_close(input_buf);             
      file_close(output_buf);             
      wait;
  end process;
end tb ; -- tb

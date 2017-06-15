/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include "io.h"  // required for IOWR
#include "alt_types.h" // required for alt_u8
#include "system.h"  // contains address of LED_BASE
#include <stdio.h>

int main()
{
  printf("Adder inputs and outputs\n");
  printf("a, b, c, sum, carry\n");


  alt_u8 i; // loop variable

  alt_u8 input_value; // input_value
  alt_u8 sum_value, carry_value; //output value
  alt_u8 a, b, c; // for storing individual bit of input value

  int j, itr=250000; // for delay to display sum and carry on LEDs

  for (i=0; i<8; i++){
	  input_value = i & 0x07;
	  a = input_value & 0x01; // select first bit of input (001)
	  b = input_value >> 1 & 0x01; // select second bit of input (010)
	  c = input_value >> 2 & 0x01; // select third bit of input (100)

	  IOWR(ADDER_INPUT_BASE, 0, input_value);

	  sum_value = IORD(SUM_BASE, 0);
	  carry_value = IORD(CARRY_BASE,0);

	  printf("%x, %x, %x, %d, %d\n", c, b, a, sum_value, carry_value);

	  for (j=0; j<itr; j++){} // dummy loop for delay to see LED outputs


  }

  return 0;
}

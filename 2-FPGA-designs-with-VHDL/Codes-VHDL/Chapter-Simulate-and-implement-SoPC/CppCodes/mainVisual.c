//main.c
#include "io.h"  // required for IOWR
#include "alt_types.h" // required for alt_u8
#include "system.h"  // contains address of LED_BASE

int main(){
	alt_u8 led_pattern = 0x01; // on the LED

	//uncomment below line for visual verification of blinking LED
	int i, itr=250000;

	printf("Blinking LED\n");
	while(1){
		led_pattern = ~led_pattern; // not the led_pattern
		IOWR(LED_BASE, 0, led_pattern); // write the led_pattern on LED

		//uncomment 'for loop' in below line for visual verification of blinking LED
		// dummy for loop to add delay in blinking, so that we can see the bliking.
		for (i=0; i<itr; i ++){}
  }
}

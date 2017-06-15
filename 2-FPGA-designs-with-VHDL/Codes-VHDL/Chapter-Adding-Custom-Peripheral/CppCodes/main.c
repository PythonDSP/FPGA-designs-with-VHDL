//main.c
#include "io.h"
#include "alt_types.h"
#include "system.h"

int main(){
    static alt_u8 led_pattern = 0x01; // on the LED

    // swValue : to store the value of switch
    // swDelay = swValue * iter, is the overall delay
    int i, swDelay, swValue, itr=1000;

    printf("Blinking LED\n");
    while(1){
        led_pattern = ~led_pattern; // not the led_pattern
        IOWR(LED_BASE, 0, led_pattern); // write the led_pattern on LED

        // read the value of switch
        swValue = IORD(SWITCH_BASE, 0);

        // calculate delay i.e. multiply switch value by 1000
        swDelay = swValue * itr;

        // dummy loop for delay
        for (i=0; i<swDelay; i ++){}
  }
}

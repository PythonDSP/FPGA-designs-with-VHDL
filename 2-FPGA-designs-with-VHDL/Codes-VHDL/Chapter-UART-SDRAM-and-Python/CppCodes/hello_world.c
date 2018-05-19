//hello_world.c
#include "io.h"
#include "alt_types.h"
#include "system.h"
#include "math.h"

int main(){

    float i=0, sin_value, cos_value;
    alt_u8 amplitude;

    while(1){
        amplitude = IORD(SWITCH_BASE, 0);

        sin_value =  (int)amplitude * (float)sin(i);
        cos_value =  (int)amplitude * (float)cos(i);

        printf("%f,%f\n", sin_value, cos_value);
        i = i+0.01;

  }
}
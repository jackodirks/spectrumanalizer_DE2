#include "externalInterfaces.h"

//Buffer and control
volatile unsigned char* fftA = (unsigned char *)0x4B000; //FFT A buffer, contains data about height in pixels (lives in SRAM)
volatile unsigned char* fftB = (unsigned char *)0x4B400; //FFT B buffer, contains data about heigt in pixels (lives in SRAM)
volatile unsigned char* control_in = (unsigned char*)CONTROL_IN_BASE; //The control in signals
volatile unsigned char* control_out = (unsigned char*)CONTROL_OUT_BASE; //The control out signals

unsigned char lastKnownControlIn = 0;
unsigned char lastKnownControlOut = 0;

/*
 * control_in => lsb = FFT_control
 * lsb = 0 when B is ready and 1 when A is ready
 */

//At programstart the VHDL will start writing to buffer A, so we have to wait for that to finish before we can do anything
int initExternal(void){
	*control_out = 0;
	return 0;
}

volatile unsigned char* switchFFTBuffer(void){
	//Flip our side
	lastKnownControlOut = !lastKnownControlOut;
	if (lastKnownControlOut){
		*control_out |= 1; //Change the first bit to 1
	} else {
		*control_out &= 0xFE; //AND 11111110
	}
	//Wait for the VHDL to flip on his side.
	while ((*control_in & 1) == lastKnownControlIn);
	lastKnownControlIn = *control_in & 1;
	if (lastKnownControlIn) return fftA; //If controlIn is 1, buffer A is ready
	else return fftB; //Else buffer B
}

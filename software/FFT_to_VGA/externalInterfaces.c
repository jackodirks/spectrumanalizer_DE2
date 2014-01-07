#include "externalInterfaces.h"

//Buffer and control
volatile unsigned char* fftA = (unsigned char *)0x4B000; //FFT A buffer, contains data about height in pixels (lives in SRAM)
volatile unsigned char* fftB = (unsigned char *)0x4B400; //FFT B buffer, contains data about heigt in pixels (lives in SRAM)
volatile unsigned char* control_in = (unsigned char*)CONTROL_IN_BASE; //The control in signals
volatile unsigned char* control_out = (unsigned char*)CONTROL_OUT_BASE; //The control out signals
volatile void** addr = (void**)ADDRESS_PIO_BASE;

unsigned int bufferAActive;

/*
 * control_in => lsb = FFT_control
 * lsb = 0 when B is ready and 1 when A is ready
 */

//At programstart the VHDL will start writing to buffer A, so we have to wait for that to finish before we can do anything
int initExternal(void){
	*control_out = 0;
	bufferAActive = 0;
	return 0;
}

//TODO: FIX (small endian or big endian?)
volatile unsigned char* switchFFTBuffer(void){
	//Flip our side
	bufferAActive = !bufferAActive;
	void* v = *addr;
	while ((*control_in) == 0);
	*control_out = -1;
	*control_out = 0;
	if (bufferAActive) return fftA; //If controlIn is 1, buffer A is ready
	else return fftB; //Else buffer B
}

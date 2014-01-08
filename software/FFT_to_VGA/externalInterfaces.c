#include "externalInterfaces.h"

//Buffer and control
//volatile unsigned char* fftA = (unsigned char *)0x4B000; //FFT A buffer, contains data about height in pixels (lives in SRAM)
//volatile unsigned char* fftB = (unsigned char *)0x4B400; //FFT B buffer, contains data about heigt in pixels (lives in SRAM)


//WRONG IDEA: The PIO's are not directly after eachother and each contain 4 byte (maybe an unsigned char**)?
volatile unsigned char* fft_in = (unsigned char*) FFT_IN_0_BASE; //The first address for the 32 length unsigned char buffer
volatile unsigned char* control_in = (unsigned char*)CONTROL_IN_BASE; //The control in signals
volatile unsigned char* control_out = (unsigned char*)CONTROL_OUT_BASE; //The control out signals

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
//volatile unsigned char* switchFFTBuffer(void){
//	//Flip our side
//	bufferAActive = !bufferAActive;
//	void* v = *addr;
//	while ((*control_in) == 0);
//	*control_out = -1;
//	volatile int i = 8;
//	while (i--); //Wait 8 ticks
//	*control_out = 0;
//	if (bufferAActive) return fftA; //If controlIn is 1, buffer A is ready
//	else return fftB; //Else buffer B
//}

//This function loops trough the given data
unsigned char* getFFTData(unsigned firstPoint, unsigned lastPoint){
	//Allocate the necessary data
	unsigned char* FFTData = malloc(sizeof(char) * (lastPoint - firstPoint));
	//The variable that knows how mucht of the allocated data is already used
	unsigned datacounter = 0;
	//The loop. Counting from 0 to 1024 with steps of 32
	unsigned counter;
	for(counter = 0; counter <= 1024; counter += 64){
		//First: receive the data
		*control_out = 1;
		while ((*control_in) == 0);
		*control_out = 0;
		//Some checks (should we even do anything?)
		if ((counter + 64) < firstPoint) continue;
		if (counter > lastPoint) continue;
		//Aparently we should
		unsigned offsetCounter = counter;
		if (offsetCounter < firstPoint) offsetCounter = firstPoint;
		if (offsetCounter == lastPoint) continue;
		for(;offsetCounter < counter + 64; offsetCounter++){
			FFTData[datacounter++] = fft_in[offsetCounter];
		}
	}
	//Tell the FFT to get the next data ready
	*control_out = 1;
	//Return and continue
	return FFTData;
}

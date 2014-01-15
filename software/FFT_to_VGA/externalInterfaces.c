#include "externalInterfaces.h"
//Buffer and control
//volatile unsigned char* fftA = (unsigned char *)0x4B000; //FFT A buffer, contains data about height in pixels (lives in SRAM)
//volatile unsigned char* fftB = (unsigned char *)0x4B400; //FFT B buffer, contains data about heigt in pixels (lives in SRAM)


volatile unsigned char* fft_in_0 = (unsigned char*) FFT_IN_0_BASE; //The first address for the 32 length unsigned char buffer
volatile unsigned char* fft_in_1 = (unsigned char*) FFT_IN_1_BASE;
volatile unsigned char* fft_in_2 = (unsigned char*) FFT_IN_2_BASE;
volatile unsigned char* fft_in_3 = (unsigned char*) FFT_IN_3_BASE;
volatile unsigned char* fft_in[16];

volatile unsigned char* control_in = (unsigned char*)CONTROL_IN_BASE; //The control in signals
volatile unsigned char* control_out = (unsigned char*)CONTROL_OUT_BASE; //The control out signals

int initExternal(void){
	//fill fft_in
	unsigned fft_in_index = 0, iterator = 0;
	for (iterator = 0; iterator < 4; ++iterator) fft_in[fft_in_index++] = &fft_in_0[iterator];
	for (iterator = 0; iterator < 4; ++iterator) fft_in[fft_in_index++] = &fft_in_1[iterator];
	for (iterator = 0; iterator < 4; ++iterator) fft_in[fft_in_index++] = &fft_in_2[iterator];
	for (iterator = 0; iterator < 4; ++iterator) fft_in[fft_in_index++] = &fft_in_3[iterator];
	*control_out = 1;
	return 0;
}
//This function loops trough the given data
unsigned char* getFFTData(unsigned firstPoint, unsigned lastPoint){
	//Allocate the necessary data
	unsigned char* FFTData = malloc(sizeof(char) * (lastPoint - firstPoint));
	//The variable that knows how much of the allocated data is already used
	unsigned datacounter = 0;
	//The loop. Counting from 0 to 1024 with steps of 32
	unsigned counter;
	for(counter = 0; counter <= 1024; counter += 16){
		//First: receive the data
		*control_out = 1;
		while ((*control_in) == 0);
		*control_out = 0;
		//Some checks (should we even do anything?)
		if ((counter + 16) < firstPoint) continue;
		if (counter > lastPoint) continue;
		//Aparently we should
		unsigned offsetCounter = counter;
		if (offsetCounter < firstPoint) offsetCounter = firstPoint;
		if (offsetCounter == lastPoint) continue;
		offsetCounter %= 16;
		for(;offsetCounter < 16; offsetCounter++){
			FFTData[datacounter++] = *fft_in[offsetCounter];
		}
	}
	//Tell the FFT to get the next data ready
	*control_out = 1;
	//Return and continue
	return FFTData;
}

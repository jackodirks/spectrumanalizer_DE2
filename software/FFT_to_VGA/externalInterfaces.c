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

volatile unsigned char* rotary_val = (unsigned char*) ROTARY_IN_BASE; //The value of the rotary encoder

unsigned char fullLUT[307];

int initExternal(void){
	//fill fft_in
	unsigned fft_in_index = 0, iterator = 0;
	for (iterator = 0; iterator < 4; ++iterator) fft_in[fft_in_index++] = &fft_in_0[iterator];
	for (iterator = 0; iterator < 4; ++iterator) fft_in[fft_in_index++] = &fft_in_1[iterator];
	for (iterator = 0; iterator < 4; ++iterator) fft_in[fft_in_index++] = &fft_in_2[iterator];
	for (iterator = 0; iterator < 4; ++iterator) fft_in[fft_in_index++] = &fft_in_3[iterator];
	*control_out = 1;
	//Fill the Look-up table
	int temp = 0;
	float constVal = 1024.0/307.0;
	int testVar = 0;
	for (temp = 0; temp < 307; ++temp){
		fullLUT[temp] = (int)(constVal * (temp+1))- (int)(constVal * temp);
		testVar += fullLUT[temp];
	}
	fullLUT[306]++; //Compensate: add the last remaining element
	return 0;
}

void getNextFFTData(void){ //This function requests new data from the FFT and returns when its done
	if (*control_out ^ 1) *control_out ^= 1; //XXXXXXX0 XOR 0000001 = XXXXXXX1
	while ((*control_in & 1) == 0); //Check if the last bit is 1
	*control_out ^= 1; //XXXXXXX1 XOR 0000001 = XXXXXXX0
}
//This function loops trough the given data
unsigned char* getPartFFTData(unsigned firstPoint, unsigned lastPoint){
	//Allocate the necessary data
	unsigned char* FFTData = malloc(sizeof(char) * (lastPoint - firstPoint));
	//The variable that knows how much of the allocated data is already used
	unsigned datacounter = 0;
	//The loop. Counting from 0 to 1024 with steps of 32
	unsigned counter;
	for(counter = 0; counter <= 1024; counter += 16){
		//First: receive the data
		getNextFFTData();
		//Some checks (should we even do anything?)
		if ((counter + 16) < firstPoint) continue;
		if (counter == lastPoint) continue;
		//Aparently we should
		unsigned offsetCounter = counter;
		if (offsetCounter < firstPoint) offsetCounter = firstPoint;
		if (offsetCounter == lastPoint) continue;
		offsetCounter %= 16;
		for(;offsetCounter < 16; offsetCounter++){
			if (datacounter > (lastPoint - firstPoint)){ //Debug code, should be fixed
				printf("FAULT!\r\n");
				break;
			}
			if (counter + offsetCounter >= lastPoint) break;
			FFTData[datacounter] = *fft_in[offsetCounter];
			datacounter++;
		}
	}
	//Tell the FFT to get the next data ready
	//*control_out ^= 1;
	//Return and continue
	return FFTData;
}

unsigned char* getFullFFTData(void){ //Sorts the given data, returns the higest element of each pixel
	const int dataAmount = 307;
	//inits
	unsigned char* FFTData = malloc(sizeof(char) * dataAmount);
	unsigned counter = 0, temp = 0;
	for (temp = 0; temp < dataAmount; ++temp){
		int elementCounter;
		unsigned char highestElement = 225;
		for(elementCounter = 0; elementCounter <fullLUT[temp]; ++elementCounter){
			counter %= 16;
			if (counter == 0){ //Used up current buffer, request a new one
				getNextFFTData();
			}
			if (*fft_in[counter] < highestElement) highestElement = *fft_in[counter];
			counter++;
		}
		FFTData[temp] = highestElement;
	}
	//*control_out ^= 1;
	return FFTData;
}

unsigned rotary_pressed(void){ //SECOND BIT OF CONTROL IN
	return *control_in & 2; //XXXXXXUX XOR 00000010 = U XOR 1 => 1 ? U == 0 : U == 1. Invert to get old data back
}

unsigned char getMinVal(void){
	return *rotary_val;
}

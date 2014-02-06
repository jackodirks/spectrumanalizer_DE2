#include "externalInterfaces.h"
//Buffer and control
//volatile unsigned char* fftA = (unsigned char *)0x4B000; //FFT A buffer, contains data about height in pixels (lives in SRAM)
//volatile unsigned char* fftB = (unsigned char *)0x4B400; //FFT B buffer, contains data about heigt in pixels (lives in SRAM)

volatile unsigned short* fft_in_0 = (unsigned short*) FFT_IN_0_BASE; //The first address for the 32 length unsigned char buffer
volatile unsigned short* fft_in_1 = (unsigned short*) FFT_IN_1_BASE;
volatile unsigned short* fft_in_2 = (unsigned short*) FFT_IN_2_BASE;
volatile unsigned short* fft_in_3 = (unsigned short*) FFT_IN_3_BASE;
volatile unsigned short* fft_in_4 = (unsigned short*) FFT_IN_4_BASE;
volatile unsigned short* fft_in_5 = (unsigned short*) FFT_IN_5_BASE;
volatile unsigned short* fft_in_6 = (unsigned short*) FFT_IN_6_BASE;
volatile unsigned short* fft_in_7 = (unsigned short*) FFT_IN_7_BASE;
volatile unsigned short* fft_in[16];

volatile unsigned char* control_in = (unsigned char*)CONTROL_IN_BASE; //The control in signals
volatile unsigned char* control_out = (unsigned char*)CONTROL_OUT_BASE; //The control out signals

volatile unsigned char* rotary_val = (unsigned char*) ROTARY_IN_BASE; //The value of the rotary encoder

unsigned char fullLUT[307];

int initExternal(void){
	//fill fft_in
	unsigned fft_in_index = 0, iterator = 0;
	for (iterator = 0; iterator < 2; ++iterator) fft_in[fft_in_index++] = &fft_in_0[iterator];
	for (iterator = 0; iterator < 2; ++iterator) fft_in[fft_in_index++] = &fft_in_1[iterator];
	for (iterator = 0; iterator < 2; ++iterator) fft_in[fft_in_index++] = &fft_in_2[iterator];
	for (iterator = 0; iterator < 2; ++iterator) fft_in[fft_in_index++] = &fft_in_3[iterator];
	for (iterator = 0; iterator < 2; ++iterator) fft_in[fft_in_index++] = &fft_in_4[iterator];
	for (iterator = 0; iterator < 2; ++iterator) fft_in[fft_in_index++] = &fft_in_5[iterator];
	for (iterator = 0; iterator < 2; ++iterator) fft_in[fft_in_index++] = &fft_in_6[iterator];
	for (iterator = 0; iterator < 2; ++iterator) fft_in[fft_in_index++] = &fft_in_7[iterator];
	//*control_out = 1;
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
	static unsigned amount = 0;
	printf("part: %d cycles\n",amount);
	amount = 0;
	//Allocate the necessary data
	unsigned char* FFTData = malloc(sizeof(char) * (lastPoint - firstPoint));
	//The variable that knows how much of the allocated data is already used
	unsigned datacounter = 0;
	//The loop. Counting from 0 to 1024 with steps of 32
	unsigned counter;
	for(counter = 0; counter < 1024; counter += 16){
		getNextFFTData();
		amount++;
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
			unsigned short temp = *fft_in[offsetCounter];
			temp = (1023 - temp)*0.219;
			FFTData[datacounter] = (unsigned char)temp;
			datacounter++;
		}
		//last: receive the data

	}
	//Tell the FFT to get the next data ready
	//*control_out ^= 1;
	//Return and continue
	return FFTData;
}

unsigned char* getFullFFTData(void){ //Sorts the given data, returns the higest element of each pixel
	static unsigned amount = 0;
	printf("%d cycles\n",amount);
	amount = 0;
	const int dataAmount = 307;
	//inits
	unsigned char* FFTData = malloc(sizeof(char) * dataAmount);
	unsigned counter = 0, temp = 0;
	for (temp = 0; temp < dataAmount; ++temp){

		int elementCounter;
		unsigned char highestElement = 225;
		for(elementCounter = 0; elementCounter <fullLUT[temp]; ++elementCounter){
			counter++;
			counter %= 16;
			if (counter == 0){ //Used up current buffer, request a new one
				getNextFFTData();
			}
			unsigned short temp = *fft_in[counter];
			if (temp > 1023){
				printf("temp: %d\n, counter: %d\n",temp,counter);
				amount++;
			}
			temp = (1023 - temp)*0.219;

			if ((unsigned char)temp < highestElement) highestElement = (unsigned char)temp;

		}
		if (highestElement == 90){

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

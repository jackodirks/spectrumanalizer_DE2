#include "sharedHeader.h"
#include "text.h"
#include "draw.h"
#include "FFT_temp.h"
#include "externalInterfaces.h"
#include "cnst_hz.h"

//The values is value in Hz /1000 (steps of 1 KHz)
char rangeChanged = 0;

unsigned LUT[101];

//Declarations of positions of buffers and hardware components
volatile int * ledR = (int*) RED_LED_PIO_BASE;
volatile int * ledG = (int*) GREEN_LED_PIO_BASE;

//This function does stuff that does not belong in the final version
//void temp(void){
//	//Write the const data to the mem
//	int x;
//	for (x = 0; x < FFTDATAPOINTS; ++x){
//			fftA[x] = tempFFT[x];
//			fftB[x] = tempFFT[x];
//		}
//	//Test the SRAM buffer
//	for (x = 0; x < FFTDATAPOINTS; ++x){
//			//printf("Row %d, Colmn %d: %f\n",x,y,tempFFT[x][y]);
//			//printf("Printing fftA: row %d, colmn %d: %f\n",x,y,fftA[x*TEMPCOLMN +y]);
//			if (fftA[x] != tempFFT[x]){
//				printf("Error: buffer A inconsistent at x=%d (tempFFT = %d, FFTA = %d)", x,fftA[x],tempFFT[x]);
//			}
//			if (fftB[x] != tempFFT[x]){
//				printf("Error: buffer B inconsistent at x=%d (tempFFT = %d, FFTB = %d)", x,fftA[x],tempFFT[x]);
//			}
//		}
//	printf("Done with TEMP stuff\n");
//}

//Fills the lookup-table
void fillLUT(void){
	LUT[0] = 0;
	LUT[100] = FFTDATAPOINTS - 1;
	unsigned dataPointCounter = 0;
	unsigned LUTpos = 1;
	for(;LUTpos < 100; ++LUTpos){
		for(; cnst_hz[dataPointCounter] < LUTpos * 1000;dataPointCounter++ );
		if (dataPointCounter > FFTDATAPOINTS) dataPointCounter = 1024;
		LUT[LUTpos] = dataPointCounter -1;
	}
}

int main(void){
	//temp();
	//All inits
	if (initExternal() || initText() || initDraw()) return -1;
	//Fill the lookup table
	fillLUT();
	unsigned char* FFTData = NULL;
	unsigned char minval = 0;
	unsigned char maxval = 1;
	prepareText(); //For static text
	displayHorRange(minval, maxval); //For non-static text
	prepareBackground();
	drawHelpLines();
	if(swapVGABuffer()) return -1;
	while(1){
		prepareBackground();
		clearDrawingboard();
		minval = getMinVal(); //Ask the Rotary encoder VHDL what the minval is
		maxval = minval + 1;
		if (rotary_pressed()){
			FFTData = getFullFFTData();
			drawFullGraph(FFTData);
			displayHorRange(0, 100); //For non-static text
			free(FFTData);
		} else {
			FFTData = getPartFFTData(LUT[minval], LUT[maxval]);
			drawPartGraph(FFTData,LUT[maxval] - LUT[minval]);
			displayHorRange(minval, maxval); //For non-static text
			free(FFTData);
		}
		drawHelpLines();
		if(swapVGABuffer()) return -1;
	}
	return 0;
}

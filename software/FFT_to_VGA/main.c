#include "sharedHeader.h"
#include "text.h"
#include "draw.h"
#include "FFT_temp.h"
#include "externalInterfaces.h"
#include "cnst_hz.h"

//The values is value in Hz /1000 (steps of 1 KHz)
unsigned short minval = 20;
unsigned short maxval = 21;
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
	prepareText(); //For static text
	displayHorRange(); //For non-static text
	prepareBackground();
	displayHorRange(); //For non-static text
	clearDrawingboard();
	drawHelpLines();
	if(swapVGABuffer()) return -1;
	prepareBackground();
	while(1){
		FFTData = getFFTData(LUT[minval], LUT[maxval]);
		clearDrawingboard();
		drawGraph(FFTData,LUT[maxval] - LUT[minval]);
		free(FFTData);
		drawHelpLines();
		if (rangeChanged){
			rangeChanged = 0;
			displayHorRange();
		}
		if(swapVGABuffer()) return -1;
		//Invert the buffer
		//if (buffer) buffer = 0;
		//else buffer = 1;
		//Sleep, softly.
		//usleep(USLEEP_TIME);
		displayFPS();
//		minval++;
//		maxval++;
//		if (maxval >100){
//			if (minval != 1){
//				minval = 0;
//				maxval = 100;
//			} else {
//				minval = 0;
//				maxval = 1;
//			}
//		}
		//displayHorRange(); //For non-static text
		//printf("%i",time(NULL));
	}
	return 0;
}

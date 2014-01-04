#include "sharedHeader.h"
#include "text.h"
#include "draw.h"
#include "FFT_temp.h"
#include "externalInterfaces.h"

//The values is value in Hz /1000 (steps of 1 KHz)
unsigned short minval = 2;
unsigned short maxval = 3;
char rangeChanged = 0;

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

int main(void){
	//temp();

	if (initExternal() || initText() || initDraw()) return -1;

	volatile unsigned char* currentFFT = NULL;

	//int colors[3] = {RED,GREEN,BLUE};
	//int colorIndicator = 0;
	//int buffer = 1;
	prepareText(); //For static text
	displayHorRange(); //For non-static text
	prepareBackground();
	displayHorRange(); //For non-static text
	clearDrawingboard();
	drawHelpLines();
	if(swapVGABuffer()) return -1;
	prepareBackground();
	while(1){
		currentFFT = switchFFTBuffer();
		clearDrawingboard();
		drawGraph(currentFFT, maxval, minval);
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

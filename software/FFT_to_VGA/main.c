#include "sharedHeader.h"
#include "text.h"
#include "draw.h"
#include "FFT_temp.h"


//Global vars

//Current FFT buffer
volatile unsigned char* currentFFT = NULL;
//The values is value in Hz /1000 (steps of 1 KHz)
unsigned short minval = 2;
unsigned short maxval = 3;
char rangeChanged = 0;

//Declarations of positions of buffers and hardware components
volatile int * ledR = (int*) RED_LED_PIO_BASE;
volatile int * ledG = (int*) GREEN_LED_PIO_BASE;
volatile unsigned char* fftA = (unsigned char *)0x4B000; //FFT A buffer, contains data about height in pixels (lives in SRAM)
volatile unsigned char* fftB = (unsigned char *)0x4B400; //FFT B buffer, contains data about heigt in pixels (lives in SRAM)
volatile unsigned char* control_in = (unsigned char*)CONTROL_IN_BASE; //The control in signals
volatile unsigned char* control_out = (unsigned char*)CONTROL_OUT_BASE; //The control out signals

extern alt_up_pixel_buffer_dma_dev *pixel_buffer_dev;

//This function does stuff that does not belong in the final version
void temp(void){
	//Write the const data to the mem
	int x;
	for (x = 0; x < FFTDATAPOINTS; ++x){
			fftA[x] = tempFFT[x];
			fftB[x] = tempFFT[x];
		}
	//Test the SRAM buffer
	for (x = 0; x < FFTDATAPOINTS; ++x){
			//printf("Row %d, Colmn %d: %f\n",x,y,tempFFT[x][y]);
			//printf("Printing fftA: row %d, colmn %d: %f\n",x,y,fftA[x*TEMPCOLMN +y]);
			if (fftA[x] != tempFFT[x]){
				printf("Error: buffer A inconsistent at x=%d (tempFFT = %d, FFTA = %d)", x,fftA[x],tempFFT[x]);
			}
			if (fftB[x] != tempFFT[x]){
				printf("Error: buffer B inconsistent at x=%d (tempFFT = %d, FFTB = %d)", x,fftA[x],tempFFT[x]);
			}
		}
	printf("Done with TEMP stuff\n");
}
//This function initializes everything to get it prepared for work
int init(void){

	currentFFT = fftA;
	return 0;
}

int main(void){
	temp();

	if (init() || initText() || initDraw()) return -1;

	//int colors[3] = {RED,GREEN,BLUE};
	//int colorIndicator = 0;
	//int buffer = 1;
	prepareText(); //For static text
	displayHorRange(); //For non-static text
	prepareBackground();
	displayHorRange(); //For non-static text
	clearDrawingboard();
	drawHelpLines();
	if (alt_up_pixel_buffer_dma_swap_buffers(pixel_buffer_dev)){
				printf("Buffer swapping failed!\n");
				return -1;
			}
	while (alt_up_pixel_buffer_dma_check_swap_buffers_status(pixel_buffer_dev));
	prepareBackground();
	while(1){
		//if ( colorIndicator > 2 ) colorIndicator = 0;
		//alt_up_pixel_buffer_dma_clear_screen(pixel_buffer_dev, buffer);  //Clear the buffer
		// draw something to the back buffer
		//alt_up_pixel_buffer_dma_draw_box(pixel_buffer_dev, 0, 0, 319, 239, colors[colorIndicator++], buffer);
		//VGA_box (0, 0, 319, 239, 0, pixelBuffer); // clear screen
		//VGA_box (0 /*x1*/, 0 /*y1*/, 319 /*x2*/, 239 /*y2*/, colors[colorIndicator++], pixelBuffer);
		clearDrawingboard();
		drawGraph(currentFFT, maxval, minval);
		drawHelpLines();
		if (rangeChanged){
			rangeChanged = 0;
			displayHorRange();
		}
		if (alt_up_pixel_buffer_dma_swap_buffers(pixel_buffer_dev)){
			printf("Buffer swapping failed!\n");
			return -1;
		}
		while (alt_up_pixel_buffer_dma_check_swap_buffers_status(pixel_buffer_dev));
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
		displayHorRange(); //For non-static text
		//printf("%i",time(NULL));
	}
	return 0;
}

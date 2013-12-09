//http://monash-psychophysics-test.googlecode.com/svn-history/r55/trunk/LowLevel/First_Proto/VGA_SD_Keyboard/Software/hello.c

#include <stdio.h> //printf etc
#include <unistd.h> //usleep
#include "stdlib.h"
#include "string.h" //strlen
#include "system.h" //declaration of available hardware
#include "altera_up_avalon_video_pixel_buffer_dma.h" //HAL for pixel buffer
#include "altera_up_avalon_video_character_buffer_with_dma.h" //HAL for Character Buffer
#include "altera_avalon_pio_regs.h"
#include <sys/alt_irq.h>

//Typedefs etc
typedef enum {frontbuffer, backbuffer} vgaBuffers;

//Hard Defines
#define RED 0xf800 //1111000000000
#define GREEN 0x7e0 //0000111110000
#define BLUE 0x1f //0000000001111
#define USLEEP_TIME 10000 //Sleep Time
#define BACKGROUNDCOLOR 0x0 //Black background
#define SYSLINECOLOR 0xFFFF //White lines for the "system" lines
#define INFOCOLOR RED //Red lines that contain the true information
#define FFTROWS 1024
#define FFTCOLMNS 2

//Declarations of positions of buffers and hardware components
volatile int * ledR = (int*) 0x00093050;
volatile int * ledG = (int*) 0x00093030;
volatile float* fftA = (float *)0x4B000; //FFT A buffer
volatile float* fftB = (float *)0x4D000; //FFT B buffer

//Global vars
//Device names
const char* pixelBufferName = "/dev/VGA_Pixel_Buffer";
const char* charBufferName = "/dev/VGA_Character_buffer";
//Device pointers
alt_up_pixel_buffer_dma_dev *pixel_buffer_dev;
alt_up_char_buffer_dev *char_buffer_dev;
//Measurements of the drawingboard
const unsigned short drawX0 = 13, drawX1 = 319, drawY0 = 0, drawY1 = 225;
//Current FFT buffer
volatile float* currentFFT = NULL;
//The values is value in Hz /1000 (steps of 1 KHz)
unsigned short minval = 0;
unsigned short maxval = 20;
char rangeChanged = 0;
//For FPS counting
time_t lastTime = 0;
unsigned short frames = 0;

#include "FFT_temp.h"

//This is also an temp function
void displayFPS(void){
	frames++;
	time_t currentTime = time(NULL);
	if (currentTime > lastTime){
		char tempstr[5];
		sprintf(tempstr,"%d",frames);
		alt_up_char_buffer_string(char_buffer_dev,tempstr,80 - strlen(tempstr),0);
		lastTime = currentTime;
		frames = 0;
	}
}

//This function does stuff that does not belong in the final version
void temp(void){
	//Write the const data to the mem
	int x,y;
	for (x = 0; x < FFTROWS; ++x){
		for (y = 0 ; y < FFTCOLMNS; ++y){
			fftA[x*FFTCOLMNS+y] = tempFFT[x][y];
			fftB[x*FFTCOLMNS+y] = tempFFT[x][y];
		}
	}
	//Test the SRAM buffer
	for (x = 0; x < FFTROWS; ++x){
		for (y = 0 ; y < FFTCOLMNS; ++y){
			//printf("Row %d, Colmn %d: %f\n",x,y,tempFFT[x][y]);
			//printf("Printing fftA: row %d, colmn %d: %f\n",x,y,fftA[x*TEMPCOLMN +y]);
			if (fftA[x*FFTCOLMNS +y] != tempFFT[x][y]){
				printf("Error: buffer A inconsistent at x=%d, y=%d (tempFFT = %f, FFTA = %f)", x,y,fftA[x*TEMPCOLMN +y],tempFFT[x][y]);
			}
			if (fftB[x*FFTCOLMNS +y] != tempFFT[x][y]){
				printf("Error: buffer B inconsistent at x=%d, y=%d (tempFFT = %f, FFTB = %f)", x,y,fftA[x*TEMPCOLMN +y],tempFFT[x][y]);
			}
		}
	}
	printf("Done with TEMP stuff\n");
}
//This function initializes everything to get it prepared for work
int init(void){
	pixel_buffer_dev = alt_up_pixel_buffer_dma_open_dev(pixelBufferName); //Init HAL for pixelbuffer
	if (pixel_buffer_dev == NULL)
	{
		printf("Error! pixel_buffer_dev == NULL!\n");
		return 1;
	}
	char_buffer_dev = alt_up_char_buffer_open_dev(charBufferName); //Init HAL for char buffer
	if (char_buffer_dev == NULL){
		printf("Error! char_buffer_dev == NULL!\n");
		return 1;
	}
	currentFFT = fftA;
	return 0;
}

void displayHorRange(void){
	char tempstr[3];
	sprintf(tempstr,"%d",minval);
	int pos = 3;
	if (strlen(tempstr) > 1){
		pos--;
	}
	alt_up_char_buffer_string(char_buffer_dev,tempstr, pos,57);
	sprintf(tempstr,"%d",maxval);
	alt_up_char_buffer_string(char_buffer_dev,tempstr,80 - strlen(tempstr),57);
}

void prepareText(void){
	alt_up_char_buffer_clear(char_buffer_dev);
	//Chars for the vertical line (Vpp)
	alt_up_char_buffer_string(char_buffer_dev,"2.5",0,0);
	alt_up_char_buffer_string(char_buffer_dev," V ",0,29);
	alt_up_char_buffer_string(char_buffer_dev,"0.0",0,56);
	//Chars for the horizontal line (KHz) (soft, except for KHz)
	alt_up_char_buffer_string(char_buffer_dev,"KHz",37,58);
}

void prepareBackground(void){
	alt_up_pixel_buffer_dma_clear_screen(pixel_buffer_dev, 1);  //Clear the backbuffer
	//Main lines
	alt_up_pixel_buffer_dma_draw_box(pixel_buffer_dev, 0, 0, 319, 239, BACKGROUNDCOLOR, backbuffer); //Make the backbuffer the correct color
	alt_up_pixel_buffer_dma_draw_hline(pixel_buffer_dev, 12,  319, 226,SYSLINECOLOR, backbuffer); //Draw the horizontal sysline to the backbuffer
	alt_up_pixel_buffer_dma_draw_vline(pixel_buffer_dev, 12, 0, 226,SYSLINECOLOR, backbuffer); //Draw the vertical line
}

void clearDrawingboard(void){
	//Clean up the entire draw section
	alt_up_pixel_buffer_dma_draw_box(pixel_buffer_dev, drawX0,drawY0 , drawX1, drawY1, BACKGROUNDCOLOR, backbuffer); //Make the backbuffer the correct color
	//Redraw the indicationlines
	//Smaller lines(horizontal)
	int tPos;
	for (tPos = 0; tPos < 228; tPos +=46){
		alt_up_pixel_buffer_dma_draw_hline(pixel_buffer_dev, 12,  15, tPos,SYSLINECOLOR, backbuffer); //Draw a small horizontal line for indication
	}
	//Smaller lines (vertical)
	for (tPos = 319; tPos > 31; tPos -=31){
		alt_up_pixel_buffer_dma_draw_vline(pixel_buffer_dev, tPos, 223, 226,SYSLINECOLOR, backbuffer); //Draw a small vertical line for indication
	}
}

void drawGraph(void){
	//First: count the amount of points that fits within minval and maxval
	int elementCount,x = 0, firstval = -1; //firstval indicates the startpoint in the array
	for (elementCount = 0; currentFFT[x*FFTCOLMNS + 1] <= maxval * 1000 && x < FFTROWS; x++){
		if (currentFFT[x*FFTCOLMNS+1] >= minval*1000 ){
			if (firstval < 0) firstval = x;
			elementCount++;
		}
	}
	//Malloc the necessary size
	float * voltArray = malloc(sizeof(float) * elementCount);
	//Move all volt vals to the newborn array
	for (x = firstval; x < firstval + elementCount; ++x){
		voltArray[x - firstval] = currentFFT[x*FFTCOLMNS];
	}
	float pixelsPerElement = ((float)drawX1 - (float)drawX0) / elementCount;
	if (pixelsPerElement < 1){
		int elementsProcessed, tempElementsAmount = 0, xPixel = 13;
		float tempPixelFilling = 0, tempAmount = 0;
		for (elementsProcessed = 0; elementsProcessed < elementCount; ++elementsProcessed){
			tempElementsAmount++;
			tempPixelFilling +=pixelsPerElement;
			tempAmount += voltArray[elementsProcessed];
			if (tempPixelFilling >= 1){
				tempPixelFilling -=1;
				tempAmount /= tempElementsAmount;
				int yPixel = (226 - (((float)226/2.5) * tempAmount));
				alt_up_pixel_buffer_dma_draw_vline(pixel_buffer_dev,xPixel++,yPixel,drawY1,INFOCOLOR,backbuffer);
				//alt_up_pixel_buffer_dma_draw(pixel_buffer_dev,INFOCOLOR,xPixel++, yPixel);
				tempAmount = 0;
				tempElementsAmount = 0;
				//tempPixelFilling = 0;
			}
		}
	} else { //Pixels per element > 1 (so multiple pixels are going to represent the same value)
		pixelsPerElement = 1/pixelsPerElement; //invert: pixelsPerElement is now elementsPerPixel
		float element = 0;
		int x;
		//Variables for optimalization
		int lastElement = elementCount; int yPixel = -1; //init lastElement with an impossible value to force recalculation the first time
		for ( x = drawX0; x < drawX1; ++x){ //We have the Y coördinate, calculate the x one
			int currentRealElement = (int)element; //Change the float to an int to get the correct value
			if (currentRealElement != lastElement){ //Calculate the yValue if the currentelement is different from the last calculated one
				lastElement = currentRealElement;
				yPixel = (226 - (((float)226/2.5) * voltArray[lastElement]));

			}
			element+= pixelsPerElement;
			alt_up_pixel_buffer_dma_draw_vline(pixel_buffer_dev,x,yPixel,drawY1,INFOCOLOR,backbuffer);
		}
	}
	//Free the array and cleanup
	free(voltArray);
	voltArray = NULL;
}

int main(void){
	temp();
	if (init()) return -1;

	//int colors[3] = {RED,GREEN,BLUE};
	//int colorIndicator = 0;
	//int buffer = 1;
	prepareText();
	displayHorRange();
	prepareBackground();
	clearDrawingboard();
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
		drawGraph();
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
		//printf("%i",time(NULL));
	}
	return 0;
}

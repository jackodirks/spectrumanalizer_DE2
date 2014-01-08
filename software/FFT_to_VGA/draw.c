#include "draw.h"


//TODO: Add lookup tables

//Typedefs etc
typedef enum {frontbuffer, backbuffer} vgaBuffers;
//Device names
const char* pixelBufferName = "/dev/VGA_Pixel_Buffer";
//Measurements of the drawingboard
const unsigned short drawX0 = 13, drawX1 = 319, drawY0 = 0, drawY1 = 225;

//Device pointers
alt_up_pixel_buffer_dma_dev *pixel_buffer_dev;

int initDraw(void){
	pixel_buffer_dev = alt_up_pixel_buffer_dma_open_dev(pixelBufferName); //Init HAL for pixelbuffer
	if (pixel_buffer_dev == NULL)
	{
		printf("Error! pixel_buffer_dev == NULL!\n");
		return 1;
	}
	return 0;
}

void prepareBackground(void){
	alt_up_pixel_buffer_dma_clear_screen(pixel_buffer_dev, backbuffer);  //Clear the backbuffer
	//Main lines
	alt_up_pixel_buffer_dma_draw_box(pixel_buffer_dev, 0, 0, 319, 239, BACKGROUNDCOLOR, backbuffer); //Make the backbuffer the correct color
	alt_up_pixel_buffer_dma_draw_hline(pixel_buffer_dev, 12,  319, 226,SYSLINECOLOR, backbuffer); //Draw the horizontal sysline to the backbuffer
	alt_up_pixel_buffer_dma_draw_vline(pixel_buffer_dev, 12, 0, 226,SYSLINECOLOR, backbuffer); //Draw the vertical line
}

void clearDrawingboard(void){
	//Clean up the entire draw section
	alt_up_pixel_buffer_dma_draw_box(pixel_buffer_dev, drawX0,drawY0 , drawX1, drawY1, BACKGROUNDCOLOR, backbuffer); //Make the backbuffer the correct color
}

void drawHelpLines(void){
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

void drawGraph(unsigned char* voltArray, unsigned elementCount){
	//First: count the amount of points that fits within minval and maxval
	//TOBEREPLACED (unsigned char* voltArray, unsigned elementCount
//	int elementCount,x = 0, firstval = -1; //firstval indicates the startpoint in the array
//	for (elementCount = 0; cnst_hz[x] <= maxval * 1000 && x < FFTDATAPOINTS; x++){
//		if (cnst_hz[x] >= minval*1000 ){
//			if (firstval < 0) firstval = x;
//			elementCount++;
//		}
//	}
//	volatile unsigned char * voltArray = &currentFFT[firstval]; //Point voltArray to the correct place in the array.


	float pixelsPerElement = (((float)(drawX1) - (float)drawX0) + 1.0) / elementCount;
	if (pixelsPerElement < 1){
		int elementsProcessed, xPixel = 13, highestPeak = 225;
		float tempPixelFilling = 0;
		for (elementsProcessed = 0; elementsProcessed < elementCount; ++elementsProcessed){
			tempPixelFilling +=pixelsPerElement;
			if (voltArray[elementsProcessed] < highestPeak) highestPeak = voltArray[elementsProcessed];
			if (tempPixelFilling >= 1){
				tempPixelFilling -=1;
				alt_up_pixel_buffer_dma_draw_vline(pixel_buffer_dev,xPixel++,highestPeak,drawY1,INFOCOLOR,backbuffer);
				//alt_up_pixel_buffer_dma_draw(pixel_buffer_dev,INFOCOLOR,xPixel++, yPixel);
				highestPeak = 225;
				//tempPixelFilling = 0;displayHorRange(); //For non-static text
			}
		}
	} else { //Pixels per element > 1 (so multiple pixels are going to represent the same value)
		pixelsPerElement = 1/pixelsPerElement; //invert: pixelsPerElement is now elementsPerPixel
		float element = 0;
		int x;
		for ( x = drawX0; x <= drawX1; ++x){ //We have the Y coördinate, calculate the x one
			alt_up_pixel_buffer_dma_draw_vline(pixel_buffer_dev,x,voltArray[(int)element],drawY1,INFOCOLOR,backbuffer);
			element+= pixelsPerElement;
		}
	}
}

int swapVGABuffer(void){
	if (alt_up_pixel_buffer_dma_swap_buffers(pixel_buffer_dev)){
		return 1;
	}
	while (alt_up_pixel_buffer_dma_check_swap_buffers_status(pixel_buffer_dev));
	return 0;
}

#include "draw.h"

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

void drawFullGraph(unsigned char* voltArray){
	const unsigned elementCount = 307;
	unsigned temp;
	for(temp = 0; temp < elementCount; ++temp){
		alt_up_pixel_buffer_dma_draw_vline(pixel_buffer_dev,drawX0 + temp,voltArray[temp],drawY1,INFOCOLOR,backbuffer);

	}
}

void drawPartGraph(unsigned char* voltArray, unsigned elementCount){
	//calculate the width of every element
	float f = 307 / elementCount;
	int elementWidth = (int)f;
	int lastElementWidth = 307 - ((elementCount - 1) * elementWidth);
	int temp;
	for (temp = 0 ; temp < elementCount-1; ++temp ){
		alt_up_pixel_buffer_dma_draw_box(pixel_buffer_dev, drawX0 + temp * elementWidth, voltArray[temp], drawX0 + (temp+1) * elementWidth,drawY1, INFOCOLOR,backbuffer);
	}
	//draw the last element
	alt_up_pixel_buffer_dma_draw_box(pixel_buffer_dev,drawX1 -lastElementWidth, voltArray[elementCount-1], drawX1, drawY1, INFOCOLOR,backbuffer);
	//alt_up_pixel_buffer_dma_draw_box(pixel_buffer_dev, drawX0 + (elementCount - 2) * lastElementWidth, voltArray[elementCount-1], drawX1,drawY1, INFOCOLOR,backbuffer);
	return;
}

int swapVGABuffer(void){
	if (alt_up_pixel_buffer_dma_swap_buffers(pixel_buffer_dev)){
		return 1;
	}
	while (alt_up_pixel_buffer_dma_check_swap_buffers_status(pixel_buffer_dev));
	return 0;
}

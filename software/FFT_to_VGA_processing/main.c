//http://monash-psychophysics-test.googlecode.com/svn-history/r55/trunk/LowLevel/First_Proto/VGA_SD_Keyboard/Software/hello.c

#include <stdio.h> //printf etc
#include <unistd.h> //usleep
#include "system.h" //declaration of available hardware
#include "altera_up_avalon_video_pixel_buffer_dma.h" //HAL for pixel buffer
#include "altera_up_avalon_video_character_buffer_with_dma.h" //HAL for Character Buffer
#include "altera_avalon_pio_regs.h"
#include <sys/alt_irq.h>

//Hard Defines
#define RED 0xf800 //1111000000000
#define GREEN 0x7e0 //0000111110000
#define BLUE 0x1f //0000000001111
#define USLEEP_TIME 1000000

//Declarations of positions of buffers and hardware components
volatile int * ledR = (int*) 0x00093050;
volatile int * ledG = (int*) 0x00093030;
volatile int * keys = (int*) 0x00093020;
volatile char * character_buffer = (char *) 0x00090000;	// VGA character buffer
volatile float* fftA = (float *)0x4B000; //FFT A buffer


//Global vars
//Device names
const char* pixelBufferName = "/dev/VGA_Pixel_Buffer";
const char* charBufferName = "/dev/VGA_Character_buffer_avalon_char_control_slave";
//Device pointers
alt_up_pixel_buffer_dma_dev *pixel_buffer_dev;
alt_up_char_buffer_dev *char_buffer_dev;
//The values is value in Hz /1000 (steps of 1 KHz)
unsigned short minval = 0;
unsigned short maxVal = 1;

#include "FFT_temp.h"

//This function does stuff that does not belong in the final version
void temp(void){
	//Write the const data to the mem
	int x,y;
	for (x = 0; x < TEMPROW; ++x){
		for (y = 0 ; y < TEMPCOLMN; ++y){
			fftA[y*TEMPCOLMN+x] = tempFFT[x][y];
		}
	}
	//Test the SRAM buffer
	for (x = 0; x < TEMPROW; ++x){
		for (y = 0 ; y < TEMPCOLMN; ++y){
			printf("Row %d, Colmn %d: %f\n",x,y,fftA[y*TEMPCOLMN+x]);
		}
	}
}
//This function initializes everything to get it prepared for work
void init(void){
	pixel_buffer_dev = alt_up_pixel_buffer_dma_open_dev(pixelBufferName); //Init HAL for pixelbuffer
	char_buffer_dev = alt_up_char_buffer_open_dev(charBufferName); //Init HAL for char buffer
}

int main(void){
	temp();
	init();
	int colors[3] = {RED,GREEN,BLUE};
	int colorIndicator = 0;
	int buffer = 1;
	while(1){
		if ( colorIndicator > 2 ) colorIndicator = 0;
		alt_up_pixel_buffer_dma_clear_screen(pixel_buffer_dev, buffer);  //Clear the buffer
		// draw something to the back buffer
		alt_up_pixel_buffer_dma_draw_box(pixel_buffer_dev, 0, 0, 319, 239, colors[colorIndicator++], buffer);
		//VGA_box (0, 0, 319, 239, 0, pixelBuffer); // clear screen
		//VGA_box (0 /*x1*/, 0 /*y1*/, 319 /*x2*/, 239 /*y2*/, colors[colorIndicator++], pixelBuffer);
		if (alt_up_pixel_buffer_dma_swap_buffers(pixel_buffer_dev)){
			printf("Buffer swapping failed!\n");
			return -1;
		}
		while (alt_up_pixel_buffer_dma_check_swap_buffers_status(pixel_buffer_dev));
		//Sleep, softly.
		usleep(USLEEP_TIME);
	}
	return 0;
}

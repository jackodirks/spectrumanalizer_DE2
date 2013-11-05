//http://monash-psychophysics-test.googlecode.com/svn-history/r55/trunk/LowLevel/First_Proto/VGA_SD_Keyboard/Software/hello.c

#include <stdio.h> //printf etc
#include <unistd.h> //usleep
#include "system.h" //declaration of available hardware
#include "altera_up_avalon_video_pixel_buffer_dma.h" //For buffer swapping etc
#include "altera_avalon_pio_regs.h"
#include <sys/alt_irq.h>

//Declarations of inputs and outputs
volatile int * ledR = (int*) 0x00093050;
volatile int * ledG = (int*) 0x00093030;
volatile int * keys = (int*) 0x00093020;
volatile char * character_buffer = (char *) 0x00090000;	// VGA character buffer
volatile int edge_capture;
volatile void * end_front_buffer = 0x257FFF;
volatile void * end_sram = 0x7FFFF;
alt_up_pixel_buffer_dma_dev *pixel_buffer_dev;

#define RED 0xf800
#define GREEN 0x7e0
#define BLUE 0x1f
#define USLEEP_TIME 1000000

void handle_button_interrupts(void* context){
	volatile int* edge_capture_ptr = (volatile int*) context; //get the context and typecast it (?)
	*edge_capture_ptr = IORD_ALTERA_AVALON_PIO_EDGE_CAP(KEY_PIO_BASE); //Get the value
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_PIO_BASE, 0); //Reset the interrupt
	IORD_ALTERA_AVALON_PIO_EDGE_CAP(KEY_PIO_BASE); //Delay for a little bit to prevent imediate reïnterrupt
	*ledG = *keys;
	*ledR = *edge_capture_ptr; //Print the outputs to the LEDS to see what the program sees
	//printf("Im HERE!\n");
}

int main(void){
	//Setup the interrupts
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(KEY_PIO_BASE, 0xf);
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_PIO_BASE, 0x0);
	/*alt_ic_isr_register(KEY_PIO_IRQ_INTERRUPT_CONTROLLER_ID,
			KEY_PIO_IRQ,
			handle_button_interrupts,
			(void*) &edge_capture, 0x0);*/
	//alt_irq_enable(KEY_PIO_IRQ); //Not sure if necessary, starts the software interrupt (something with priority)
	int colors[3] = {RED,GREEN,BLUE};
	int colorIndicator = 0;
	int buffer = 1;
	pixel_buffer_dev = alt_up_pixel_buffer_dma_open_dev("/dev/VGA_Pixel_Buffer");
	/*while(1){
		if ( colorIndicator > 2 ) colorIndicator = 0;
		alt_up_pixel_buffer_dma_draw_box(pixel_buffer_dev, 0, 0, 319, 239, colors[colorIndicator++], buffer);
		long i;
		for (i = end_front_buffer; i < end_sram; ++i){
			char * pixel = (char*) i;
			*pixel = 0;
		}
		if (alt_up_pixel_buffer_dma_swap_buffers(pixel_buffer_dev)){
			printf("Buffer swapping failed!\n");
			return -1;
		}
		//Also swap internally
		//buffer = !buffer;
		//Wait for the swap to be done
		while (alt_up_pixel_buffer_dma_check_swap_buffers_status(pixel_buffer_dev));
		usleep(USLEEP_TIME);
	}*/

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
		//Also swap internally
		//buffer = !buffer;
		//Wait for the swap to be done
		while (alt_up_pixel_buffer_dma_check_swap_buffers_status(pixel_buffer_dev));

		//Sleep, softly.
		usleep(USLEEP_TIME);
	}

	return 0;
}

#ifndef SHAREDHEADER_H
#define SHAREDHEADER_H

#include <stdio.h> //printf etc
#include <unistd.h> //usleep
#include "time.h" //Time_t, time()
#include "stdlib.h"
#include "string.h" //strlendisplayHorRange
#include "system.h" //declaration of available hardware
#include "altera_up_avalon_video_pixel_buffer_dma.h" //HAL for pixel buffer
#include "altera_up_avalon_video_character_buffer_with_dma.h" //HAL for Character Buffer
#include "altera_avalon_pio_regs.h"
#include <sys/alt_irq.h>

//Hard Defines
#define RED 0xf800 //1111000000000
#define GREEN 0x7e0 //0000111110000
#define BLUE 0x1f //0000000001111
#define USLEEP_TIME 50000 //Sleep Time
#define BACKGROUNDCOLOR 0x0 //Black background
#define SYSLINECOLOR 0xFFFF //White lines for the "system" lines
#define INFOCOLOR RED //Red lines that contain the true information
#define FFTDATAPOINTS 1024

#endif //SHAREDHEADER_H

#include "text.h"

//device name
const char* charBufferName = "/dev/VGA_Character_buffer";
//Device pointers
alt_up_char_buffer_dev *char_buffer_dev;

//For FPS counting
time_t lastTime = 0;
unsigned short frames = 0;

//Externs for maxval and minval
extern unsigned short minval;
extern unsigned short maxval;

int initText(void){
	char_buffer_dev = alt_up_char_buffer_open_dev(charBufferName); //Init HAL for char buffer
	if (char_buffer_dev == NULL){
		printf("Error! char_buffer_dev == NULL!\n");
		return 1;
	}
	return 0;
}

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

void prepareText(void){
	alt_up_char_buffer_clear(char_buffer_dev);
	//Chars for the vertical line (Vpp)
	alt_up_char_buffer_string(char_buffer_dev,"2.5",0,0);
	alt_up_char_buffer_string(char_buffer_dev," V ",0,29);
	alt_up_char_buffer_string(char_buffer_dev,"0.0",0,56);
	//Chars for the horizontal line (kHz) (soft, except for kHz)
	alt_up_char_buffer_string(char_buffer_dev,"kHz",37,58);
}

void displayHorRange(void){
	char tempstr[3];
	sprintf(tempstr,"%d",minval);
	int pos = 3;
	if (strlen(tempstr) > 1){
		pos--;
	} else {
		alt_up_char_buffer_string(char_buffer_dev," ", pos-1,57);
	}
	alt_up_char_buffer_string(char_buffer_dev,tempstr, pos,57);
	sprintf(tempstr,"%d",maxval);

	if (strlen(tempstr) < 3){
		alt_up_char_buffer_string(char_buffer_dev,"  ",80 - 3,57);
	} else 	if (strlen(tempstr) < 2){
		alt_up_char_buffer_string(char_buffer_dev," ",80 - 2,57);
	}
	alt_up_char_buffer_string(char_buffer_dev,tempstr,80 - strlen(tempstr),57);
}

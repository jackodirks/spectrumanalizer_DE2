#ifndef EXTERNALINTERFACES_H
#define EXTERNALINTERFACES_H

#include "sharedHeader.h"

//This file manages anything related to the control signals and bufferselection

int initExternal(void);

//Switches buffer and returns address of new buffer (locks until done).
volatile unsigned char* switchFFTBuffer(void);

#endif //EXTERNALINTERFACES_H


#ifndef DRAW_H
#define DRAW_H

#include "sharedHeader.h"

int initDraw(void);
void prepareBackground(void);
void clearDrawingboard(void);
void drawHelpLines(void);
void drawGraph(volatile unsigned char* currentFFT, unsigned int mavVal, unsigned int minval);

#endif //DRAW_H

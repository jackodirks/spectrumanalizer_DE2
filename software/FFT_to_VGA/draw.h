#ifndef DRAW_H
#define DRAW_H

//Manages anything related to linedrawing

#include "sharedHeader.h"

int initDraw(void);
void prepareBackground(void);
void clearDrawingboard(void);
void drawHelpLines(void);
void drawPartGraph(unsigned char* voltArray, unsigned elementCount);
void drawFullGraph(unsigned char* voltArray);
int swapVGABuffer(void);

#endif //DRAW_H

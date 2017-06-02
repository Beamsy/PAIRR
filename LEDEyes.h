#ifndef _LEDEYES_h
#define _LEDEYES_h

#include "arduino.h"

class LEDEyes
{

public:
	// Constructor
	LEDEyes();

	void lookLeft();
	void lookLeft1();
	void lookRight();
	void lookRight1();
	void lookUp();
	void lookUp1();
	void lookDown();
	void lookDown1();
	void eyeCenter();
	void eyeBlink();

	void eyesAwake();
	void eyesRest();

private:
	unsigned long delayTime;
	unsigned long pauseTime;
	unsigned long moveTime;
	unsigned long restTime;
};
#endif
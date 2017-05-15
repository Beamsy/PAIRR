#ifndef _LEDEYES_h
#define _LEDEYES_h

#include "arduino.h"

class LEDEyes
{


public:
	// Constructor
	LEDEyes();

	// Destructor - deletes the object
	~LEDEyes();

	void leftEyeLeft();
	void rightEyeLeft();
	void leftEyeRight();
	void rightEyeRight();
	void lEleft1();
	void centerL();
	void centerR();
	void lEright1();
	void rEleft1();
	void rEright1();
	void lEUp();
	void rEDown();
	void rEDown1();
	void lEDown();
	void lEDown1();
	void leftEyeBlink();
	void rightEyeBlink();
	void mouthUnhappy();
	void mouthHappy();
	void mouthHappy1();
	void mouthUnhappy1();

	void faceHappy();
	void faceBlink();
	void faceAsleep();
	void faceAwake();
	void faceSad();

};
#endif
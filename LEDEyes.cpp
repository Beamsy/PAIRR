#include "LEDEyes.h"

// This allows the code to use the LedControl library
#include "LedControl.h"

// Pins: DIN,CLK,CS, number of Display connected
LedControl lc = LedControl(12, 11, 10, 1);

// Eye Position Arrays
byte right[] =
{
	B00111100,
	B01100110,
	B11100111,
	B11111111,
	B11111111,
	B11111111,
	B01111110,
	B00111100
};

byte left[] =
{
	B00111100,
	B01111110,
	B11111111,
	B11111111,
	B11111111,
	B11100111,
	B01100110,
	B00111100
};

byte right1[] =
{
	B00111100,
	B01111110,
	B11100111,
	B11100111,
	B11111111,
	B11111111,
	B01111110,
	B00111100
};

byte left1[] =
{
	B00111100,
	B01111110,
	B11111111,
	B11111111,
	B11100111,
	B11100111,
	B01111110,
	B00111100
};

byte center[] =
{
	B00111100,
	B01111110,
	B11111111,
	B11100111,
	B11100111,
	B11111111,
	B01111110,
	B00111100
};

byte down[] =
{
	B00111100,
	B01111110,
	B11111111,
	B11111001,
	B11111001,
	B11111111,
	B01111110,
	B00111100
};

byte down1[] =
{
	B00111100,
	B01111110,
	B11111111,
	B11110011,
	B11110011,
	B11111111,
	B01111110,
	B00111100
};

byte up[] =
{
	B00111100,
	B01111110,
	B11111111,
	B10011111,
	B10011111,
	B11111111,
	B01111110,
	B00111100
};

byte up1[] =
{
	B00111100,
	B01111110,
	B11111111,
	B11001111,
	B11001111,
	B11111111,
	B01111110,
	B00111100
};

byte blink[] =
{
	B00011000,
	B00011000,
	B00011000,
	B00011000,
	B00011000,
	B00011000,
	B00011000,
	B00011000
};


// Constructor, set up LED boards and serial connection
LEDEyes::LEDEyes()
{
	// Wake up displays
	lc.shutdown(0, false);

	// Set intensity levels
	lc.setIntensity(0, 5);

	// Clear Displays
	lc.clearDisplay(0);

	restTime = 3000;
	delayTime = 1000;
	pauseTime = 200;
	moveTime = 50;

	Serial.begin(9600);
}

//  Take values stored in the Arrays, loop through and Display them
void LEDEyes::lookUp()
{
	for (int i = 0; i < 8; i++)
	{
		// Set the row of the given LED board(the 1st param),
		// using the given array(3rd param)
		lc.setRow(0, i, up[i]);
	}
}

void LEDEyes::lookUp1()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, up1[i]);
	}
}

void LEDEyes::lookDown()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, down[i]);
	}
}

void LEDEyes::lookDown1()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, down1[i]);
	}
}

void LEDEyes::lookLeft()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, left[i]);
	}
}

void LEDEyes::lookLeft1()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, left1[i]);
	}
}

void LEDEyes::lookRight()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, right[i]);
	}
}

void LEDEyes::lookRight1()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, right1[i]);
	}
}

void LEDEyes::eyeCenter()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, center[i]);
	}
}

void LEDEyes::eyeBlink()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, blink[i]);
	}
}

void LEDEyes::eyesAwake()
{
	eyeCenter();
	delay(delayTime);
	lookLeft1();
	delay(moveTime);
	lookLeft();
	delay(pauseTime);
	lookLeft1();
	delay(moveTime);
	eyeCenter();
	delay(moveTime);
	lookRight1();
	delay(moveTime);
	lookRight();
	delay(pauseTime);
	lookRight1();
	delay(moveTime);
	eyeCenter();
	delay(delayTime);
	eyeBlink();
	delay(pauseTime);
	eyeCenter();
}

void LEDEyes::eyesRest()
{
	eyeCenter();
	delay(restTime);
	eyeBlink();
	delay(pauseTime);
	eyeCenter();
	delay(restTime);
	eyeBlink();
	delay(pauseTime);
	eyeCenter();
	delay(pauseTime);
	eyeBlink();
	delay(pauseTime);
	eyeCenter();
}
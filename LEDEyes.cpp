#include "LEDEyes.h"

// This allows the code to use the LedControl library
#include "LedControl.h"
 
// Pins: DIN,CLK,CS, number of Display connected
LedControl lc = LedControl(12, 11, 10, 3);
 

// Before we go on, this code is not perfect and was written at midnight, it needs refining and there are better ways to do a lot of it
// Feel free to add to this!!!


// Put the values in arrays for each of the eye/mouth positions
// Naming convention for arrays: 
// L = look left
// R = look right
// D = look down
// U = look up
// 0 = left eye, or the first LED board
// 1 = right eye, or the second LED board
// The number at the end relates to how far across the eye moves in the given direction - L0R11 == as below but 1 step in from the edge
// So the first array, L0R1 = look left for the left eye/first board -- look right for the right eye/second board
// The reason for the backwards naming is because the name can't begin with a number
// Eye Arrays
byte L0R1[] =
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

byte R0L1[] =
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

byte L0R11[] =
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

byte R0L11[] =
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

byte centerEye[] =
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

byte U0D1[] =
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

byte U0D11[] =
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

byte D0U1[] =
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

byte D0U11[] =
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

byte eyeBlink[] =
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


// Arrays for the mouth
byte unhappy[] =
{
	B10000001,
	B11000011,
	B10111101,
	B10000001,
	B01000010,
	B00111100,
	B00000000,
	B00000000
};

byte unhappy1[] =
{
	B00000000,
	B00000000,
	B11111111,
	B10000001,
	B01000010,
	B00111100,
	B00000000,
	B00000000
};

byte happy1[] =
{
	B00000000,
	B00000000,
	B00111100,
	B01000010,
	B10000001,
	B11111111,
	B00000000,
	B00000000
};

byte happy[] =
{
	B00000000,
	B00000000,
	B00111100,
	B01000010,
	B10000001,
	B10111101,
	B11000011,
	B10000001
};

LEDEyes::LEDEyes()
{
	// Wake up displays
	lc.shutdown(0, false);
	lc.shutdown(1, false);
	lc.shutdown(2, false);

	// Set intensity levels
	lc.setIntensity(0, 5);
	lc.setIntensity(1, 5);
	lc.setIntensity(2, 5);

	// Clear Displays
	lc.clearDisplay(0);
	lc.clearDisplay(1);
	lc.clearDisplay(2);

	Serial.begin(9600);
}

//  Take values stored in the Arrays, loop through and Display them
void LEDEyes::leftEyeLeft()
{
	for (int i = 0; i < 8; i++)
	{
		// Set the row of the given LED board(the 1st param),
		// using the given array(3rd param)
		lc.setRow(0, i, L0R1[i]);
	}
}

void LEDEyes::rightEyeLeft()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(1, i, R0L1[i]);
	}
}

void LEDEyes::leftEyeRight()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, R0L1[i]);
	}
}

void LEDEyes::rightEyeRight()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(1, i, L0R1[i]);
	}
}

void LEDEyes::lEleft1()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, L0R11[i]);
	}
}

void LEDEyes::centerL()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, centerEye[i]);
	}
}

void LEDEyes::centerR()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(1, i, centerEye[i]);
	}
}

// Methods to move left eye 
void LEDEyes::lEright1()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, R0L11[i]);
	}
}

void LEDEyes::rEleft1()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(1, i, R0L11[i]);
	}
}

void LEDEyes::rEright1()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(1, i, L0R11[i]);
	}
}

void LEDEyes::lEUp()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, U0D1[i]);
	}
}

void LEDEyes::rEDown()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(1, i, U0D1[i]);
	}
}

void LEDEyes::rEDown1()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(1, i, U0D11[i]);
	}
}

void LEDEyes::lEDown()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, D0U1[i]);
	}
}

void LEDEyes::lEDown1()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, D0U11[i]);
	}
}

void LEDEyes::leftEyeBlink()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(0, i, eyeBlink[i]);
	}
}

void LEDEyes::rightEyeBlink()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(1, i, eyeBlink[i]);
	}
}


// Methods for moving the mouth
void LEDEyes::mouthUnhappy()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(2, i, unhappy[i]);
	}
}

void LEDEyes::mouthHappy()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(2, i, happy[i]);
	}
}

void LEDEyes::mouthHappy1()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(2, i, happy1[i]);
	}
}

void LEDEyes::mouthUnhappy1()
{
	for (int i = 0; i < 8; i++)
	{
		lc.setRow(2, i, unhappy1[i]);
	}
}

void LEDEyes::faceAwake()
{
	mouthHappy();
	centerL();
	centerR();
}

void LEDEyes::faceAsleep()
{
	mouthHappy();
	leftEyeBlink();
	rightEyeBlink();
}

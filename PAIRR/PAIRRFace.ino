#include <LEDEyes.h>

unsigned long delayTime = 1000;
unsigned long blinkTime = 200;
unsigned long moveTime = 50;

LEDEyes ledEyes;

void setup()
{}

void loop()
{
	if (Serial.available())
	{
		// Get the number that is sent over serial, in this case from the RPi.
		// Must subtract the ASCII value of zero (48) 
		// to get the true value from the character that is sent
		int serialInput = (Serial.read() - '0');
		int wakeUp = 1;

		ledEyes.faceAsleep();

		if (serialInput == wakeUp)
		{
			ledEyes.faceAwake();
		}

		delay(2000);
	}
}

int dataIn = 12;
int load = 10;
int clock = 11;

int maxInUse = 1;  // How many units in use

int e = 0; // just a variable

int d = 40; // short delay time
int m = 30; // medium delay time

// define max7219 registors
byte max7219_reg_noop = 0x00;
byte max7219_reg_digit0 = 0x01;
byte max7219_reg_digit1 = 0x02;
byte max7219_reg_digit2 = 0x03;
byte max7219_reg_digit3 = 0x04;
byte max7219_reg_digit4 = 0x05;
byte max7219_reg_digit5 = 0x06;
byte max7219_reg_digit6 = 0x07;
byte max7219_reg_digit7 = 0x08;
byte max7219_reg_decodeMode = 0x09;
byte max7219_reg_intensity = 0x0a;
byte max7219_reg_scanLimit = 0x0b;
byte max7219_reg_shutdown = 0x0c;
byte max7219_reg_displayTest = 0x0f;

void putByte(byte data) {
  byte i = 8;
  byte mask;
  while(i > 0) {
    mask = 0x01 << (i - 1);      // get bitmask
    digitalWrite( clock, LOW);   // tick
    if (data & mask){            // choose bit
      digitalWrite(dataIn, HIGH);// send 1
    }else{
      digitalWrite(dataIn, LOW); // send 0
    }
    digitalWrite(clock, HIGH);   // tock
    --i;                         // move to lesser bit
  }
}

void maxSingle( byte reg, byte col) {    
//maxSingle is the "easy"  function to use for a single max7219
 
  digitalWrite(load, LOW);       // begin    
  putByte(reg);                  // specify register
  putByte(col); //((data & 0x01) * 256) + data >> 1); // put data  
  digitalWrite(load, LOW);       // and load da stuff
  digitalWrite(load,HIGH);
}

void setup() {
  pinMode(dataIn, OUTPUT);
  pinMode(clock,  OUTPUT);
  pinMode(load,   OUTPUT);
 
 
  //initiation of the max 7219
  maxSingle(max7219_reg_scanLimit, 0x07);      
  maxSingle(max7219_reg_decodeMode, 0x00);  // using an led matrix (not digits)
  maxSingle(max7219_reg_shutdown, 0x01);    // not in shutdown mode
  maxSingle(max7219_reg_displayTest, 0x00); // no display test
  for (e=1; e<=8; e++) {                    // empty registers, turn all LEDs off
    maxSingle(e,0);
  }
  maxSingle(max7219_reg_intensity, 0x0f & 0x0f);    // the first 0x0f is the value you can set
                                                    // range: 0x00 to 0x0f                                          
}

void loop() {

  // Stare Ahead
  eyeOpen();
  delay(2000);

  // Look Left and Right
  lookLeft();
  delay(m);
  eyeOpen();
  delay(m);
  lookRight();
  delay(m);
  eyeOpen();
  delay(m);
  lookLeft();
  delay(m);
  eyeOpen();
  delay(m);
  lookRight();
  delay(2000);
  eyeOpen();
  delay(m);

  //Blink Twice and Stay Open
  openToClosedBlink();
  closedToOpenBlink();
  openToClosedBlink();
  closedToOpenBlink();

  // Stare Ahead
  eyeOpen();
  delay(2000);
  
  // Look Up And Down
  lookUp();
  delay(m);
  eyeOpen();
  delay(m);
  lookDown();
  delay(m);
  eyeOpen();
  delay(m);
  lookUp();
  delay(m);
  eyeOpen();
  delay(m);
  lookDown();
  delay(2000);
  eyeOpen();
  delay(m);

  //Blink Twice and Stay Open
  openToClosedBlink();
  closedToOpenBlink();
  openToClosedBlink();
  closedToOpenBlink();

  // Stare ahead
  eyeOpen();
  delay(4000);

  // Roll eyes anti-clockwise
  lookUp();
  delay(m);
  lookUpLeft();
  delay(m);
  lookLeft();
  delay(m);
  lookDownLeft();
  delay(m);
  lookDown();
  delay(m);
  lookDownRight();
  delay(m);
  lookRight();
  delay(m);
  lookUpRight();
  delay(m);
  lookUp();
  delay(m);
  lookUpLeft();
  delay(m);
  lookLeft();
  delay(m);
  lookDownLeft();
  delay(m);
  lookDown();
  delay(m);
  lookDownRight();
  delay(m);
  lookRight();
  delay(m);
  lookUpRight();
  delay(m);
  lookUp();
  delay(m);
  eyeOpen();
  delay(m);

  //Blink Twice and Stay Open
  openToClosedBlink();
  closedToOpenBlink();
  openToClosedBlink();
  closedToOpenBlink();

  // Stare ahead
  eyeOpen();
  delay(4000);

  
  // Roll eyes clockwise
  lookUp();
  delay(m);
  lookUpRight();
  delay(m);
  lookRight();
  delay(m);
  lookDownRight();
  delay(m);
  lookDown();
  delay(m);
  lookDownLeft();
  delay(m);
  lookLeft();
  delay(m);
  lookUpLeft();
  delay(m);
  lookUp();
  delay(m);
  lookUpRight();
  delay(m);
  lookRight();
  delay(m);
  lookDownRight();
  delay(m);
  lookDown();
  delay(m);
  lookDownLeft();
  delay(m);
  lookLeft();
  delay(m);
  lookUpLeft();
  delay(m);
  lookUp();
  delay(m);
  eyeOpen();
  delay(m);

  //Blink Twice and Stay Open
  openToClosedBlink();
  closedToOpenBlink();
  openToClosedBlink();
  closedToOpenBlink();

  // Stare ahead
  eyeOpen();
  delay(4000);
  
  // Blink to Closed
  openToClosedBlink();
  closedToOpenBlink();
  openToClosedBlink();

  // Sleep
  eyeClosed();
  delay(4000);

  // Blink to Open
  closedToOpenBlink();
  openToClosedBlink();
  closedToOpenBlink();

}

// Animation Frames

void eyeOpen() {
  maxSingle(1,60);
  maxSingle(2,126);
  maxSingle(3,195);
  maxSingle(4,219);
  maxSingle(5,219);
  maxSingle(6,195);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
}

void eyeClosed() {
  maxSingle(1,0);
  maxSingle(2,0);
  maxSingle(3,129);
  maxSingle(4,195);
  maxSingle(5,255);
  maxSingle(6,255);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
}

void openToClosedBlink() {
  // eye open
  maxSingle(1,60);
  maxSingle(2,126);
  maxSingle(3,195);
  maxSingle(4,219);
  maxSingle(5,219);
  maxSingle(6,195);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
  // eye closing - frame 1
  maxSingle(1,0);
  maxSingle(2,126);
  maxSingle(3,255);
  maxSingle(4,219);
  maxSingle(5,219);
  maxSingle(6,195);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
  // eye closing - frame 2
  maxSingle(1,0);
  maxSingle(2,0);
  maxSingle(3,255);
  maxSingle(4,255);
  maxSingle(5,219);
  maxSingle(6,195);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
  // eye closing - frame 3
  maxSingle(1,0);
  maxSingle(2,0);
  maxSingle(3,129);
  maxSingle(4,255);
  maxSingle(5,255);
  maxSingle(6,195);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
  // eye closed
  maxSingle(1,0);
  maxSingle(2,0);
  maxSingle(3,129);
  maxSingle(4,195);
  maxSingle(5,255);
  maxSingle(6,255);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
}  

void closedToOpenBlink() {
  // eye closed
  maxSingle(1,0);
  maxSingle(2,0);
  maxSingle(3,129);
  maxSingle(4,195);
  maxSingle(5,255);
  maxSingle(6,255);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
  // eye closing - frame 3
  maxSingle(1,0);
  maxSingle(2,0);
  maxSingle(3,129);
  maxSingle(4,255);
  maxSingle(5,255);
  maxSingle(6,195);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
  // eye closing - frame 2
  maxSingle(1,0);
  maxSingle(2,0);
  maxSingle(3,255);
  maxSingle(4,255);
  maxSingle(5,219);
  maxSingle(6,195);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
  // eye closing - frame 1
  maxSingle(1,0);
  maxSingle(2,126);
  maxSingle(3,255);
  maxSingle(4,219);
  maxSingle(5,219);
  maxSingle(6,195);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
  // eye open
  maxSingle(1,60);
  maxSingle(2,126);
  maxSingle(3,195);
  maxSingle(4,219);
  maxSingle(5,219);
  maxSingle(6,195);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
}

void lookLeft() {
  maxSingle(1,60);
  maxSingle(2,126);
  maxSingle(3,195);
  maxSingle(4,243);
  maxSingle(5,243);
  maxSingle(6,195);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
}

void lookRight() {
  maxSingle(1,60);
  maxSingle(2,126);
  maxSingle(3,195);
  maxSingle(4,207);
  maxSingle(5,207);
  maxSingle(6,195);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
}

void lookUp() {
  maxSingle(1,60);
  maxSingle(2,126);
  maxSingle(3,219);
  maxSingle(4,219);
  maxSingle(5,195);
  maxSingle(6,195);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
}

void lookDown() {
  maxSingle(1,60);
  maxSingle(2,126);
  maxSingle(3,195);
  maxSingle(4,195);
  maxSingle(5,219);
  maxSingle(6,219);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
}

void lookUpLeft() {
  maxSingle(1,60);
  maxSingle(2,126);
  maxSingle(3,243);
  maxSingle(4,243);
  maxSingle(5,195);
  maxSingle(6,195);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
}

void lookDownLeft() {
  maxSingle(1,60);
  maxSingle(2,126);
  maxSingle(3,195);
  maxSingle(4,195);
  maxSingle(5,243);
  maxSingle(6,243);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
}

void lookUpRight() {
  maxSingle(1,60);
  maxSingle(2,126);
  maxSingle(3,207);
  maxSingle(4,207);
  maxSingle(5,195);
  maxSingle(6,195);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
}

void lookDownRight() {
  maxSingle(1,60);
  maxSingle(2,126);
  maxSingle(3,195);
  maxSingle(4,195);
  maxSingle(5,207);
  maxSingle(6,207);
  maxSingle(7,126);
  maxSingle(8,60);
  delay(d);
}

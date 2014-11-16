#define road 0

#define  l1 (digitalRead(34) == road)
#define  l2 (digitalRead(36) == road)
#define  l3 (digitalRead(38) == road)
#define  l4 (digitalRead(40) == road)
#define  l5 (digitalRead(42) == road)
#define  m  (digitalRead(32) == road)
#define  r1 (digitalRead(30) == road)
#define  r2 (digitalRead(28) == road)
#define  r3 (digitalRead(26) == road)
#define  r4 (digitalRead(24) == road)
#define  r5 (digitalRead(22) == road)

#define  lUp   (digitalRead(48) == road)
#define  lDown (digitalRead(50) == road)
#define  rUp   (digitalRead(46) == road)
#define  rDown (digitalRead(44) == road)

#define leftMotorForwardPin 7
#define leftMotorBackwardPin 5
#define leftMotorPWMPin 6

#define rightMotorForwardPin 10
#define rightMotorBackwardPin 8
#define rightMotorPWMPin 9

#define ledYellow 47
#define ledGreen 49
#define ledRed 51
#define ledOrange 53

int pwmError = 0;
int pwmError1 = 0;
int pwmError2 = 0;

int sensorLengthFromMiddle = 5;

int previousError = -1;

/*Motors*/
void leftMotorFoward(int pwm){
	analogWrite(leftMotorPWMPin,pwm);
	digitalWrite(leftMotorForwardPin, HIGH);
	digitalWrite(leftMotorBackwardPin, LOW);
}

void leftMotorBackward(int pwm){
	analogWrite(leftMotorPWMPin,pwm);
	digitalWrite(leftMotorForwardPin, LOW);
	digitalWrite(leftMotorBackwardPin, HIGH);
}

void rightMotorForward(int pwm){
	analogWrite(rightMotorPWMPin, pwm);
	digitalWrite(rightMotorForwardPin, HIGH);
	digitalWrite(rightMotorBackwardPin, LOW);
}

void rightMotorBackward(int pwm){
	analogWrite(rightMotorPWMPin, pwm);
	digitalWrite(rightMotorForwardPin, LOW);
	digitalWrite(rightMotorBackwardPin, HIGH);
}

void breakMotors(int time){

	digitalWrite(leftMotorForwardPin, HIGH);
	digitalWrite(leftMotorBackwardPin, HIGH);
	digitalWrite(rightMotorForwardPin, HIGH);
	digitalWrite(rightMotorBackwardPin, HIGH);
	delay(time);
}

void forward(int pwm){
	leftMotorFoward(pwm);
	rightMotorForward(pwm);
}

void backward(int pwm){
	leftMotorBackward(pwm);
	rightMotorBackward(pwm);
}

void turnLeft(int left_pwm, int right_pwm){

	if(left_pwm > right_pwm){
		int temp = left_pwm;
		left_pwm = right_pwm;
		right_pwm = temp;
	}

	leftMotorFoward(left_pwm);
	rightMotorForward(right_pwm);
}

void turnRight(int left_pwm, int right_pwm){

	if(left_pwm < right_pwm){
		int temp = left_pwm;
		left_pwm = right_pwm;
		right_pwm = temp;
	}

	leftMotorFoward(left_pwm);
	rightMotorForward(right_pwm);
}

void rotateLeft(int pwm){
	leftMotorBackward(pwm);
	rightMotorForward(pwm);
}

void rotateLeftWithOneMotor(int pwm){
	digitalWrite(leftMotorForwardPin, HIGH);
	digitalWrite(leftMotorBackwardPin, HIGH);
	rightMotorForward(pwm);
}

void rotateRightWithOneMotor(int pwm){
	digitalWrite(rightMotorForwardPin, HIGH);
	digitalWrite(rightMotorBackwardPin, HIGH);
	leftMotorFoward(pwm);
}

void rotateRight(int pwm){
	rightMotorBackward(pwm);
	leftMotorFoward(pwm);
}

/*Sensors*/
int getDigitalValue(int sensorNumber){

	if(sensorNumber == -5){
		return  l5;
	}
	if(sensorNumber == -4){
		return  l4;
	}
	if(sensorNumber == -3){
		return  l3;
	}
	if(sensorNumber == -2){
		return  l2;
	}
	if(sensorNumber == -1){
		return  l1;
	}
	if(sensorNumber == 0){
		return  0;
	}
	if(sensorNumber == 1){
		return  r1;
	}
	if(sensorNumber == 2){
		return  r2;
	}
	if(sensorNumber == 3){
		return  r3;
	}
	if(sensorNumber == 4){
		return  r4;
	}
	if(sensorNumber == 5){
		return  r5;
	}
}

bool allSensorsOut() {
	if( l4 ||  l3 ||  l2 ||  l1 ||  m ||  r1 ||  r2 ||  r3 ||  r4) {
		return false;
	}
	return true;
}

bool isJunction(){
	if(( lUp ||  lDown) && ( rUp ||  rDown)){
		return true;
	}
	return false;
}

bool isAtoBJunction(){

	if( panalAND(-1, -1, 1, 1, -1,   -1,    -1, -1, -1, 1, 1) || panalAND(-1, 1, 1, -1, -1,   -1,    -1, -1, 1, 1, -1) ||
			panalAND(1, 1, -1, -1, -1,   -1,    -1, 1, 1, -1, -1) ){
		return true;
	}
	return false;
}

bool panalAND(int v1, int v2, int v3, int v4, int v5, int v6, int v7, int v8, int v9, int v10, int v11){
	if((v1 > 0) && (v1 ^ l5)) return false;
	if((v2 > 0) && (v2 ^ l4)) return false;
	if((v3 > 0) && (v3 ^ l3)) return false;
	if((v4 > 0) && (v4 ^ l2)) return false;
	if((v5 > 0) && (v5 ^ l1)) return false;
	if((v6 > 0) && (v6 ^ m)) return false;
	if((v7 > 0) && (v7 ^ r1)) return false;
	if((v8 > 0) && (v8 ^ r2)) return false;
	if((v9 > 0) && (v9 ^ r3)) return false;
	if((v10 > 0) && (v10 ^ r4)) return false;
	if((v11 > 0) && (v11 ^ r5)) return false;
	return true;
}

bool panalOR(int v1, int v2, int v3, int v4, int v5, int v6, int v7, int v8, int v9, int v10, int v11){
	if((v1 > 0) && !(v1 ^ l5)) return true;
	if((v2 > 0) && !(v2 ^ l4)) return true;
	if((v3 > 0) && !(v3 ^ l3)) return true;
	if((v4 > 0) && !(v4 ^ l2)) return true;
	if((v5 > 0) && !(v5 ^ l1)) return true;
	if((v6 > 0) && !(v6 ^ m)) return true;
	if((v7 > 0) && !(v7 ^ r1)) return true;
	if((v8 > 0) && !(v8 ^ r2)) return true;
	if((v9 > 0) && !(v9 ^ r3)) return true;
	if((v10 > 0) && !(v10 ^ r4)) return true;
	if((v11 > 0) && !(v11 ^ r5)) return true;
	return false;
}

void printSensors(){

	Serial.print( l5);
	Serial.print(" ");
	Serial.print( l4);
	Serial.print(" ");
	Serial.print( l3);
	Serial.print(" ");
	Serial.print( l2);
	Serial.print(" ");
	Serial.print( l1);
	Serial.print(" ");
	Serial.print(m);
	Serial.print(" ");
	Serial.print( r1);
	Serial.print(" ");
	Serial.print( r2);
	Serial.print(" ");
	Serial.print( r3);
	Serial.print(" ");
	Serial.print( r4);
	Serial.print(" ");
	Serial.print( r5);
	Serial.print("  *******   ");

	Serial.print( lUp);
	Serial.print(" ");
	Serial.print( lDown);
	Serial.print(" ");
	Serial.print( rUp);
	Serial.print(" ");
	Serial.print( rDown);
	Serial.println();
}

/* line following*/

int getCurrentError(){

	int errors[]={-101, -101, -100, -50, -10, 0, 10, 50, 100, 101, 101};

	int leftError = -sensorLengthFromMiddle;
	int rightError = sensorLengthFromMiddle;

	for(int i = sensorLengthFromMiddle; i >= -sensorLengthFromMiddle; i--) {
		if(getDigitalValue(i)) {
			rightError = i;
			break;
		}
	}

	for(int i = -sensorLengthFromMiddle; i <= sensorLengthFromMiddle; i++){
		if(getDigitalValue(i)){
			leftError = i;
			break;
		}
	}

	int currentError = errors[(leftError + rightError)/2 + sensorLengthFromMiddle];

	return currentError;
}


void sectionB(){

	if(rUp || rDown){
		forward(150);
		delayMicroseconds(500000);
		yellowON(-1);
		breakMotors(2000);
	}
}


void linefollow(int pwm) {

	int multipler  = 1;
	int currentError = getCurrentError();
	int leftPWM = pwm + multipler * currentError;
	int rightPWM = pwm - multipler * currentError;
	int errorThreshold = 100;
	bool outOftheRoad = allSensorsOut();
	if(outOftheRoad) {
		if(previousError > 0) {
			rotateRight(pwm);
		}
		else {
			rotateLeft(pwm);
		}
	}
	else if(isJunction()){
		breakMotors(0);
		redON(2000);
	}
	else if(isAtoBJunction()){
		breakMotors(0);
		greenON(5000);
		
		//delayMicroseconds(1000000);
		//delay(2000);
		//turnLeft(0, 0);
	}
	else if(currentError * currentError < errorThreshold * errorThreshold) {
		leftPWM = constrain(leftPWM, 0, 255);
		rightPWM = constrain(rightPWM, 0, 255);
		leftMotorFoward(leftPWM);
		rightMotorForward(rightPWM);
	}
	else {
		if(currentError > 0) {
			rotateRight(pwm);
		}
		else {
			rotateLeft(pwm);
		}
	}
	if(( l4 ||  r4) && !( l4 &&  r4)) {
		previousError =  r4 ? 1 : -1;
	}
	Serial.println(previousError);



	/*Serial.print(leftPWM);
	Serial.print(" ####### ");
	Serial.print(rightPWM);*/
	/*Serial.print(leftError);
	Serial.print(" ####### ");
	Serial.print(rightError);
	Serial.println();*/
}

void blinkLEDs(){

	digitalWrite(ledYellow, HIGH);
	delay(1000);
	digitalWrite(ledYellow, LOW);
	digitalWrite(ledGreen, HIGH);
	delay(1000);
	digitalWrite(ledGreen, LOW);
	digitalWrite(ledRed, HIGH);
	delay(1000);
	digitalWrite(ledRed, LOW);
	digitalWrite(ledOrange, HIGH);
	delay(1000);
	digitalWrite(ledOrange, LOW);
}

void yellowON(int time){
	digitalWrite(ledYellow, HIGH);
	if(time > 0){
		delay(time);
		digitalWrite(ledYellow, LOW);
	}
}
void yellowOFF(int time){
	digitalWrite(ledYellow, LOW);
	if(time > 0){
		delay(time);
		digitalWrite(ledYellow, HIGH);
	}
}
void greenON(int time){
	digitalWrite(ledGreen, HIGH);
	if(time > 0){
		delay(time);
		digitalWrite(ledGreen, LOW);
	}
}
void greenOFF(int time){
	digitalWrite(ledGreen, LOW);
	if(time > 0){
		delay(time);
		digitalWrite(ledGreen, HIGH);
	}
}
void redON(int time){
	digitalWrite(ledRed, HIGH);
	if(time > 0){
		delay(time);
		digitalWrite(ledRed, LOW);
	}
}
void redOFF(int time){
	digitalWrite(ledRed, LOW);
	if(time > 0){
		delay(time);
		digitalWrite(ledRed, HIGH);
	}
}
void orangeON(int time){
	digitalWrite(ledOrange, HIGH);
	if(time > 0){
		delay(time);
		digitalWrite(ledOrange, LOW);
	}
}
void orangeOFF(int time){
	digitalWrite(ledOrange, LOW);
	if(time > 0){
		delay(time);
		digitalWrite(ledOrange, HIGH);
	}
}

void setup()
{
	
	pinMode(leftMotorForwardPin, OUTPUT);
	pinMode(leftMotorBackwardPin, OUTPUT);
	pinMode(leftMotorPWMPin, OUTPUT);

	pinMode(rightMotorForwardPin, OUTPUT);
	pinMode(rightMotorBackwardPin, OUTPUT);
	pinMode(rightMotorPWMPin, OUTPUT);

	 pinMode(22, INPUT);   
	 pinMode(24, INPUT);   
	 pinMode(26, INPUT);   
	 pinMode(28, INPUT);
	 pinMode(30, INPUT);   
	 pinMode(32, INPUT);   
	 pinMode(34, INPUT);   
	 pinMode(36, INPUT);	
	 pinMode(38, INPUT);
	 pinMode(40, INPUT);   
	 pinMode(42, INPUT);	

	 pinMode(44, INPUT);	
	 pinMode(46, INPUT);
	 pinMode(48, INPUT);   
	 pinMode(50, INPUT);

	 Serial.begin(9600);

	 pinMode(ledYellow, OUTPUT);
	 pinMode(ledGreen, OUTPUT);
	 pinMode(ledRed, OUTPUT);
	 pinMode(ledOrange, OUTPUT);
}

void loop()
{
	delay(500);
	while(1) {
		linefollow(150);
		sectionB();
		//leftMotorFoward(0);
		//rightMotorForward(250);
		//printSensors();

		//leftMotorFoward(100);
		//rightMotorForward(200);
			//forward(150);
	}
	//blinkLEDs();
}

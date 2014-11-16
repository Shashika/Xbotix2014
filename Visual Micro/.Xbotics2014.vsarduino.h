//Board = Arduino Mega 2560 or Mega ADK
#define ARDUINO 10
#define __AVR_ATmega2560__
#define F_CPU 16000000L
#define __AVR__
#define __cplusplus
#define __attribute__(x)
#define __inline__
#define __asm__(x)
#define __extension__
#define __ATTR_PURE__
#define __ATTR_CONST__
#define __inline__
#define __asm__ 
#define __volatile__
#define __builtin_va_list
#define __builtin_va_start
#define __builtin_va_end
#define __DOXYGEN__
#define prog_void
#define PGM_VOID_P int
#define NOINLINE __attribute__((noinline))

typedef unsigned char byte;
extern "C" void __cxa_pure_virtual() {}

void leftMotorFoward(int pwm);
void leftMotorBackward(int pwm);
void rightMotorForward(int pwm);
void rightMotorBackward(int pwm);
void breakMotors(int time);
void forward(int pwm);
void backward(int pwm);
void turnLeft(int left_pwm, int right_pwm);
void turnRight(int left_pwm, int right_pwm);
void rotateLeft(int pwm);
void rotateLeftWithOneMotor(int pwm);
void rotateRightWithOneMotor(int pwm);
void rotateRight(int pwm);
int getDigitalValue(int sensorNumber);
bool allSensorsOut();
bool isJunction();
bool isAtoBJunction();
bool panalAND(int v1, int v2, int v3, int v4, int v5, int v6, int v7, int v8, int v9, int v10, int v11);
bool panalOR(int v1, int v2, int v3, int v4, int v5, int v6, int v7, int v8, int v9, int v10, int v11);
void printSensors();
int getCurrentError();
void sectionB();
void linefollow(int pwm);
void blinkLEDs();
void yellowON(int time);
void yellowOFF(int time);
void greenON(int time);
void greenOFF(int time);
void redON(int time);
void redOFF(int time);
void orangeON(int time);
void orangeOFF(int time);
//already defined in arduno.h
//already defined in arduno.h

#include "D:\Softwares\arduino-1.0-windows\arduino-1.0-windows\arduino-1.0\hardware\arduino\variants\mega\pins_arduino.h" 
#include "D:\Softwares\arduino-1.0-windows\arduino-1.0-windows\arduino-1.0\hardware\arduino\cores\arduino\arduino.h"
#include "C:\Users\Shashika\Documents\Arduino\Xbotics2014\Xbotics2014.pde"
#include "C:\Users\Shashika\Documents\Arduino\Xbotics2014\mainCode.c"

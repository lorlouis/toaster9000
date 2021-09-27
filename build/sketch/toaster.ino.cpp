#include <Arduino.h>
#line 1 "/home/lor_louis/Documents/Projects/C++/toaster/toaster.ino"
#include <Encoder.h>

#include <math.h>

//Lib for OLED screen
#include <LiquidCrystal.h>

//BUTTON
#define BTN_PIN 3
#define TOAST_PIN 7
#define MAGNET_PIN 4

//the screen
LiquidCrystal screen = LiquidCrystal(10, 9, 18, 19, 20, 21);
Encoder myEnc(1, 2);
//flags to check against
volatile byte btn_pressed = 0;
volatile byte lever_pressed = 0;

//State of rotary encoder press button
volatile byte state = LOW;
//state of magnet
volatile byte flag = 0;
volatile byte toastMod = 0;

#line 26 "/home/lor_louis/Documents/Projects/C++/toaster/toaster.ino"
void btn_int(void);
#line 37 "/home/lor_louis/Documents/Projects/C++/toaster/toaster.ino"
void lever_int(void);
#line 48 "/home/lor_louis/Documents/Projects/C++/toaster/toaster.ino"
void setup();
#line 71 "/home/lor_louis/Documents/Projects/C++/toaster/toaster.ino"
int wheel_dir(unsigned long timeout_ms);
#line 82 "/home/lor_louis/Documents/Projects/C++/toaster/toaster.ino"
void display_menu(struct menu_item *menu_items, int nb_items);
#line 87 "/home/lor_louis/Documents/Projects/C++/toaster/toaster.ino"
void loop();
#line 26 "/home/lor_louis/Documents/Projects/C++/toaster/toaster.ino"
void btn_int(void) {
  static unsigned long last_interrupt_time = 0;
  unsigned long interrupt_time = millis();
  // If interrupts come faster than 200ms, assume it's a bounce and ignore
  if (interrupt_time - last_interrupt_time > 200) 
  {
    last_interrupt_time = interrupt_time;
    btn_pressed = 1;
  }
}

void lever_int(void) {
  static unsigned long last_interrupt_time = 0;
  unsigned long interrupt_time = millis();
  // If interrupts come faster than 200ms, assume it's a bounce and ignore
  if (interrupt_time - last_interrupt_time > 200) 
  {
    last_interrupt_time = interrupt_time;
    lever_pressed = 1;
  }
}

void setup() {
  Serial.begin(9600);
  Serial.println("Basic Encoder Test:");
  pinMode(BTN_PIN, INPUT_PULLUP);
  pinMode(TOAST_PIN, INPUT_PULLUP);
  pinMode(MAGNET_PIN, OUTPUT);
  // display stuff
  screen.begin(16,2);
  screen.setCursor(2, 0);
  screen.print("Hello, World!");
  delay(5000);
  // set the interrupts on the btn and the lever
  attachInterrupt(digitalPinToInterrupt(BTN_PIN), btn_int, FALLING);
  attachInterrupt(digitalPinToInterrupt(TOAST_PIN), lever_int, RISING);
}

struct menu_item {
  char text[14];
  void *fn(void);
};

// 0 no movement -1 back 1 front
// if timeout_ms is 0 waits indefinitely for a change in direction
int wheel_dir(unsigned long timeout_ms) {
  unsigned long begin_time = millis();
  long oldpos = myEnc.read();
  long newpos;
  do{
    newpos = myEnc.read();
    if(timeout_ms != 0 && millis() - begin_time > timeout_ms) break;
  }while(oldpos == newpos);
  return newpos-oldpos;
}

void display_menu(struct menu_item *menu_items, int nb_items) {
  char *up_arr = "/\\";
  char *down_arr = "\\/";
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println(wheel_dir(30));
}


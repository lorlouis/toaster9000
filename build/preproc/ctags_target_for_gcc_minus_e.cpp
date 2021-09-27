# 1 "/home/lor_louis/Documents/Projects/C++/toaster/toaster.ino"
# 2 "/home/lor_louis/Documents/Projects/C++/toaster/toaster.ino" 2

# 4 "/home/lor_louis/Documents/Projects/C++/toaster/toaster.ino" 2


# 5 "/home/lor_louis/Documents/Projects/C++/toaster/toaster.ino"
//Lib for OLED screen
# 7 "/home/lor_louis/Documents/Projects/C++/toaster/toaster.ino" 2

//BUTTON




//the screen
LiquidCrystal screen = LiquidCrystal(10, 9, 18, 19, 20, 21);
Encoder myEnc(1, 2);
//flags to check against
volatile byte btn_pressed = 0;
volatile byte lever_pressed = 0;

//State of rotary encoder press button
volatile byte state = 0x0;
//state of magnet
volatile byte flag = 0;
volatile byte toastMod = 0;

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
  pinMode(3, 0x2);
  pinMode(7, 0x2);
  pinMode(4, 0x1);
  // display stuff
  screen.begin(16,2);
  screen.setCursor(2, 0);
  screen.print("Hello, World!");
  delay(5000);
  // set the interrupts on the btn and the lever
  attachInterrupt(((3) == 0 ? 2 : ((3) == 1 ? 3 : ((3) == 2 ? 1 : ((3) == 3 ? 0 : ((3) == 7 ? 4 : -1))))), btn_int, 2);
  attachInterrupt(((7) == 0 ? 2 : ((7) == 1 ? 3 : ((7) == 2 ? 1 : ((7) == 3 ? 0 : ((7) == 7 ? 4 : -1))))), lever_int, 3);
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

#include <Encoder.h>
#include <EEPROM.h>

#include <string.h>
#include <math.h>

//Lib for OLED screen
#include <LiquidCrystal.h>

// debounce time in ms
#define DEBOUNCE_TIME 200

#define CUSTOM_CHAR_ARR_UP (byte)1
#define CUSTOM_CHAR_ARR_DOWN (byte)3

//BUTTON
#define BTN_PIN 3
#define TOAST_PIN 7
#define MAGNET_PIN 4

typedef void (*void_fn)(void);

struct menu_item {
    char text[15];
    void *data;
};

//the screen
LiquidCrystal screen = LiquidCrystal(10, 9, 18, 19, 20, 21);
Encoder myEnc(1, 2);

//flags to check against
#define F_BTN_PRESSED 0x01
#define F_LEVER_PRESSED 0x02
volatile byte flags = 0;

//State of rotary encoder press button
volatile byte state = LOW;

unsigned char customchars[2][8] = {
    {
        0b00000,
        0b00100,
        0b01110,
        0b11111,
        0b01110,
        0b01110,
        0b01110,
        0b00000,
    },
    {
        0b00000,
        0b01110,
        0b01110,
        0b01110,
        0b11111,
        0b01110,
        0b00100,
        0b00000,
    },
};

void set_flag(unsigned char mask) {
    static unsigned long last_interrupt_time = 0;
    unsigned long interrupt_time = millis();
    // If interrupts come faster than 200ms, assume it's a bounce and ignore
    if (interrupt_time - last_interrupt_time > DEBOUNCE_TIME) {
        last_interrupt_time = interrupt_time;
        flags |= mask;
    }
}

void btn_int(void) {
    set_flag(F_BTN_PRESSED);
}

void lever_int(void) {
    set_flag(F_LEVER_PRESSED);
}

void setup() {
    Serial.begin(9600);
    Serial.println("Basic Encoder Test:");
    pinMode(BTN_PIN, INPUT_PULLUP);
    pinMode(TOAST_PIN, INPUT_PULLUP);
    pinMode(MAGNET_PIN, OUTPUT);
    pinMode(8, OUTPUT);
    digitalWrite(8, HIGH);
    // display stuff
    screen.begin(16, 2);

    screen.createChar(CUSTOM_CHAR_ARR_UP, customchars[0]);
    screen.createChar(CUSTOM_CHAR_ARR_DOWN, customchars[1]);

    delay(50);

    screen.setCursor(0, 0);

    screen.write(CUSTOM_CHAR_ARR_UP);
    screen.write(CUSTOM_CHAR_ARR_DOWN);
    screen.print("Hello, World!");


    delay(1000);
    // set the interrupts on the btn and the lever
    attachInterrupt(digitalPinToInterrupt(BTN_PIN), btn_int, FALLING);

    attachInterrupt(digitalPinToInterrupt(TOAST_PIN), lever_int, RISING);
}

// 0 no movement -1 back 1 front
// if timeout_ms is -1 waits indefinitely for a change in direction
// if break_flag is not 0 it checks if the value it points to becomes not 0
// and if yes, breaks early
int wheel_dir(unsigned long timeout_ms, unsigned char flag_mask) {
    unsigned long begin_time = millis();
    long oldpos = myEnc.read();
    long newpos;
    do {
        // break when an interrupt is called
        if(flags & flag_mask) break;

        newpos = myEnc.read();
        if (timeout_ms != -1 && millis() - begin_time > timeout_ms)
            break;
    } while (oldpos/4 == newpos/4);
    if( newpos - oldpos < 0) return -1;
    if( newpos - oldpos > 0) return 1;
    return 0;
}

void_fn display_menu(struct menu_item *menu_items, int nb_items) {
    int index = 0;
    int last_index = 1;
    int tot_page = (nb_items / 2 + nb_items % 2)-1;
    int page = 0;
    void_fn fn = 0;

    flags &= ~F_BTN_PRESSED;

    while(1) {
        screen.clear();

        page = index / 2;

        if(page > 0) {
            screen.setCursor(0,0);
            screen.write(CUSTOM_CHAR_ARR_UP);
        }

        int nb_shown = 2;
        if(page < tot_page) {
            screen.setCursor(0,1);
            screen.write(CUSTOM_CHAR_ARR_DOWN);
        }
        else {
            nb_shown -= nb_items%2;
        }

        for(int i = 0; i < nb_shown; i++) {
            screen.setCursor(2,i);
            screen.print(menu_items[page*2+i].text);
        }

        screen.setCursor(1, (index % 2));
        screen.write('>');

        // input
        if(flags & F_BTN_PRESSED) {
            fn = (void_fn)menu_items[(page*2)+(index % 2)].data;
            flags &= ~F_BTN_PRESSED;
            break;
        }
        // change selection
        index += wheel_dir(-1, F_BTN_PRESSED);
        if(index < 0) index = 0;
        if(index >= nb_items) index = nb_items-1;
    }
    screen.clear();
    return fn;
}

void print_time(unsigned char time, unsigned char posx, unsigned char posy) {
    char buff[6] = {0};
    sprintf(buff, "%02d:%02d", time / 60, time % 60);
    screen.setCursor(posx, posy);
    screen.print(buff);
}

int get_time(unsigned char start_time) {
    int time = start_time;
    unsigned char lflags;
    while(1) {
        // the wheel dir augments when turning towards the bottom
        // inverting the direction in the time selection menu
        // makes more sense
        screen.clear();
        screen.setCursor(0,0);
        screen.print("Push whl to quit");
        print_time(time, 5, 1);
        time -= wheel_dir(-1, F_LEVER_PRESSED | F_BTN_PRESSED);
        if(flags & (F_BTN_PRESSED|F_LEVER_PRESSED)) break;

        if(time < 0) time = 0;
        else if(time > 255) time = 255;
    }
    lflags = flags;
    flags &= ~(F_BTN_PRESSED|F_LEVER_PRESSED);
    if((lflags & F_LEVER_PRESSED)) return time;
    return -1;
}

void toast(unsigned char time) {
    digitalWrite(MAGNET_PIN, HIGH);
    screen.clear();
    screen.setCursor(0,0);
    screen.print("Push whl to quit");

    int itime = time * 4;
    do{
        print_time(itime/4, 5, 1);
        if(flags & F_BTN_PRESSED) {
            flags &= ~F_BTN_PRESSED;
            break;
        }
        // its not an atomic clock
        delay(250);
    }while(itime-- != 0);
    digitalWrite(MAGNET_PIN, LOW);
    screen.clear();
    screen.setCursor(4,1);
    screen.print("finished");
}

void make_toast(void) {
    int time = get_time(90);
    if(time == -1) return;
    toast((unsigned char)time);
}

void erase_preset(int index) {
    int pos = index * 16;
    EEPROM.write(pos+15, 0);
}

void write_preset(struct menu_item *preset, int index) {
    int pos = index * 16;
    char *text = preset->text;
    /* mark the slot as "used" */
    EEPROM.write(pos+15, 1);

    EEPROM.write(pos, (unsigned char)preset->data);
    pos++;
    for(int i = 0; i < 14; i++) {
        EEPROM.write(pos+i, *(text+i));
    }
}

struct menu_item* read_preset(struct menu_item *preset, int index) {
    int pos = index * 16;
    unsigned char status;
    char *text = preset->text;
    /* check if the slot is "used" */
    EEPROM.get(pos+15, status);
    if(!(status & 1)) return 0;
    /* read data */
    EEPROM.get(pos, status);
    preset->data = (void*)status;
    pos++;
    for(int i = 0; i < 14; i++) {
        EEPROM.get(pos+i, *(text+i));
    }
    return preset;
}

void test_preset(void) {
    struct menu_item p = {
        "hello world",
        (void*)12,
    };
    write_preset(&p, 0);

    struct menu_item p2 = {0};

    for(int i = 1; i < 32; i++) {
        erase_preset(i);
    }
}

void test_read_prest(void) {
    Serial.println("hehllo");
    struct menu_item p;
    int a = 0 != read_preset(&p, 0);
    if(!a) {
        Serial.println("shdfhashf");
        return;
    }
    Serial.println((int)p.data);
    Serial.println(p.text);
}

void load_preset(void) {
    /* FIXME wasted space */
    struct menu_item menu[33] = {0};
    int nb_presets = 0;

    /* populate presets */
    for(int i = 0; i < 32; i++) {
        if(read_preset(menu+nb_presets, nb_presets)) {
            nb_presets++;
        }
    }

    strncpy(menu[nb_presets].text, "Quit", 5);
    menu[nb_presets].data = (void*)512;

    int ret = (int)display_menu(menu, nb_presets+1);

    /* check if the person quit */
    if(ret > 255) return;
    int time = get_time((unsigned char)ret);
    if(time == -1) return;
    toast((unsigned char)time);
}

void loop() {
    // put your main code here, to run repeatedly:
    struct menu_item menu1[] = {
        { "Make Toast", (void*)make_toast},
        { "Load Preset", (void*)load_preset},
        { "Create Preset", (void*)test_preset},
        { "menu2", 0},
        { "menu3", 0},
        { "menu4", 0},
        { "menu5", 0},
    };

    void_fn ret = (void_fn)display_menu(menu1, 7);
    delay(250);
    ret();
    delay(250);
}

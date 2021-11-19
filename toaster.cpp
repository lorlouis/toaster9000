#include <Arduino.h>
#include <Encoder.h>
#include <EEPROM.h>

//Lib for OLED screen
#include <LiquidCrystal.h>

#include <string.h>
#include <math.h>

// debounce time in ms
#define DEBOUNCE_TIME 250

#define INPUT_TIMEOUT 2000

#define DEFAULT_TOAST_TIME 120

#define CUSTOM_CHAR_ARR_UP (byte)1
#define CUSTOM_CHAR_ARR_DOWN (byte)3
#define CUSTOM_CHAR_END (byte)4
#define CUSTOM_CHAR_BACK (byte)5

#define SCREEN_X_SIZE 16
#define SCREEN_Y_SIZE 2


//BUTTON
#define BTN_PIN 3
#define TOAST_PIN 7
#define MAGNET_PIN 4

typedef void (*void_fn)(void);

#define MENU_ITEM_TEXT_SIZE (SCREEN_X_SIZE-1)

#define SCREEN_CENTER_STRLIT(str, y) \
    screen.setCursor((SCREEN_X_SIZE-(sizeof(str)/sizeof(char)))/2 ,y); \
    screen.print(str)

struct menu_item {
    char text[MENU_ITEM_TEXT_SIZE];
    void *data;
};

#ifndef E2END
/* last address of the eeprom */
#define E2END 511
#endif

#define NB_PRESETS_SLOTS ((E2END+1)/16)

//the screen
LiquidCrystal screen = LiquidCrystal(10, 9, 18, 19, 20, 21);
Encoder myEnc(1, 2);

//flags to check against
#define F_BTN_PRESSED 0x01
#define F_LEVER_PRESSED 0x02
volatile byte flags = 0;

#define UNSET_FLAG(flag_maks) (flags &= ~(flag_maks))


//State of rotary encoder press button
volatile byte state = LOW;

unsigned char customchars[4][8] = {
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
    {
        0b11100,
        0b10000,
        0b11000,
        0b11100,
        0b00001,
        0b00111,
        0b00101,
        0b00111,
    },
    {
        0b00000,
        0b00100,
        0b01100,
        0b11111,
        0b11111,
        0b01100,
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
    pinMode(BTN_PIN, INPUT_PULLUP);
    pinMode(TOAST_PIN, INPUT_PULLUP);
    pinMode(MAGNET_PIN, OUTPUT);
    pinMode(8, OUTPUT);
    digitalWrite(8, HIGH);
    // display stuff
    screen.begin(SCREEN_X_SIZE, SCREEN_Y_SIZE);
    screen.createChar(CUSTOM_CHAR_ARR_UP, customchars[0]);
    screen.createChar(CUSTOM_CHAR_ARR_DOWN, customchars[1]);
    screen.createChar(CUSTOM_CHAR_END, customchars[2]);
    screen.createChar(CUSTOM_CHAR_BACK, customchars[3]);

    delay(50);

    screen.setCursor(0, 0);
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
        if(flags & flag_mask) return 0;

        newpos = myEnc.read();
        if (timeout_ms != -1 && millis() - begin_time > timeout_ms)
            break;

    } while ((oldpos-newpos) == 0 || (oldpos - newpos) % 4);

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

        int nb_shown = SCREEN_Y_SIZE;
        if(page < tot_page) {
            screen.setCursor(0,1);
            screen.write(CUSTOM_CHAR_ARR_DOWN);
        }
        else {
            nb_shown -= nb_items%2;
        }

        for(int i = 0; i < nb_shown; i++) {
            screen.setCursor(SCREEN_Y_SIZE,i);
            screen.print(menu_items[page*SCREEN_Y_SIZE+i].text);
        }

        screen.setCursor(1, (index % SCREEN_Y_SIZE));
        screen.write('>');

        // input
        if(flags & F_BTN_PRESSED) {
            fn = (void_fn)menu_items[
                (page*SCREEN_Y_SIZE)+(index % SCREEN_Y_SIZE)].data;
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

/* creates an interface to input time value,
 * can be interrupted using the flag_mask */
int get_time(unsigned char start_time, unsigned char flag_mask) {
    int time = start_time;

    UNSET_FLAG(flag_mask);
    while(1) {
        // the wheel dir augments when turning towards the bottom
        // inverting the direction in the time selection menu
        // makes more sense
        screen.clear();
        screen.setCursor(0,0);
        screen.print("Push whl to Quit");
        print_time(time, (SCREEN_X_SIZE-5)/2, 1);
        time -= wheel_dir(-1, flag_mask);
        if(flags & flag_mask) break;

        if(time < 0) time = 0;
        else if(time > 255) time = 255;
    }
    return time;
}

void toast(unsigned char time) {
    int itime;
    UNSET_FLAG(F_BTN_PRESSED);

    digitalWrite(MAGNET_PIN, HIGH);
    screen.clear();
    screen.setCursor(0,0);
    screen.print("Push whl to quit");

    itime = time * 4;
    do{
        print_time(itime/4, (SCREEN_X_SIZE-5)/2, 1);
        if(flags & F_BTN_PRESSED) {
            flags &= ~F_BTN_PRESSED;
            break;
        }
        // its not an atomic clock
        delay(DEBOUNCE_TIME);
    }while(itime-- != 0);
    digitalWrite(MAGNET_PIN, LOW);
    screen.clear();
    SCREEN_CENTER_STRLIT("finished", 1);
}

void make_toast(void) {
    int time = get_time(DEFAULT_TOAST_TIME, F_BTN_PRESSED | F_LEVER_PRESSED);

    if(flags & F_LEVER_PRESSED && !(flags & F_BTN_PRESSED)) {
        UNSET_FLAG(F_BTN_PRESSED | F_LEVER_PRESSED);
        toast((unsigned char)time);
    }
    UNSET_FLAG(F_BTN_PRESSED | F_LEVER_PRESSED);
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

    /* clang, I know, stop complaining */
    EEPROM.write(pos, (unsigned char)preset->data);
    pos++;
    for(int i = 0; i < SCREEN_X_SIZE-2; i++) {
        EEPROM.write(pos+i, *(text+i));
    }
}

/* reads a preset from eprom at index
 * if there is nothing it returns 0
 * otherwise it returns preset */
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
    for(int i = 0; i < SCREEN_X_SIZE-2; i++) {
        EEPROM.get(pos+i, *(text+i));
    }
    return preset;
}

/* finds the first index in the eeprom
 * where you can write a preset
 * retuns -1 if the eeprom is full */
int find_empty_eeprom_index(void) {
    struct menu_item buff = {0};
    int i = 0;
    while(i < NB_PRESETS_SLOTS) {
        if(!read_preset(&buff, i)) return i;
        i++;
    }
    return -1;
}


/* builds a selection menu with the presets in memory,
 * retuns the index of the preset selected in the EEPROM
 * return -1 if the user chose 'Quit' */
int display_preset_selection(void) {
    struct menu_item menu[NB_PRESETS_SLOTS + 1] = {0};
    int nb_presets = 0;
    int a;

    /* populate presets */
    for(int i = 0; i < NB_PRESETS_SLOTS; i++) {
        if(read_preset(menu+nb_presets, i)) {
            menu[nb_presets].data = (void*)i;
            nb_presets++;
        }
    }

    strncpy(menu[nb_presets].text, "Quit", 5);
    menu[nb_presets].data = (void*)-1;
    a = (int)display_menu(menu, nb_presets+1);
    return a;
}

void load_preset(void) {

    struct menu_item preset = {0};
    int ret = display_preset_selection();

    if(ret == -1)
        return;

    if(!read_preset(&preset, ret)) {
        screen.clear();
        screen.setCursor(0, 0);
        screen.write("Corrupt memory");
        screen.setCursor(0, 1);
        screen.write("Please panic");
        delay(3000);
        screen.clear();
        return;
    }

    int time = get_time(
            (unsigned char)preset.data,
            F_BTN_PRESSED | F_LEVER_PRESSED);

    if(flags & F_LEVER_PRESSED && !(flags & F_BTN_PRESSED)) {
        UNSET_FLAG(F_BTN_PRESSED | F_LEVER_PRESSED);
        toast((unsigned char)time);
    }
    UNSET_FLAG(F_BTN_PRESSED | F_LEVER_PRESSED);
}

/* read up to len-1 chars into buff and
 * sets the last character to a '\0' */
/* FIXME the cursos keeps flashing when the function exits
 * with 0 chars */
size_t enter_str(char *buff, size_t len) {
    size_t index = 0;
    const unsigned char alpha_men_len = 29;
    unsigned char alpha_men[alpha_men_len];
    static_assert(
            SCREEN_X_SIZE >= 2, "The screen x must be > 2 optimally > than 6");
    /* so tha A is the first char selected */
    char offset = 29-(SCREEN_X_SIZE-3)/2;
    screen.clear();

    /* build alphabet */
    for(int i = 0; i < 26; i++) {
        alpha_men[i] = 'A'+i;
    }
    alpha_men[26] = '_';
    alpha_men[27] = CUSTOM_CHAR_BACK;
    alpha_men[28] = CUSTOM_CHAR_END;

    while(1) {
        unsigned char c;
        screen.clear();
        screen.noBlink();
        screen.setCursor(0,0);
        screen.write(buff, index);
        screen.write('_');
        screen.setCursor(0,1);
        for(int i = 0; i < SCREEN_X_SIZE-3; i++) {
            if(i == (SCREEN_X_SIZE-3)/2 || i == (SCREEN_X_SIZE-3)/2 + 1)
                screen.write(' ');
            screen.write(alpha_men[
                    (offset+i) % alpha_men_len]);
        }
        screen.setCursor(index, 0);
        screen.blink();

        offset += wheel_dir(-1, F_BTN_PRESSED);
        if(offset < 0) offset = alpha_men_len;

        /* handle keypress */
        if(flags & (F_BTN_PRESSED)) {
            flags &= ~(F_BTN_PRESSED);
            c = alpha_men[(offset+((SCREEN_X_SIZE-3)/2)) % alpha_men_len];

            /* backspace */
            if(c == CUSTOM_CHAR_BACK)
                index = index > 0 ? index-1 : 0;

            /* enter */
            else if(c == CUSTOM_CHAR_END) {
                buff[index] = '\0';
                screen.clear();
                screen.noCursor();
                screen.noBlink();
                return index;
            }
            /* regular old letters */
            else {
                buff[index] = c;
                index = index < SCREEN_X_SIZE-2 ? index+1 : SCREEN_X_SIZE - 2;
            }
        }
    }
}

struct menu_item* fill_preset(struct menu_item *preset) {
    unsigned char time;

    SCREEN_CENTER_STRLIT("Enter name", 0);
    flags &= ~(F_BTN_PRESSED | F_LEVER_PRESSED);
    wheel_dir(INPUT_TIMEOUT, (F_BTN_PRESSED | F_LEVER_PRESSED));
    flags &= ~(F_BTN_PRESSED | F_LEVER_PRESSED);

    if(!enter_str(preset->text, MENU_ITEM_TEXT_SIZE)) {
        SCREEN_CENTER_STRLIT("Invalid name", 0);
        /* wait for input or 2 sec */
        flags &= ~(F_BTN_PRESSED | F_LEVER_PRESSED);
        wheel_dir(INPUT_TIMEOUT, (F_BTN_PRESSED | F_LEVER_PRESSED));
        flags &= ~(F_BTN_PRESSED | F_LEVER_PRESSED);
        return 0;
    }

    /* get time */
    SCREEN_CENTER_STRLIT("Enter time", 0);

    UNSET_FLAG(F_BTN_PRESSED | F_LEVER_PRESSED);
    wheel_dir(INPUT_TIMEOUT, (F_BTN_PRESSED | F_LEVER_PRESSED));

    UNSET_FLAG(F_BTN_PRESSED | F_LEVER_PRESSED);
    time = get_time(DEFAULT_TOAST_TIME, F_BTN_PRESSED);
    UNSET_FLAG(F_BTN_PRESSED);

    preset->data = (void*)time;
    return preset;
}

void create_preset(void) {
    /* TODO strip the string written */
    unsigned char time = 0;
    int index = -1;
    struct menu_item preset = {0};

    if(!fill_preset(&preset)) {
        return;
    }

    index = find_empty_eeprom_index();
    if(index == -1) {
        SCREEN_CENTER_STRLIT("No space left", 0);
        UNSET_FLAG(F_BTN_PRESSED);
        wheel_dir(INPUT_TIMEOUT, F_BTN_PRESSED);
        UNSET_FLAG(F_BTN_PRESSED);
        return;
    }
    write_preset(&preset, index);
    screen.clear();
    SCREEN_CENTER_STRLIT("Saved", 0);
    UNSET_FLAG(F_BTN_PRESSED);
    wheel_dir(1750, F_BTN_PRESSED);
    UNSET_FLAG(F_BTN_PRESSED);
}

void delete_preset(void) {
    int index = -1;

    index = display_preset_selection();

    if(index == -1)
        return;

    erase_preset(index);
}

void manage_presets(void) {
    void_fn fn;
    struct menu_item menu[] = {
        { "Create Preset", (void*)create_preset},
        { "Delete Preset", (void*)delete_preset},
        { "Quit", (void*)0},
    };
    fn = (void_fn)display_menu(menu, 3);
    delay(DEBOUNCE_TIME);
    if(fn == 0)
        return;
    fn();
}

void loop() {
    // put your main code here, to run repeatedly:
    struct menu_item menu1[] = {
        { "Make Toast", (void*)make_toast},
        { "Load Preset", (void*)load_preset},
        { "Manage Presets", (void*)manage_presets},
    };

    void_fn ret = (void_fn)display_menu(menu1, 3);
    delay(DEBOUNCE_TIME);
    ret();
    delay(DEBOUNCE_TIME);
}

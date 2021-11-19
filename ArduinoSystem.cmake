# Copyright (c) 2020 Arduino CMake Toolchain

set(ARDUINO_INSTALL_PATH "/usr/share/arduino")
set(ARDUINO_PACKAGE_PATH "/home/lor_louis/.arduino15")
set(ARDUINO_SKETCHBOOK_PATH "/home/lor_louis/Arduino")

set(ARDUINO "108016")
set("ARDUINO_ARCH_AVR" TRUE)
set("ARDUINO_AVR_LEONARDO" TRUE)

set(ARDUINO_BOARD "AVR_LEONARDO")
set(ARDUINO_BOARD_IDENTIFIER "avr.leonardo")
set(ARDUINO_BOARD_NAME "Arduino Leonardo")
set(ARDUINO_BOARD_BUILD_ARCH "AVR")
set(ARDUINO_BOARD_RUNTIME_PLATFORM_PATH "/home/lor_louis/.arduino15/packages/arduino/hardware/avr/1.8.3")
set(ARDUINO_CORE_SPECIFIC_PLATFORM_PATH "")
set(ARDUINO_BOARD_BUILD_CORE_PATH "/home/lor_louis/.arduino15/packages/arduino/hardware/avr/1.8.3/cores/arduino")
set(ARDUINO_BOARD_BUILD_VARIANT_PATH "/home/lor_louis/.arduino15/packages/arduino/hardware/avr/1.8.3/variants/leonardo")
set(ARDUINO_BOARD_HOST_NAME "linux")

set(ARDUINO_BOARD_UPLOAD_TOOL avrdude)
set(ARDUINO_BOARD_PROGRAM_TOOL )
set(ARDUINO_BOARD_BOOTLOADER_TOOL avrdude)

set(ARDUINO_PROGRAMMER_ID "")
set(ARDUINO_PROGRAMMER_NAME "")

set(ARDUINO_RULE_NAMES_LIST "recipe.c.o.pattern;recipe.cpp.o.pattern;recipe.S.o.pattern;recipe.ar.pattern;recipe.c.combine.pattern;recipe.objcopy.eep.pattern;recipe.objcopy.hex.pattern;recipe.size.pattern;tools.avrdude.upload.network_pattern;tools.avrdude.upload.pattern;tools.avrdude.program.pattern;tools.avrdude.erase.pattern;tools.avrdude.bootloader.pattern;tools.avrdude_remote.upload.pattern")
set("ARDUINO_RULE_recipe.c.o.pattern" "\"/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-gcc\" -c -g -Os -w -std=gnu11 -ffunction-sections -fdata-sections -MMD -flto -fno-fat-lto-objects -mmcu=atmega32u4 -DF_CPU=16000000L -DARDUINO=108016 -DARDUINO_AVR_LEONARDO -DARDUINO_ARCH_AVR  -DUSB_VID=0x2341 -DUSB_PID=0x8036 '-DUSB_MANUFACTURER=\"Unknown\"' '-DUSB_PRODUCT=\"Arduino Leonardo\"' {includes} \"{source_file}\" -o \"{object_file}\"")
set("ARDUINO_RULE_recipe.cpp.o.pattern" "\"/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-g++\" -c -g -Os -w -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -Wno-error=narrowing -MMD -flto -mmcu=atmega32u4 -DF_CPU=16000000L -DARDUINO=108016 -DARDUINO_AVR_LEONARDO -DARDUINO_ARCH_AVR  -DUSB_VID=0x2341 -DUSB_PID=0x8036 '-DUSB_MANUFACTURER=\"Unknown\"' '-DUSB_PRODUCT=\"Arduino Leonardo\"' {includes} \"{source_file}\" -o \"{object_file}\"")
set("ARDUINO_RULE_recipe.S.o.pattern" "\"/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-gcc\" -c -g -x assembler-with-cpp -flto -MMD -mmcu=atmega32u4 -DF_CPU=16000000L -DARDUINO=108016 -DARDUINO_AVR_LEONARDO -DARDUINO_ARCH_AVR  -DUSB_VID=0x2341 -DUSB_PID=0x8036 '-DUSB_MANUFACTURER=\"Unknown\"' '-DUSB_PRODUCT=\"Arduino Leonardo\"' {includes} \"{source_file}\" -o \"{object_file}\"")
set("ARDUINO_RULE_recipe.ar.pattern" "\"/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-gcc-ar\" rcs  \"{build.path}/{archive_file}\" \"{object_file}\"")
set("ARDUINO_RULE_recipe.c.combine.pattern" "\"/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-gcc\" -w -Os -g -flto -fuse-linker-plugin -Wl,--gc-sections -mmcu=atmega32u4   -o \"{build.path}/{build.project_name}.elf\" {object_files}  \"{build.path}/{archive_file}\" \"-L{build.path}\" -lm")
set("ARDUINO_RULE_recipe.objcopy.eep.pattern" "\"/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-objcopy\" -O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0  \"{build.path}/{build.project_name}.elf\" \"{build.path}/{build.project_name}.eep\"")
set("ARDUINO_RULE_recipe.objcopy.hex.pattern" "\"/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-objcopy\" -O ihex -R .eeprom  \"{build.path}/{build.project_name}.elf\" \"{build.path}/{build.project_name}.hex\"")
set("ARDUINO_RULE_recipe.size.pattern" "\"/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-size\" -A \"{build.path}/{build.project_name}.elf\"")
set("ARDUINO_RULE_tools.avrdude.upload.network_pattern" "\"/home/lor_louis/.arduino15/packages/arduino/tools/arduinoOTA/1.3.0/bin/arduinoOTA\" -address {serial.port} -port {upload.network.port} -sketch \"{build.path}/{build.project_name}.hex\" -upload {upload.network.endpoint_upload} -sync {upload.network.endpoint_sync} -reset {upload.network.endpoint_reset} -sync_exp {upload.network.sync_return}")
set("ARDUINO_RULE_tools.avrdude.upload.pattern" "\"/home/lor_louis/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/bin/avrdude\" \"-C/home/lor_louis/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/etc/avrdude.conf\" -v  -patmega32u4 -cavr109 \"-P{serial.port}\" -b57600 -D \"-Uflash:w:{build.path}/{build.project_name}.hex:i\"")
set("ARDUINO_RULE_tools.avrdude.program.pattern" "\"/home/lor_louis/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/bin/avrdude\" \"-C/home/lor_louis/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/etc/avrdude.conf\" -v  -patmega32u4 -c{protocol} {program.extra_params} \"-Uflash:w:{build.path}/{build.project_name}.hex:i\"")
set("ARDUINO_RULE_tools.avrdude.erase.pattern" "\"/home/lor_louis/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/bin/avrdude\" \"-C/home/lor_louis/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/etc/avrdude.conf\" -v -patmega32u4 -c{protocol} {program.extra_params} -e -Ulock:w:0x3F:m -Uefuse:w:0xcb:m -Uhfuse:w:0xd8:m -Ulfuse:w:0xff:m")
set("ARDUINO_RULE_tools.avrdude.bootloader.pattern" "\"/home/lor_louis/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/bin/avrdude\" \"-C/home/lor_louis/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/etc/avrdude.conf\" -v -patmega32u4 -c{protocol} {program.extra_params} \"-Uflash:w:/home/lor_louis/.arduino15/packages/arduino/hardware/avr/1.8.3/bootloaders/caterina/Caterina-Leonardo.hex:i\" -Ulock:w:0x2F:m")
set("ARDUINO_RULE_tools.avrdude_remote.upload.pattern" "/usr/bin/run-avrdude /tmp/sketch.hex {upload.verbose} -patmega32u4")



set(CMAKE_C_COMPILER "/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-gcc")
set(CMAKE_C_COMPILE_OBJECT "<CMAKE_C_COMPILER>  -c -g -Os -w -std=gnu11 -ffunction-sections -fdata-sections -MMD -flto -fno-fat-lto-objects -mmcu=atmega32u4 -DF_CPU=16000000L -DARDUINO=108016 -DARDUINO_AVR_LEONARDO -DARDUINO_ARCH_AVR  -DUSB_VID=0x2341 -DUSB_PID=0x8036 \"-DUSB_MANUFACTURER=\\\"Unknown\\\"\" \"-DUSB_PRODUCT=\\\"Arduino Leonardo\\\"\" <DEFINES> <INCLUDES> <FLAGS> <SOURCE> -o <OBJECT>")
set(CMAKE_C_LINK_EXECUTABLE "<CMAKE_C_COMPILER>  -w -Os -g -flto -fuse-linker-plugin -Wl,--gc-sections -mmcu=atmega32u4   -o <TARGET> <OBJECTS> <LINK_LIBRARIES>   -L/home/lor_louis/Documents/Projects/C++/toaster -lm")
set(CMAKE_C_CREATE_STATIC_LIBRARY "<CMAKE_AR>  rcs  <TARGET> <LINK_FLAGS> <OBJECTS>")

set(CMAKE_CXX_COMPILER "/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-g++")
set(CMAKE_CXX_COMPILE_OBJECT "<CMAKE_CXX_COMPILER>  -c -g -Os -w -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -Wno-error=narrowing -MMD -flto -mmcu=atmega32u4 -DF_CPU=16000000L -DARDUINO=108016 -DARDUINO_AVR_LEONARDO -DARDUINO_ARCH_AVR  -DUSB_VID=0x2341 -DUSB_PID=0x8036 \"-DUSB_MANUFACTURER=\\\"Unknown\\\"\" \"-DUSB_PRODUCT=\\\"Arduino Leonardo\\\"\" <DEFINES> <INCLUDES> <FLAGS> <SOURCE> -o <OBJECT>")
set(CMAKE_CXX_LINK_EXECUTABLE "<CMAKE_CXX_COMPILER>  -w -Os -g -flto -fuse-linker-plugin -Wl,--gc-sections -mmcu=atmega32u4   -o <TARGET> <OBJECTS> <LINK_LIBRARIES>   -L/home/lor_louis/Documents/Projects/C++/toaster -lm")
set(CMAKE_CXX_CREATE_STATIC_LIBRARY "<CMAKE_AR>  rcs  <TARGET> <LINK_FLAGS> <OBJECTS>")

set(CMAKE_ASM_COMPILER "/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-gcc")
set(CMAKE_ASM_COMPILE_OBJECT "<CMAKE_ASM_COMPILER>  -c -g -x assembler-with-cpp -flto -MMD -mmcu=atmega32u4 -DF_CPU=16000000L -DARDUINO=108016 -DARDUINO_AVR_LEONARDO -DARDUINO_ARCH_AVR  -DUSB_VID=0x2341 -DUSB_PID=0x8036 \"-DUSB_MANUFACTURER=\\\"Unknown\\\"\" \"-DUSB_PRODUCT=\\\"Arduino Leonardo\\\"\" <DEFINES> <INCLUDES> <FLAGS> <SOURCE> -o <OBJECT>")

# Need to include this in cache as plain setting of this variable is
# overwritten when marking it as advanced (This is fixed only in CMake 3.13.0)
set(CMAKE_AR "/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-gcc-ar" CACHE INTERNAL "" FORCE)

set(ARDUINO_FIND_ROOT_PATH "/home/lor_louis/Arduino;/home/lor_louis/.arduino15/packages/arduino/hardware/avr/1.8.3;/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7;/home/lor_louis/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17;/home/lor_louis/.arduino15/packages/arduino/tools/arduinoOTA/1.3.0;/usr/share/arduino")
set(ARDUINO_SYSTEM_PROGRAM_PATH "/bin")


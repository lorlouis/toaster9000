# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.21

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/lor_louis/Documents/Projects/C++/toaster

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/lor_louis/Documents/Projects/C++/toaster

# Include any dependencies generated for this target.
include CMakeFiles/_arduino_lib_LiquidCrystal.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/_arduino_lib_LiquidCrystal.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/_arduino_lib_LiquidCrystal.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/_arduino_lib_LiquidCrystal.dir/flags.make

CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.o: CMakeFiles/_arduino_lib_LiquidCrystal.dir/flags.make
CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.o: /usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp
CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.o: CMakeFiles/_arduino_lib_LiquidCrystal.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/lor_louis/Documents/Projects/C++/toaster/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.o"
	/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-g++  -c -g -Os -w -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -Wno-error=narrowing -MMD -flto -mmcu=atmega32u4 -DF_CPU=16000000L -DARDUINO=108016 -DARDUINO_AVR_LEONARDO -DARDUINO_ARCH_AVR  -DUSB_VID=0x2341 -DUSB_PID=0x8036 "-DUSB_MANUFACTURER=\"Unknown\"" "-DUSB_PRODUCT=\"Arduino Leonardo\"" $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.o -MF CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.o.d /usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp -o CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.o

CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.i"
	/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp > CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.i

CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.s"
	/home/lor_louis/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp -o CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.s

# Object files for target _arduino_lib_LiquidCrystal
_arduino_lib_LiquidCrystal_OBJECTS = \
"CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.o"

# External object files for target _arduino_lib_LiquidCrystal
_arduino_lib_LiquidCrystal_EXTERNAL_OBJECTS =

lib_arduino_lib_LiquidCrystal.a: CMakeFiles/_arduino_lib_LiquidCrystal.dir/usr/share/arduino/libraries/LiquidCrystal/src/LiquidCrystal.cpp.o
lib_arduino_lib_LiquidCrystal.a: CMakeFiles/_arduino_lib_LiquidCrystal.dir/build.make
lib_arduino_lib_LiquidCrystal.a: CMakeFiles/_arduino_lib_LiquidCrystal.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/lor_louis/Documents/Projects/C++/toaster/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library lib_arduino_lib_LiquidCrystal.a"
	$(CMAKE_COMMAND) -P CMakeFiles/_arduino_lib_LiquidCrystal.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/_arduino_lib_LiquidCrystal.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/_arduino_lib_LiquidCrystal.dir/build: lib_arduino_lib_LiquidCrystal.a
.PHONY : CMakeFiles/_arduino_lib_LiquidCrystal.dir/build

CMakeFiles/_arduino_lib_LiquidCrystal.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/_arduino_lib_LiquidCrystal.dir/cmake_clean.cmake
.PHONY : CMakeFiles/_arduino_lib_LiquidCrystal.dir/clean

CMakeFiles/_arduino_lib_LiquidCrystal.dir/depend:
	cd /home/lor_louis/Documents/Projects/C++/toaster && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/lor_louis/Documents/Projects/C++/toaster /home/lor_louis/Documents/Projects/C++/toaster /home/lor_louis/Documents/Projects/C++/toaster /home/lor_louis/Documents/Projects/C++/toaster /home/lor_louis/Documents/Projects/C++/toaster/CMakeFiles/_arduino_lib_LiquidCrystal.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/_arduino_lib_LiquidCrystal.dir/depend


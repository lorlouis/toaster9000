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

# Utility rule file for upload-toaster.

# Include any custom commands dependencies for this target.
include CMakeFiles/upload-toaster.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/upload-toaster.dir/progress.make

CMakeFiles/upload-toaster:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/lor_louis/Documents/Projects/C++/toaster/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Uploading 'toaster'"
	/usr/bin/cmake ARGS -DTARGET=toaster -DMAKE_PROGRAM=/usr/bin/make -DCMAKE_VERBOSE_MAKEFILE=FALSE "-DUPLOAD_SERIAL_PATTERN=/home/lor_louis/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/bin/avrdude;-C/home/lor_louis/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/etc/avrdude.conf;-v;-patmega32u4;-cavr109;-P{serial.port};-b57600;-D;-Uflash:w:/home/lor_louis/Documents/Projects/C++/toaster/toaster.hex:i" "-DUPLOAD_NETWORK_PATTERN=/home/lor_louis/.arduino15/packages/arduino/tools/arduinoOTA/1.3.0/bin/arduinoOTA;-address;{serial.port};-port;{upload.network.port};-sketch;/home/lor_louis/Documents/Projects/C++/toaster/toaster.hex;-upload;{upload.network.endpoint_upload};-sync;{upload.network.endpoint_sync};-reset;{upload.network.endpoint_reset};-sync_exp;{upload.network.sync_return}" -P /home/lor_louis/Documents/Projects/C++/toaster/FirmwareUpload.cmake

upload-toaster: CMakeFiles/upload-toaster
upload-toaster: CMakeFiles/upload-toaster.dir/build.make
.PHONY : upload-toaster

# Rule to build all files generated by this target.
CMakeFiles/upload-toaster.dir/build: upload-toaster
.PHONY : CMakeFiles/upload-toaster.dir/build

CMakeFiles/upload-toaster.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/upload-toaster.dir/cmake_clean.cmake
.PHONY : CMakeFiles/upload-toaster.dir/clean

CMakeFiles/upload-toaster.dir/depend:
	cd /home/lor_louis/Documents/Projects/C++/toaster && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/lor_louis/Documents/Projects/C++/toaster /home/lor_louis/Documents/Projects/C++/toaster /home/lor_louis/Documents/Projects/C++/toaster /home/lor_louis/Documents/Projects/C++/toaster /home/lor_louis/Documents/Projects/C++/toaster/CMakeFiles/upload-toaster.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/upload-toaster.dir/depend


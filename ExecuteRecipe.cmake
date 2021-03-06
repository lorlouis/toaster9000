# Copyright (c) 2020 Arduino CMake Toolchain

set(ARDUINO_TOOLCHAIN_DIR "/home/lor_louis/Documents/Projects/C++/Arduino-CMake-Toolchain")
include("${ARDUINO_TOOLCHAIN_DIR}/Arduino/Utilities/PropertiesReader.cmake")

function(_get_usage_str req_var_list opt_var_list ret_usage_str)
	set(_ret_usage_str)
	foreach(var_name IN LISTS req_var_list)
		string(MAKE_C_IDENTIFIER "${var_name}" var_id)
		string(TOUPPER "${var_id}" var_id)
		set(_ret_usage_str "${_ret_usage_str} ${var_id}=<${var_name}>")
	endforeach()
	foreach(var_name IN LISTS opt_var_list)
		string(MAKE_C_IDENTIFIER "${var_name}" var_id)
		string(TOUPPER "${var_id}" var_id)
		set(_ret_usage_str "${_ret_usage_str} [${var_id}=<${var_name}>]")
	endforeach()
	set("${ret_usage_str}" "${_ret_usage_str}" PARENT_SCOPE)
endfunction()

if (CONFIRM_RECIPE_PATTERN)
	set(RECIPE_PATTERN "${CONFIRM_RECIPE_PATTERN}")
endif()

properties_resolve_value_env("${RECIPE_PATTERN}" RECIPE_PATTERN
	_req_var_list _opt_var_list _all_resolved)
_get_usage_str("${_req_var_list}" "${_opt_var_list}" _usage_str)

if (CONFIRM_RECIPE_PATTERN)
	set(_usage_str "${_usage_str} CONFIRM=1")
	if (NOT "$ENV{CONFIRM}")
		set(_all_resolved 0)
	endif()
endif()

set(cmd_pattern "${RECIPE_PATTERN}")

if (CMAKE_VERBOSE_MAKEFILE OR DEFINED ENV{VERBOSE})
	string(REPLACE ";" " " printable_cmd_line "${cmd_pattern}")
	message("${printable_cmd_line}")
endif()

if (NOT _all_resolved)
	if (NOT MAKE_PROGRAM)
		set(MAKE_PROGRAM "<make>")
	endif()
	get_filename_component(_make_ "${MAKE_PROGRAM}" NAME_WE)

	message(FATAL_ERROR
		"\nExpected environment variable(s) not provided. Usage as follows:\n"
		"Usage: '${_make_}${_usage_str} ${OPERATION}'")
endif()

execute_process(COMMAND ${cmd_pattern} RESULT_VARIABLE result)
if (NOT "${result}" EQUAL 0)
	message(FATAL_ERROR "${OPERATION} failed!!!")
endif()

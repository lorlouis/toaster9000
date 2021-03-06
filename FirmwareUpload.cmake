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

if(UPLOAD_SERIAL_PATTERN)

	properties_resolve_value_env("${UPLOAD_SERIAL_PATTERN}"
		UPLOAD_SERIAL_PATTERN _req_var_list _opt_var_list
		_all_serial_resolved)
	list(REMOVE_ITEM _req_var_list "serial.port")
	list(REMOVE_ITEM _opt_var_list "serial.port")
	_get_usage_str("${_req_var_list}" "${_opt_var_list}"
		_serial_usage_str)
	set(_serial_usage_str " SERIAL_PORT=<port>${_serial_usage_str}")

endif()

if(UPLOAD_NETWORK_PATTERN)
	# NETWORK_PORT defines both IP and port. Split it
	if(DEFINED ENV{NETWORK_PORT})
		string(REPLACE ":" ";" network_addr "$ENV{NETWORK_PORT}")
		list(LENGTH network_addr len)
		list(GET network_addr 0 network_ip)
		set(ENV{SERIAL_PORT} "${network_ip}")
		if("${len}" GREATER 1)
			list(GET network_addr 1 network_port)
		else()
			set(network_port 0)
		endif()
		set(ENV{NETWORK_PORT} "${network_port}")
	endif()

	properties_resolve_value_env("${UPLOAD_NETWORK_PATTERN}"
		UPLOAD_NETWORK_PATTERN _req_var_list _opt_var_list
		_all_network_resolved)
	list(REMOVE_ITEM _req_var_list "serial.port" "network.port")
	list(REMOVE_ITEM _opt_var_list "serial.port" "network.port")
	_get_usage_str("${_req_var_list}" "${_opt_var_list}"
		_network_usage_str)
	set(_network_usage_str " NETWORK_PORT=<ip[:port]>${_network_usage_str}")

endif()

set(OPERATION "upload-${TARGET}")

if (_all_network_resolved)
	set(cmd_pattern "${UPLOAD_NETWORK_PATTERN}")
elseif(_all_serial_resolved)
	set(cmd_pattern "${UPLOAD_SERIAL_PATTERN}")
endif()

if (CMAKE_VERBOSE_MAKEFILE OR DEFINED ENV{VERBOSE})
	string(REPLACE ";" " " printable_cmd_line "${cmd_pattern}")
	message("${printable_cmd_line}")
endif()

if (NOT _all_serial_resolved AND NOT _all_network_resolved)
	if (NOT MAKE_PROGRAM)
		set(MAKE_PROGRAM "<make>")
	endif()
	get_filename_component(_make_ "${MAKE_PROGRAM}" NAME_WE)

	message(FATAL_ERROR
		"\nExpected environment variable(s) not provided. Usage as follows:\n"
		"Serial Upload: '${_make_}${_serial_usage_str} ${OPERATION}'\n"
		"Network Upload: '${_make_}${_network_usage_str} ${OPERATION}'")
endif()

execute_process(COMMAND ${cmd_pattern} RESULT_VARIABLE result)
if (NOT "${result}" EQUAL 0)
	message(FATAL_ERROR "upload-${OPERATION} failed!!!")
endif()

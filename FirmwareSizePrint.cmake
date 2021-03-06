# Copyright (c) 2020 Arduino CMake Toolchain

message("################## Size Summary ##################")
# separate_arguments(cmd_pattern UNIX_COMMAND "${RECIPE_SIZE_PATTERN}")
set(cmd_pattern "${RECIPE_SIZE_PATTERN}")
execute_process(COMMAND ${cmd_pattern} RESULT_VARIABLE result OUTPUT_VARIABLE SizeRecipeOutput)
string(REPLACE "\n" ";" SizeRecipeOutput "${SizeRecipeOutput}")

set (size_regex_list "^(\\.text|\\.data|\\.bootloader)[ 	]+([0-9]+).*;^(\\.data|\\.bss|\\.noinit)[ 	]+([0-9]+).*;^(\\.eeprom)[ 	]+([0-9]+).*")
set (size_name_list "program;data;eeprom")
set (maximum_size_list "28672;2560;0")
set (size_match_idx_list "2;2;2")

# For each of the elements whose size is to be printed
math(EXPR _last_index "3 - 1")
foreach(idx RANGE "${_last_index}")

	list(GET size_regex_list ${idx} size_regex)
	list(GET size_name_list ${idx} size_name)
	list(GET maximum_size_list ${idx} maximum_size)
	list(GET size_match_idx_list ${idx} size_match_idx)

	# Grep for the size in the output and add them all together
	set(tot_size 0)
	foreach(line IN LISTS SizeRecipeOutput)
    	string(REGEX MATCH "${size_regex}" match "${line}")
	    if (match)
    	    math(EXPR tot_size "${tot_size} + ${CMAKE_MATCH_${size_match_idx}}")
    	endif()
	endforeach()


	# Capitalize first letter of element name
	string(SUBSTRING "${size_name}" 0 1 first_letter)
	string(SUBSTRING "${size_name}" 1 -1 rem_letters)
	string(TOUPPER "${first_letter}" first_letter)
	set(size_name "${first_letter}${rem_letters}")

	# Print total size of the element
	if (maximum_size GREATER 0)
		math(EXPR tot_size_percent "${tot_size} * 100 / ${maximum_size}")
		message("${size_name} Size: ${tot_size} of ${maximum_size} bytes (${tot_size_percent}%)")
	else()
		message("${size_name} Size: ${tot_size} bytes")
	endif()

endforeach()

message("##################################################")

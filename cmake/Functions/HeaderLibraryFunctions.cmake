#
#
#
function(internal_header_library)
	check_internal_use()

	# Parse arguments
	set(OPTIONS "DEBUG" "HELP")
	set(VALUES "NAME" "LIBRARY_ALIAS_NAME" "HEADER_LIST_FILE" "INSTALL_PATH")
	set(LISTS "DEPENDENCY_TARGET_LIST" "HEADER_LIST" "INCLUDE_PATHS")
	cmake_parse_arguments("HEADER" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	internal_header_library_start_function()

	internal_header_library_print_parse_result()
	internal_header_library_process_parameters()
	internal_header_library_add()

	internal_header_library_end_function()
endfunction(internal_header_library)

#
#
#
macro(internal_header_library_start_function)
	start_debug_function(internal_header_library)
endmacro(internal_header_library_start_function)

#
#
#
macro(internal_header_library_end_function)
	end_debug_function()
endmacro(internal_header_library_end_function)

#
#
#
macro(internal_header_library_print_parse_result)
	if(HEADER_DEBUG)
		print_debug_function_newline("-------- PARSE RESULT --------")

		print_debug_function_oneline("HEADER_HELP                   = ")
		print_debug_value_newline(${HEADER_HELP})

		print_debug_function_oneline("HEADER_NAME                   = ")
		print_debug_value_newline(${HEADER_NAME})

		print_debug_function_oneline("HEADER_HEADER_LIST_FILE       = ")
		print_debug_value_newline("${HEADER_HEADER_LIST_FILE}")

		print_debug_function_oneline("HEADER_HEADER_LIST            = ")
		print_debug_value_newline(${HEADER_HEADER_LIST})

		print_debug_function_oneline("HEADER_LIBRARY_ALIAS_NAME     = ")
		print_debug_value_newline(${HEADER_LIBRARY_ALIAS_NAME})

		print_debug_function_oneline("HEADER_DEPENDENCY_TARGET_LIST = ")
		print_debug_value_newline(${HEADER_DEPENDENCY_TARGET_LIST})

		print_debug_function_oneline("HEADER_INCLUDE_PATHS          = ")
		print_debug_value_newline(${HEADER_INCLUDE_PATHS})

		print_debug_function_oneline("HEADER_INSTALL_PATH           = ")
		print_debug_value_newline(${HEADER_INSTALL_PATH})

		print_debug_function_newline("-------- PARSE RESULT --------")
	endif()
endmacro(internal_header_library_print_parse_result)

#
#
#
macro(internal_header_library_process_parameters)
	check_internal_use()

	if(NOT HEADER_NAME)
		message_fatal("-- Need 'NAME'.")
	endif()
	if(HEADER_HEADER_LIST_FILE)
		if(EXISTS "${HEADER_HEADER_LIST_FILE}")
			include(${HEADER_HEADER_LIST_FILE})
		else()
			message_fatal("-- "
				"Need header list file with defined 'HEADER_LIST' variable.")
		endif()
	elseif(HEADER_HEADER_LIST)
		set(HEADER_LIST "${HEADER_HEADER_LIST}")
	else()
		message_fatal("-- "
			"Need 'HEADER_LIST_FILE' or 'HEADER_LIST'.")
	endif()

	internal_print_warning_not_support("${HEADER_HELP}" HELP)
	internal_print_warning_not_support("${HEADER_INSTALL_PATH}" INSTALL_PATH)
endmacro(internal_header_library_process_parameters)

macro(internal_header_library_add)
	print_newline("-- Adding header library for ${HEADER_NAME}")

	string(CONCAT TARGET_NAME
		"${HEADER_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_HEADER_MODULE_SUFFIX}")
	string(CONCAT TARGET_CUSTOM_PROPERTIES
		"${TARGET_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_CUSTOM_TARGET_SUFFIX}")

	#set(DEBUG TRUE)
	internal_add_header_target_properties(
		#DEBUG
		PROPERTY_CONTAINER_NAME "${TARGET_CUSTOM_PROPERTIES}"
		REAL_TARGET             "${TARGET_NAME}"
		ADDING_FILES            "${HEADER_LIST}"
		DEPENDENCY_HEADERS      "${HEADER_DEPENDENCY_TARGET_LIST}"
		LIBRARY_ALIASES         "${HEADER_LIBRARY_ALIAS_NAME}"
	)

	unset(TARGET_CUSTOM_PROPERTIES)
	unset(TARGET_NAME)

	print_newline("-- Adding header library for ${HEADER_NAME} - done")
endmacro(internal_header_library_add)

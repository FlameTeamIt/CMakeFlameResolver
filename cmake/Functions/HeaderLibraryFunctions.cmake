#
#
#
function(internal_header_library)
	check_internal_use()

	# Parse arguments
	set(OPTIONS "DEBUG")
	set(VALUES "NAME" "LIBRARY_ALIAS_NAME" "INSTALL_PATH" "INSTALL_DIR")
	set(LISTS "DEPENDENCY_TARGET_LIST" "HEADER_LIST" "INCLUDE_PATHS")
	cmake_parse_arguments("HEADER" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	internal_header_library_start_function()

	internal_header_library_print_parse_result()
	internal_header_library_process_parameters()
	internal_header_library_add()

	internal_header_library_end_function()
endfunction(internal_header_library)

# macros

macro(internal_header_library_start_function)
	start_debug_function(internal_header_library)
endmacro(internal_header_library_start_function)

macro(internal_header_library_end_function)
	end_debug_function()
endmacro(internal_header_library_end_function)

macro(internal_header_library_print_parse_result)
	if(HEADER_DEBUG OR (FLAME_CMAKE_DEBUG AND FLAME_CMAKE_DEBUG_SHOW_PARSE_RESULTS))
		print_debug_function_newline("-------- PARSE RESULT --------")

		print_debug_function_oneline("HEADER_NAME                   = ")
		print_debug_value_newline(${HEADER_NAME})

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

		print_debug_function_oneline("HEADER_INSTALL_DIR            = ")
		print_debug_value_newline(${HEADER_INSTALL_DIR})

		print_debug_function_newline("-------- PARSE RESULT --------")
	endif()
	if (HEADER_DEBUG)
		set(HEADER_DEBUG DEBUG)
	else()
		set(HEADER_DEBUG NO_DEBUG)
	endif()
endmacro(internal_header_library_print_parse_result)

macro(internal_header_library_process_parameters)
	check_internal_use()

	if(NOT HEADER_NAME)
		message_fatal("Need 'NAME'.")
	endif()
	if(HEADER_HEADER_LIST)
		set(HEADER_LIST "${HEADER_HEADER_LIST}")
	else()
		message_fatal("Need 'HEADER_LIST'.")
	endif()

	if(FLAME_ENABLE_INSTALL)
		if(FLAME_LOCAL_INSTALL)
			set(HEADER_INSTALL_PREFIX
				${FLAME_LOCAL_INSTALL_PREFIX}/${FLAME_PLATFORM_INSTALL_HEADER_DIR})
			set(HEADER_INSTALL_PATH ${HEADER_INSTALL_PREFIX}/${HEADER_INSTALL_DIR})
		elseif(NOT HEADER_INSTALL_PATH)
			set(HEADER_INSTALL_PREFIX
				${CMAKE_INSTALL_PREFIX}/${FLAME_PLATFORM_INSTALL_HEADER_DIR})
			set(HEADER_INSTALL_PATH ${HEADER_INSTALL_PREFIX}/${HEADER_INSTALL_DIR})
		endif()
	endif()

	internal_print_warning_not_support("${HEADER_HELP}" HELP)
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

	internal_add_header_target_properties(
		PROPERTY_CONTAINER_NAME "${TARGET_CUSTOM_PROPERTIES}"
		REAL_TARGET             "${TARGET_NAME}"
		ADDING_FILES            "${HEADER_LIST}"
		DEPENDENCY_HEADERS      "${HEADER_DEPENDENCY_TARGET_LIST}"
		LIBRARY_ALIASES         "${HEADER_LIBRARY_ALIAS_NAME}"
		INSTALL_PATH            "${HEADER_INSTALL_PATH}"
		${HEADER_DEBUG}
	)

	unset(TARGET_CUSTOM_PROPERTIES)
	unset(TARGET_NAME)

	print_newline("-- Adding header library for ${HEADER_NAME} - done")
endmacro(internal_header_library_add)

#
#
#
function(internal_compile_binary)
	check_internal_use()

	set(OPTIONS "DEBUG")
	set(VALUES "NAME" "ALIAS_NAME" "INSTALL_PATH")
	set(LISTS "INCLUDE_PATHS" "SOURCE_LIST" "COMPILE_FLAGS" "LINK_FLAGS"
		"DEPENDENCY_TARGET_LIST")
	cmake_parse_arguments("BINARY" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	internal_compile_binary_start_function()

	internal_compile_binary_print_parse_result()
	internal_compile_binary_process_parameters()
	internal_compile_binary_add()

	internal_compile_binary_end_function()
endfunction(internal_compile_binary)

# macros

macro(internal_compile_binary_start_function)
	start_debug_function(internal_compile_binary)
endmacro(internal_compile_binary_start_function)

macro(internal_compile_binary_end_function)
	end_debug_function()
endmacro(internal_compile_binary_end_function)

macro(internal_compile_binary_print_parse_result)
	if(BINARY_DEBUG OR (FLAME_CMAKE_DEBUG AND FLAME_CMAKE_DEBUG_SHOW_PARSE_RESULTS))
		print_debug_function_newline("-------- PARSE RESULT -------")

		print_debug_function_oneline("BINARY_NAME                   = ")
		print_debug_value_newline(${BINARY_NAME})

		print_debug_function_oneline("BINARY_ALIAS_NAME             = ")
		print_debug_value_newline(${BINARY_ALIAS_NAME})

		print_debug_function_oneline("BINARY_INSTALL_PATH           = ")
		print_debug_value_newline(${BINARY_INSTALL_PATH})

		print_debug_function_oneline("BINARY_INCLUDE_PATHS          = ")
		print_debug_value_newline(${BINARY_INCLUDE_PATHS})

		print_debug_function_oneline("BINARY_SOURCE_LIST            = ")
		print_debug_value_newline(${BINARY_SOURCE_LIST})

		print_debug_function_oneline("BINARY_COMPILE_FLAGS          = ")
		print_debug_value_newline(${BINARY_COMPILE_FLAGS})

		print_debug_function_oneline("BINARY_LINK_FLAGS             = ")
		print_debug_value_newline(${BINARY_LINK_FLAGS})

		print_debug_function_oneline("BINARY_DEPENDENCY_TARGET_LIST = ")
		print_debug_value_newline(${BINARY_DEPENDENCY_TARGET_LIST})

		print_debug_function_newline("-------- PARSE RESULT -------")
	endif()
	if (BINARY_DEBUG)
		set(BINARY_DEBUG DEBUG)
	endif()
endmacro(internal_compile_binary_print_parse_result)

macro(internal_compile_binary_process_parameters)
	if(NOT BINARY_NAME)
		message_fatal("Need 'NAME'.")
	endif()
	if(BINARY_SOURCE_LIST)
		list(APPEND SOURCE_LIST ${BINARY_SOURCE_LIST})
	endif()
	if(NOT BINARY_SOURCE_LIST)
		message_fatal("Need 'SOURCE_LIST'.")
	endif()

	internal_print_warning_not_support("${BINARY_COMPILE_FLAGS}" COMPILE_FLAGS)
	internal_print_warning_not_support("${BINARY_LINK_FLAGS}"    LINK_FLAGS)
	internal_print_warning_not_support("${BINARY_INSTALL_PATH}"  INSTALL_PATH)
endmacro(internal_compile_binary_process_parameters)

macro(internal_compile_binary_add)
	print_newline("-- Adding binary for ${BINARY_NAME}")

	string(CONCAT TARGET_NAME
		"${BINARY_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_BINARY_MODULE_SUFFIX}")
	string(CONCAT TARGET_CUSTOM_PROPERTIES
		"${TARGET_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_CUSTOM_TARGET_SUFFIX}")

	internal_add_binary_target_properties(
		PROPERTY_CONTAINER_NAME "${TARGET_CUSTOM_PROPERTIES}"
		REAL_TARGET             "${TARGET_NAME}"
		OUTPUT_NAME             "${BINARY_NAME}"
		#INSTALL_PATH            "${BINARY_INSTALL_PATH}"

		ADDING_FILES            "${SOURCE_LIST}"
		#COMPILE_FLAGS           "${BINARY_COMPILE_FLAGS}"
		DEPENDENCY_LIBRARIES    "${BINARY_DEPENDENCY_TARGET_LIST}"
		#LINK_FLAGS              "${BINARY_LINK_FLAGS}"
		INCLUDE_PATHS           "${BINARY_INCLUDE_PATHS}"
		${BINARY_DEBUG}
	)

	unset(TARGET_CUSTOM_PROPERTIES)
	unset(TARGET_NAME)

	print_newline("-- Adding binary for ${BINARY_NAME} - done")
endmacro(internal_compile_binary_add)

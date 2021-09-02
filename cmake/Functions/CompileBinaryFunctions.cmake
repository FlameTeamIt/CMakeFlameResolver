#
#
#
function(internal_compile_binary)
	check_internal_use()

	set(OPTIONS "DEBUG" "TEST" "RTTI" "NO_RTTI" "EXCEPTIONS" "NO_EXCEPTIONS"
		"USE_RESOLVER_DEFINES")
	set(VALUES "NAME" "ALIAS_NAME" "INSTALL_PATH" "INSTALL_DIR")
	set(LISTS "DEFINES" "INCLUDE_PATHS" "SOURCE_LIST" "COMPILE_FLAGS" "LINK_FLAGS"
		"DEPENDENCY_TARGET_LIST" "TEST_ARGUMENTS")
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

		print_debug_function_oneline("BINARY_TEST                   = ")
		print_debug_value_newline(${BINARY_TEST})

		print_debug_function_oneline("BINARY_TEST_ARGUMENTS         = ")
		print_debug_value_newline(${BINARY_TEST_ARGUMENTS})

		print_debug_function_oneline("BINARY_NO_RTTI                = ")
		print_debug_value_newline("${BINARY_NO_RTTI}")

		print_debug_function_oneline("BINARY_RTTI                   = ")
		print_debug_value_newline("${BINARY_RTTI}")

		print_debug_function_oneline("BINARY_NO_EXCEPTIONS          = ")
		print_debug_value_newline("${BINARY_NO_EXCEPTIONS}")

		print_debug_function_oneline("BINARY_EXCEPTIONS             = ")
		print_debug_value_newline("${BINARY_EXCEPTIONS}")

		print_debug_function_oneline("BINARY_ALIAS_NAME             = ")
		print_debug_value_newline(${BINARY_ALIAS_NAME})

		print_debug_function_oneline("BINARY_INSTALL_PATH           = ")
		print_debug_value_newline(${BINARY_INSTALL_PATH})

		print_debug_function_oneline("BINARY_INSTALL_DIR            = ")
		print_debug_value_newline(${BINARY_INSTALL_DIR})

		print_debug_function_oneline("BINARY_USE_RESOLVER_DEFINES   = ")
		print_debug_value_newline(${BINARY_USE_RESOLVER_DEFINES})

		print_debug_function_oneline("BINARY_DEFINES                = ")
		print_debug_value_newline(${BINARY_DEFINES})

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
	else()
		set(BINARY_DEBUG NO_DEBUG)
	endif()
endmacro(internal_compile_binary_print_parse_result)

macro(internal_compile_binary_process_parameters)
	internal_print_warning_not_support("${BINARY_LINK_FLAGS}"    LINK_FLAGS)
#	internal_print_warning_not_support("${BINARY_INSTALL_PATH}"  INSTALL_PATH)

	# BINARY_NAME

	if(NOT BINARY_NAME)
		message_fatal("Need 'NAME'.")
	endif()

	# BINARY_SOURCE_LIST

	if(BINARY_SOURCE_LIST)
		list(APPEND SOURCE_LIST ${BINARY_SOURCE_LIST})
	endif()
	if(NOT BINARY_SOURCE_LIST)
		message_fatal("Need 'SOURCE_LIST'.")
	endif()

	# BINARY_RTTI & BINARY_NO_RTTI

	if(BINARY_RTTI AND BINARY_NO_RTTI)
		set(MESSAGE_STRING "options 'RTTI' and 'NO_RTTI' cannot be used simultaneously")
		message_fatal("${FUNCTION_NAME}.${BINARY_NAME}: ${MESSAGE_STRING}")
	endif()

	if((NOT BINARY_RTTI) AND (NOT BINARY_NO_RTTI))
		if(FLAME_CXX_NO_RTTI)
			set(MESSAGE_OPTION "NO_RTTI")
			set(BINARY_RTTI OFF)
			list(APPEND BINARY_COMPILE_FLAGS "${FLAME_CXX_FLAG_NO_RTTI}")
		else()
			set(MESSAGE_OPTION "RTTI")
			set(BINARY_RTTI ON)
			list(APPEND BINARY_COMPILE_FLAGS "${FLAME_CXX_FLAG_RTTI}")
		endif()
		set(MESSAGE_STRING "not set 'RTTI' or 'NO_RTTI'. Used '${MESSAGE_OPTION}'")
		message_status("${FUNCTION_NAME}.${BINARY_NAME}: ${MESSAGE_STRING}")
		unset(MESSAGE_STRING)
		unset(MESSAGE_OPTION)
	elseif(BINARY_RTTI)
		list(APPEND BINARY_COMPILE_FLAGS "${FLAME_CXX_FLAG_RTTI}")
	elseif(BINARY_NO_RTTI)
		list(APPEND BINARY_COMPILE_FLAGS "${FLAME_CXX_FLAG_NO_RTTI}")
	endif()

	# BINARY_EXCEPTIONS & BINARY_NO_EXCEPTIONS

	if(BINARY_EXCEPTIONS AND BINARY_NO_EXCEPTIONS)
		set(MESSAGE_STRING "options 'EXCEPTIONS' and 'NO_EXCEPTIONS' cannot be used simultaneously")
		message_fatal("${FUNCTION_NAME}.${BINARY_NAME}: ${MESSAGE_STRING}")
	endif()

	if((NOT BINARY_EXCEPTIONS) AND (NOT BINARY_NO_EXCEPTIONS))
		if(FLAME_CXX_NO_EXCEPTIONS)
			set(MESSAGE_OPTION "NO_EXCEPTIONS")
			set(BINARY_EXCEPTIONS OFF)
			list(APPEND BINARY_COMPILE_FLAGS "${FLAME_CXX_FLAG_NO_EXCEPTIONS}")
		else()
			set(MESSAGE_OPTION "EXCEPTIONS")
			set(BINARY_EXCEPTIONS ON)
			list(APPEND BINARY_COMPILE_FLAGS "${FLAME_CXX_FLAG_EXCEPTIONS}")
		endif()

		set(MESSAGE_STRING "not set 'EXCEPTIONS' or 'NO_EXCEPTIONS'. Used '${MESSAGE_OPTION}'")
		message_status("${FUNCTION_NAME}.${BINARY_NAME}: ${MESSAGE_STRING}")

		unset(MESSAGE_STRING)
		unset(MESSAGE_OPTION)
	elseif(BINARY_EXCEPTIONS)
		list(APPEND BINARY_COMPILE_FLAGS "${FLAME_CXX_FLAG_EXCEPTIONS}")
	elseif(BINARY_NO_EXCEPTIONS)
		list(APPEND BINARY_COMPILE_FLAGS "${FLAME_CXX_FLAG_NO_EXCEPTIONS}")
	endif()

	if(BINARY_USE_RESOLVER_DEFINES OR FLAME_PLATFORM_DEFINES)
		flame_get_platform_defines(PLATFORM_DEFINES)
		list(APPEND BINARY_DEFINES ${PLATFORM_DEFINES})

		if(CMAKE_CXX_COMPILER)
			flame_get_rtti_defines(${BINARY_RTTI} DEFINE_RTTI)
			flame_get_exception_defines(${BINARY_EXCEPTIONS} DEFINE_EXCEPTIONS)
			list(APPEND BINARY_DEFINES ${DEFINE_RTTI} ${DEFINE_EXCEPTIONS})

			unset(DEFINE_RTTI)
			unset(DEFINE_EXCEPTIONS)
		endif()

		unset(PLATFORM_DEFINES)
	endif()

	if(FLAME_ENABLE_INSTALL)
		if(FLAME_LOCAL_INSTALL)
			set(BINARY_INSTALL_PREFIX
				${FLAME_LOCAL_INSTALL_PREFIX}/${FLAME_PLATFORM_INSTALL_BINARY_DIR})
			set(BINARY_INSTALL_PATH ${BINARY_INSTALL_PREFIX}/${BINARY_INSTALL_DIR})
		elseif(NOT BINARY_INSTALL_PATH)
			set(BINARY_INSTALL_PREFIX
				${CMAKE_INSTALL_PREFIX}/${FLAME_PLATFORM_INSTALL_BINARY_DIR})
			set(BINARY_INSTALL_PATH ${BINARY_INSTALL_PREFIX}/${BINARY_INSTALL_DIR})
		endif()
	endif()
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

	if (BINARY_TEST)
		set(BINARY_TEST TEST)
		if (BINARY_TEST_ARGUMENTS)
			set(BINARY_TEST_ARGUMENTS ${BINARY_TEST} TEST_ARGUMENTS ${BINARY_TEST_ARGUMENTS})
		else()
			set(BINARY_TEST_ARGUMENTS ${BINARY_TEST})
		endif()
	endif()
	internal_add_binary_target_properties(
		PROPERTY_CONTAINER_NAME "${TARGET_CUSTOM_PROPERTIES}"
		REAL_TARGET             "${TARGET_NAME}"
		OUTPUT_NAME             "${BINARY_NAME}"
		INSTALL_PATH            "${BINARY_INSTALL_PATH}"

		ADDING_FILES            "${SOURCE_LIST}"
		COMPILE_FLAGS           "${BINARY_COMPILE_FLAGS}"
		DEPENDENCY_LIBRARIES    "${BINARY_DEPENDENCY_TARGET_LIST}"
		#LINK_FLAGS              "${BINARY_LINK_FLAGS}"
		INCLUDE_PATHS           "${BINARY_INCLUDE_PATHS}"
		DEFINES                 "${BINARY_DEFINES}"

		${BINARY_TEST_ARGUMENTS}
		${BINARY_DEBUG}
	)

	unset(TARGET_CUSTOM_PROPERTIES)
	unset(TARGET_NAME)

	print_newline("-- Adding binary for ${BINARY_NAME} - done")
endmacro(internal_compile_binary_add)

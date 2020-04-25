#
#
#
macro(internal_compile_library_start_function)
	check_internal_use()
	start_debug_function(compile_library)
endmacro(internal_compile_library_start_function)

#
#
#
macro(internal_compile_library_end_function)
	check_internal_use()
	end_debug_function()
endmacro(internal_compile_library_end_function)

#
#
#
macro(internal_compile_library_parse_parameters)
	check_internal_use()

	set(OPTIONS
		"DEBUG"
		"MAKE_STATIC"
		"MAKE_SHARED"
		"NOT_MAKE_POSITION_DEPENDENT_OBJECTS"
		"NOT_MAKE_POSITION_INDEPENDENT_OBJECTS"
		"HELP"
	)
	set(VALUES
		"LIBRARY_NAME"

		"OBJECT_ALIAS_NAME"
		"INDEPENDENT_OBJECT_ALIAS_NAME"
		"STATIC_ALIAS_NAME"
		"SHARED_ALIAS_NAME"

		"SOURCE_LIST_FILE"
		"HEADER_LIST_FILE"

		"STATIC_INSTALL_PATH"
		"SHARED_INSTALL_PATH"
	)
	set(LISTS
		"INCLUDE_PATHS"

		"SOURCE_LIST"
		"HEADER_LIST"

		"COMMPILE_FLAGS"
		"LINK_FLAGS"

		"DEPENDENCY_HEADER_TARGETS"
		"DEPENDENCY_TARGETS_FOR_STATIC"
		"DEPENDENCY_TARGETS_FOR_SHARED"
	)
	cmake_parse_arguments("COMPILE" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")
endmacro(internal_compile_library_parse_parameters)

#
#
#
macro(internal_compile_library_print_parse_result)
	check_internal_use()

	if(COMPILE_DEBUG)
		print_debug_function_newline("-------------- PARSE RESULT --------------")

		# options

		print_debug_function_newline("-- OPTIONS --")

		#print_debug_function_oneline("COMPILE_DEBUG                              = ")
		#print_debug_value_newline("${COMPILE_DEBUG}")

		print_debug_function_oneline("COMPILE_MAKE_STATIC                        = ")
		print_debug_value_newline("${COMPILE_MAKE_STATIC}")

		print_debug_function_oneline("COMPILE_MAKE_SHARED                        = ")
		print_debug_value_newline("${COMPILE_MAKE_SHARED}")

		print_debug_function_oneline("COMPILE_NOT_MAKE_POSITION_DEPENDENT_OBJECTS   = ")
		print_debug_value_newline("${COMPILE_NOT_MAKE_POSITION_DEPENDENT_OBJECTS}")

		print_debug_function_oneline("COMPILE_NOT_MAKE_POSITION_INDEPENDENT_OBJECTS = ")
		print_debug_value_newline("${COMPILE_NOT_MAKE_POSITION_DEPENDENT_OBJECTS}")

		print_debug_function_oneline("COMPILE_HELP                               = ")
		print_debug_value_newline("${COMPILE_HELP}")

		# values

		print_debug_function_newline("--  VALUES --")

		print_debug_function_oneline("COMPILE_LIBRARY_NAME                       = ")
		print_debug_value_newline(${COMPILE_LIBRARY_NAME})

		print_debug_function_oneline("COMPILE_OBJECT_ALIAS_NAME                  = ")
		print_debug_value_newline(${COMPILE_OBJECT_ALIAS_NAME})

		print_debug_function_oneline("COMPILE_INDEPENDENT_OBJECT_ALIAS_NAME         = ")
		print_debug_value_newline(${COMPILE_INDEPENDENT_OBJECT_ALIAS_NAME})

		print_debug_function_oneline("COMPILE_STATIC_ALIAS_NAME                  = ")
		print_debug_value_newline(${COMPILE_STATIC_ALIAS_NAME})

		print_debug_function_oneline("COMPILE_SHARED_ALIAS_NAME                  = ")
		print_debug_value_newline(${COMPILE_SHARED_ALIAS_NAME})

		print_debug_function_oneline("COMPILE_SOURCE_LIST_FILE                   = ")
		print_debug_value_newline(${COMPILE_SOURCE_LIST_FILE})

		print_debug_function_oneline("COMPILE_HEADER_LIST_FILE                   = ")
		print_debug_value_newline(${COMPILE_HEADER_LIST_FILE})

		print_debug_function_oneline("COMPILE_STATIC_INSTALL_PATH                = ")
		print_debug_value_newline(${COMPILE_STATIC_INSTALL_PATH})

		print_debug_function_oneline("COMPILE_SHARED_INSTALL_PATH                = ")
		print_debug_value_newline(${COMPILE_SHARED_INSTALL_PATH})

		# lists

		print_debug_function_newline("--  LISTS  --")

		print_debug_function_oneline("COMPILE_INCLUDE_PATHS                      = ")
		print_debug_value_newline("${COMPILE_INCLUDE_PATHS}")

		print_debug_function_oneline("COMPILE_SOURCE_LIST                        = ")
		print_debug_value_newline(${COMPILE_SOURCE_LIST})

		print_debug_function_oneline("COMPILE_HEADER_LIST                        = ")
		print_debug_value_newline(${COMPILE_HEADER_LIST})

		print_debug_function_oneline("COMPILE_COMPILE_FLAGS                      = ")
		print_debug_value_newline("${COMPILE_COMPILE_FLAGS}")

		print_debug_function_oneline("COMPILE_LINK_FLAGS                         = ")
		print_debug_value_newline("${COMPILE_LINK_FLAGS}")

		print_debug_function_oneline("COMPILE_DEPENDENCY_HEADER_TARGETS          = ")
		print_debug_value_newline("${COMPILE_DEPENDENCY_HEADER_TARGETS}")

		print_debug_function_oneline("COMPILE_DEPENDENCY_TARGETS_FOR_STATIC      = ")
		print_debug_value_newline("${COMPILE_DEPENDENCY_TARGETS_FOR_STATIC}")

		print_debug_function_oneline("COMPILE_DEPENDENCY_TARGETS_FOR_SHARED      = ")
		print_debug_value_newline("${COMPILE_DEPENDENCY_TARGETS_FOR_SHARED}")

		print_debug_function_newline("-------------- PARSE RESULT --------------")
	endif()
endmacro(internal_compile_library_print_parse_result)

#
#
#
macro(internal_compile_library_process_parameters)
	check_internal_use()

	if(COMPILE_SOURCE_LIST_FILE)
		if(EXISTS ${COMPILE_SOURCE_LIST_FILE})
			include(${COMPILE_SOURCE_LIST_FILE})
		else()
			message_fatal("-- "
				"Need source list file with defined 'SOURCE_LIST' variable.")
		endif()
	endif()
	if(COMPILE_SOURCE_LIST)
		list(APPEND SOURCE_LIST ${COMPILE_SOURCE_LIST})
	endif()
	if(NOT COMPILE_SOURCE_LIST_FILE)
		if(NOT COMPILE_SOURCE_LIST)
			message_fatal("-- "
				"Need 'SOURCE_LIST_FILE' or/and 'SOURCE_LIST'.")
		endif()
	endif()

	if(COMPILE_HEADER_LIST_FILE)
		if(EXISTS ${COMPILE_HEADER_LIST_FILE})
			include(${COMPILE_HEADER_LIST_FILE})
			list(APPEND SOURCE_LIST "${HEADER_LIST}")
		endif()
	endif()
	if(COMPILE_HEADER_LIST)
		list(APPEND SOURCE_LIST ${COMPILE_SOURCE_LIST})
	endif()

	internal_print_warning_not_support("${COMPILE_HELP}"
		HELP)
	internal_print_warning_not_support("${COMPILE_NOT_MAKE_POSITION_DEPENDENT_OBJECTS}"
		NOT_MAKE_POSITION_DEPENDENT_OBJECTS)
	internal_print_warning_not_support("${COMPILE_NOT_MAKE_POSITION_INDEPENDENT_OBJECTS}"
		NOT_MAKE_INPOSITION_DEPENDENT_OBJECTS)
	internal_print_warning_not_support("${COMPILE_COMPILE_FLAGS}"
		COMPILE_FLAGS)
	internal_print_warning_not_support("${COMPILE_LINK_FLAGS}"
		LINK_FLAGS)
	internal_print_warning_not_support("${COMPILE_STATIC_INSTALL_PATH}"
		STATIC_INSTALL_PATH)
	internal_print_warning_not_support("${COMPILE_SHARED_INSTALL_PATH}"
		SHARED_INSTALL_PATH)
endmacro(internal_compile_library_process_parameters)

#
#
#
macro(internal_compile_library_print_help)
	check_internal_use()
endmacro(internal_compile_library_print_help)

#
#
#
macro(internal_compile_independent_object_library)
	check_internal_use()

	print_newline(
		"-- Adding position independ object library for ${COMPILE_LIBRARY_NAME}")

	string(CONCAT TARGET_NAME_DEPEND
		"${COMPILE_LIBRARY_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_OBJECT_MODULE_SUFFIX}")
	string(CONCAT TARGET_NAME_INDEPEND
		"${COMPILE_LIBRARY_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_OBJECT_MODULE_SUFFIX}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_OBJECT_INDEPENDENT_MODULE_SUFFIX}")

	if(FLAME_ONLY_POSITION_INDEPENDENT_OBJECTS)
		set(TARGET_NAME ${TARGET_NAME_DEPEND})
	else()
		set(TARGET_NAME ${TARGET_NAME_INDEPEND})
	endif()

	string(CONCAT TARGET_CUSTOM_PROPERTIES
		"${TARGET_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_CUSTOM_TARGET_SUFFIX}")

	if(FLAME_ONLY_POSITION_INDEPENDENT_OBJECTS)
		set(OBJECT_ALIASES
			"${COMPILE_INDEPENDENT_OBJECT_ALIAS_NAME}"
			"${COMPILE_OBJECT_ALIAS_NAME}"
			"${TARGET_NAME_INDEPEND}")
	else()
		set(OBJECT_ALIASES
			"${COMPILE_INDEPENDENT_OBJECT_ALIAS_NAME}")
	endif()

	#set(DEBUG DEBUG)
	internal_add_object_target_properties(
		PROPERTY_CONTAINER_NAME "${TARGET_CUSTOM_PROPERTIES}"
		REAL_TARGET             "${TARGET_NAME}"
		ADDING_SOURCES          "${SOURCE_LIST}"
		INCLUDE_PATHS           "${COMPILE_INCLUDE_PATHS}"
		DEPENDENCY_HEADERS      "${COMPILE_DEPENDENCY_HEADER_TARGETS}"
		COMPILE_FLAGS           "${COMPILE_COMPILE_FLAGS}"
		POSITION_INDEPEND
		OBJECT_ALIASES          "${OBJECT_ALIASES}"
		#DEBUG
	)

	unset(TARGET_CUSTOM_PROPERTIES)
	unset(TARGET_NAME)
	unset(TARGET_NAME_INDEPEND)
	unset(TARGET_NAME_DEPEND)

	print_newline(
		"-- Adding position independ object library for ${COMPILE_LIBRARY_NAME} - done")
endmacro(internal_compile_independent_object_library)

#
#
#
macro(internal_compile_dependent_object_library)
	check_internal_use()

	print_newline("-- Adding position depend object library for ${COMPILE_LIBRARY_NAME}")

	string(CONCAT TARGET_NAME
		"${COMPILE_LIBRARY_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_OBJECT_MODULE_SUFFIX}")
	string(CONCAT TARGET_CUSTOM_PROPERTIES
		"${TARGET_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_CUSTOM_TARGET_SUFFIX}")

	#set(DEBUG DEBUG)
	internal_add_object_target_properties(
		PROPERTY_CONTAINER_NAME "${TARGET_CUSTOM_PROPERTIES}"
		REAL_TARGET             "${TARGET_NAME}"
		ADDING_SOURCES          "${SOURCE_LIST}"
		INCLUDE_PATHS           "${COMPILE_INCLUDE_PATHS}"
		DEPENDENCY_HEADERS      "${COMPILE_DEPENDENCY_HEADER_TARGETS}"
		COMPILE_FLAGS           "${COMPILE_COMPILE_FLAGS}"
		OBJECT_ALIASES          "${COMPILE_OBJECT_ALIAS_NAME}"
		#DEBUG
	)

	unset(TARGET_CUSTOM_PROPERTIES)
	unset(TARGET_NAME)

	print_newline("-- Adding object library for ${COMPILE_LIBRARY_NAME} - done")
endmacro(internal_compile_dependent_object_library)

#
#
#
macro(internal_compile_object_library)
	check_internal_use()

	internal_compile_independent_object_library()
	if(NOT FLAME_ONLY_POSITION_INDEPENDENT_OBJECTS)
		internal_compile_dependent_object_library()
	endif()
endmacro(internal_compile_object_library)


#
#
#
macro(internal_compile_static_library)
	check_internal_use()

	print_newline("-- Adding static library for ${COMPILE_LIBRARY_NAME}")

	string(CONCAT TARGET_NAME
		"${COMPILE_LIBRARY_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_STATIC_MODULE_SUFFIX}")
	string(CONCAT TARGET_CUSTOM_PROPERTIES
		"${TARGET_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_CUSTOM_TARGET_SUFFIX}")

	string(CONCAT TARGET_DEPENDENT_OBJECT_LIBRARY
		"${COMPILE_LIBRARY_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_OBJECT_MODULE_SUFFIX}")

	#set(DEBUG DEBUG)
	internal_add_static_target_properties(
		PROPERTY_CONTAINER_NAME "${TARGET_CUSTOM_PROPERTIES}"
		REAL_TARGET             "${TARGET_NAME}"
		#ADDING_SOURCES          "${}"
		ADDING_OBJECTS          "${TARGET_DEPENDENT_OBJECT_LIBRARY}"
		DEPENDENCY_HEADERS      "${COMPILE_DEPENDENCY_HEADER_TARGETS}"
		DEPENDENCY_LIBRARIES    "${COMPILE_DEPENDENCY_TARGETS_FOR_STATIC}"
		#COMPILE_FLAGS           "${}"
		OUTPUT_NAME             "${COMPILE_LIBRARY_NAME}"
		LIBRARY_ALIASES         "${COMPILE_STATIC_ALIAS_NAME}"
		#DEBUG
	)

	unset(TARGET_DEPENDENT_OBJECT_LIBRARY)
	unset(TARGET_CUSTOM_PROPERTIES)
	unset(TARGET_NAME)

	print_newline("-- Adding static library for ${COMPILE_LIBRARY_NAME} - done")
endmacro(internal_compile_static_library)

#
#
#
macro(internal_compile_shared_library)
	check_internal_use()

	print_newline("-- Adding shared library for ${COMPILE_LIBRARY_NAME}")

	string(CONCAT TARGET_NAME
		"${COMPILE_LIBRARY_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_SHARED_MODULE_SUFFIX}")
	string(CONCAT TARGET_CUSTOM_PROPERTIES
		"${TARGET_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_CUSTOM_TARGET_SUFFIX}")

	string(CONCAT TARGET_INDEPENDENT_OBJECT_LIBRARY
		"${COMPILE_LIBRARY_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_OBJECT_MODULE_SUFFIX}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_OBJECT_INDEPENDENT_MODULE_SUFFIX}")

	#set(DEBUG DEBUG)
	internal_add_shared_target_properties(
		PROPERTY_CONTAINER_NAME "${TARGET_CUSTOM_PROPERTIES}"
		REAL_TARGET             "${TARGET_NAME}"
		#ADDING_SOURCES          "${}"
		ADDING_OBJECTS          "${TARGET_INDEPENDENT_OBJECT_LIBRARY}"
		DEPENDENCY_HEADERS      "${COMPILE_DEPENDENCY_HEADER_TARGETS}"
		DEPENDENCY_LIBRARIES    "${COMPILE_DEPENDENCY_TARGETS_FOR_SHARED}"
		#COMPILE_FLAGS           "${}"
		#LINK_FLAGS              "${}"
		OUTPUT_NAME             "${COMPILE_LIBRARY_NAME}"
		LIBRARY_ALIASES         "${COMPILE_SHARED_ALIAS_NAME}"
		#DEBUG
	)

	unset(TARGET_INDEPENDENT_OBJECT_LIBRARY)
	unset(TARGET_CUSTOM_PROPERTIES)
	unset(TARGET_NAME)

	print_newline("-- Adding shared library for ${COMPILE_LIBRARY_NAME} - done")
endmacro(internal_compile_shared_library)

#
#
#
function(compile_library)
	enable_internal_use()

	# Parse parameters
	internal_compile_library_parse_parameters(${ARGV})

	# Start function log
	internal_compile_library_start_function()

	# Print parse result
	internal_compile_library_print_parse_result()

	# Check parameters
	internal_compile_library_process_parameters()

	# Add object library/libraries to resolve list
	internal_compile_object_library()

	# Add static library to resolve list
	if(MAKE_STATIC)
		if(FLAME_MAKE_STATIC)
			internal_compile_static_library()
		else()
			print_newline(
				"-- Need 'MAKE_STATIC', but making static libraries are disabled")
		endif()
	endif()

	# Add shared library to resolve list
	if(MAKE_SHARED)
		if(FLAME_MAKE_SHARED)
			internal_compile_shared_library()
		else()
			print_newline(
				"-- Need 'MAKE_SHARED', but making shared libraries are disabled")
		endif()
	endif()

	# End function log
	internal_compile_library_end_function()
endfunction(compile_library)

#
#
#
function(internal_compile_library)
	check_internal_use()

	# Parse parameters
	set(OPTIONS "DEBUG" "MAKE_STATIC" "MAKE_SHARED"
		"NOT_MAKE_POSITION_DEPENDENT_OBJECTS"
		"NOT_MAKE_POSITION_INDEPENDENT_OBJECTS")
	set(VALUES "NAME" "OBJECT_ALIAS_NAME" "INDEPENDENT_OBJECT_ALIAS_NAME"
		"STATIC_ALIAS_NAME" "SHARED_ALIAS_NAME" "STATIC_INSTALL_PATH"
		"SHARED_INSTALL_PATH")
	set(LISTS "INCLUDE_PATHS" "SOURCE_LIST" "COMPILE_FLAGS" "LINK_FLAGS"
		"DEPENDENCY_HEADER_TARGETS" "DEPENDENCY_TARGETS_FOR_STATIC"
		"DEPENDENCY_TARGETS_FOR_SHARED")
	cmake_parse_arguments("COMPILE" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	internal_compile_library_start_function()

	internal_compile_library_print_parse_result()
	internal_compile_library_process_parameters()
	internal_compile_object_library()

	if(MAKE_STATIC)
		if(FLAME_MAKE_STATIC)
			internal_compile_static_library()
		else()
			print_newline(
				"-- Need 'MAKE_STATIC', but making static libraries are disabled")
		endif()
	endif()

	if(MAKE_SHARED)
		if(FLAME_MAKE_SHARED)
			internal_compile_shared_library()
		else()
			print_newline(
				"-- Need 'MAKE_SHARED', but making shared libraries are disabled")
		endif()
	endif()

	internal_compile_library_end_function()
endfunction(internal_compile_library)

# macros

macro(internal_compile_library_start_function)
	start_debug_function("internal_compile_library")
endmacro(internal_compile_library_start_function)

macro(internal_compile_library_end_function)
	end_debug_function()
endmacro(internal_compile_library_end_function)

macro(internal_compile_library_print_parse_result)
	if(COMPILE_DEBUG OR (FLAME_CMAKE_DEBUG AND FLAME_CMAKE_DEBUG_SHOW_PARSE_RESULTS))
		print_debug_function_newline("-------------- PARSE RESULT --------------")

		# options

		print_debug_function_oneline("COMPILE_MAKE_STATIC                           = ")
		print_debug_value_newline("${COMPILE_MAKE_STATIC}")

		print_debug_function_oneline("COMPILE_MAKE_SHARED                           = ")
		print_debug_value_newline("${COMPILE_MAKE_SHARED}")

		print_debug_function_oneline("COMPILE_NOT_MAKE_POSITION_DEPENDENT_OBJECTS   = ")
		print_debug_value_newline("${COMPILE_NOT_MAKE_POSITION_DEPENDENT_OBJECTS}")

		print_debug_function_oneline("COMPILE_NOT_MAKE_POSITION_INDEPENDENT_OBJECTS = ")
		print_debug_value_newline("${COMPILE_NOT_MAKE_POSITION_DEPENDENT_OBJECTS}")

		# values

		print_debug_function_oneline("COMPILE_NAME                                  = ")
		print_debug_value_newline(${COMPILE_NAME})

		print_debug_function_oneline("COMPILE_OBJECT_ALIAS_NAME                     = ")
		print_debug_value_newline(${COMPILE_OBJECT_ALIAS_NAME})

		print_debug_function_oneline("COMPILE_INDEPENDENT_OBJECT_ALIAS_NAME         = ")
		print_debug_value_newline(${COMPILE_INDEPENDENT_OBJECT_ALIAS_NAME})

		print_debug_function_oneline("COMPILE_STATIC_ALIAS_NAME                     = ")
		print_debug_value_newline(${COMPILE_STATIC_ALIAS_NAME})

		print_debug_function_oneline("COMPILE_SHARED_ALIAS_NAME                     = ")
		print_debug_value_newline(${COMPILE_SHARED_ALIAS_NAME})

		print_debug_function_oneline("COMPILE_STATIC_INSTALL_PATH                   = ")
		print_debug_value_newline(${COMPILE_STATIC_INSTALL_PATH})

		print_debug_function_oneline("COMPILE_SHARED_INSTALL_PATH                   = ")
		print_debug_value_newline(${COMPILE_SHARED_INSTALL_PATH})

		# lists

		print_debug_function_oneline("COMPILE_INCLUDE_PATHS                         = ")
		print_debug_value_newline("${COMPILE_INCLUDE_PATHS}")

		print_debug_function_oneline("COMPILE_SOURCE_LIST                           = ")
		print_debug_value_newline(${COMPILE_SOURCE_LIST})

		print_debug_function_oneline("COMPILE_COMPILE_FLAGS                         = ")
		print_debug_value_newline("${COMPILE_COMPILE_FLAGS}")

		print_debug_function_oneline("COMPILE_LINK_FLAGS                            = ")
		print_debug_value_newline("${COMPILE_LINK_FLAGS}")

		print_debug_function_oneline("COMPILE_DEPENDENCY_HEADER_TARGETS             = ")
		print_debug_value_newline("${COMPILE_DEPENDENCY_HEADER_TARGETS}")

		print_debug_function_oneline("COMPILE_DEPENDENCY_TARGETS_FOR_STATIC         = ")
		print_debug_value_newline("${COMPILE_DEPENDENCY_TARGETS_FOR_STATIC}")

		print_debug_function_oneline("COMPILE_DEPENDENCY_TARGETS_FOR_SHARED         = ")
		print_debug_value_newline("${COMPILE_DEPENDENCY_TARGETS_FOR_SHARED}")

		print_debug_function_newline("-------------- PARSE RESULT --------------")
	endif()
	if (COMPILE_DEBUG)
		set(COMPILE_DEBUG DEBUG)
	endif()
endmacro(internal_compile_library_print_parse_result)

macro(internal_compile_library_process_parameters)
	if(NOT COMPILE_NAME)
		message_fatal("Need 'NAME'.")
	endif()
	if(COMPILE_SOURCE_LIST)
		list(APPEND SOURCE_LIST ${COMPILE_SOURCE_LIST})
	else()
		message_fatal("Need 'SOURCE_LIST'.")
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

macro(internal_compile_independent_object_library)
	check_internal_use()

	print_newline(
		"-- Adding position independent object library for ${COMPILE_NAME}")

	string(CONCAT TARGET_NAME_DEPENDENT
		"${COMPILE_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_OBJECT_MODULE_SUFFIX}")
	string(CONCAT TARGET_NAME_INDEPENDENT
		"${COMPILE_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_OBJECT_MODULE_SUFFIX}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_OBJECT_INDEPENDENT_MODULE_SUFFIX}")

	if(FLAME_ONLY_POSITION_INDEPENDENT_OBJECTS)
		set(TARGET_NAME ${TARGET_NAME_DEPENDENT})
	else()
		set(TARGET_NAME ${TARGET_NAME_INDEPENDENT})
	endif()

	string(CONCAT TARGET_CUSTOM_PROPERTIES
		"${TARGET_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_CUSTOM_TARGET_SUFFIX}")

	if(FLAME_ONLY_POSITION_INDEPENDENT_OBJECTS)
		set(OBJECT_ALIASES
			"${COMPILE_INDEPENDENT_OBJECT_ALIAS_NAME}"
			"${COMPILE_OBJECT_ALIAS_NAME}"
			"${TARGET_NAME_INDEPENDENT}")
	else()
		set(OBJECT_ALIASES
			"${COMPILE_INDEPENDENT_OBJECT_ALIAS_NAME}")
	endif()

	internal_add_object_target_properties(
		PROPERTY_CONTAINER_NAME "${TARGET_CUSTOM_PROPERTIES}"
		REAL_TARGET             "${TARGET_NAME}"
		ADDING_FILES            "${SOURCE_LIST}"
		INCLUDE_PATHS           "${COMPILE_INCLUDE_PATHS}"
		DEPENDENCY_HEADERS      "${COMPILE_DEPENDENCY_HEADER_TARGETS}"
		COMPILE_FLAGS           "${COMPILE_COMPILE_FLAGS}"
		POSITION_INDEPENDENT
		OBJECT_ALIASES          "${OBJECT_ALIASES}"
		${COMPILE_DEBUG}
	)

	unset(TARGET_CUSTOM_PROPERTIES)
	unset(TARGET_NAME)
	unset(TARGET_NAME_INDEPENDENT)
	unset(TARGET_NAME_DEPENDENT)

	print_newline(
		"-- Adding position independent object library for ${COMPILE_NAME} - done")
endmacro(internal_compile_independent_object_library)

#
#
#
macro(internal_compile_dependent_object_library)
	check_internal_use()

	print_newline("-- Adding position dependent object library for ${COMPILE_NAME}")

	string(CONCAT TARGET_NAME
		"${COMPILE_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_OBJECT_MODULE_SUFFIX}")
	string(CONCAT TARGET_CUSTOM_PROPERTIES
		"${TARGET_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_CUSTOM_TARGET_SUFFIX}")

	internal_add_object_target_properties(
		PROPERTY_CONTAINER_NAME "${TARGET_CUSTOM_PROPERTIES}"
		REAL_TARGET             "${TARGET_NAME}"
		ADDING_FILES            "${SOURCE_LIST}"
		INCLUDE_PATHS           "${COMPILE_INCLUDE_PATHS}"
		DEPENDENCY_HEADERS      "${COMPILE_DEPENDENCY_HEADER_TARGETS}"
		COMPILE_FLAGS           "${COMPILE_COMPILE_FLAGS}"
		OBJECT_ALIASES          "${COMPILE_OBJECT_ALIAS_NAME}"
		${COMPILE_DEBUG}
	)

	unset(TARGET_CUSTOM_PROPERTIES)
	unset(TARGET_NAME)

	print_newline(
		"-- Adding position dependent object library for ${COMPILE_NAME} - done")
endmacro(internal_compile_dependent_object_library)

#
#
#
macro(internal_compile_object_library)
	internal_compile_independent_object_library()
	if(NOT FLAME_ONLY_POSITION_INDEPENDENT_OBJECTS)
		internal_compile_dependent_object_library()
	endif()
endmacro(internal_compile_object_library)


#
#
#
macro(internal_compile_static_library)
	print_newline("-- Adding static library for ${COMPILE_NAME}")

	string(CONCAT TARGET_NAME
		"${COMPILE_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_STATIC_MODULE_SUFFIX}")
	string(CONCAT TARGET_CUSTOM_PROPERTIES
		"${TARGET_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_CUSTOM_TARGET_SUFFIX}")

	string(CONCAT TARGET_DEPENDENT_OBJECT_LIBRARY
		"${COMPILE_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_OBJECT_MODULE_SUFFIX}")

	internal_add_static_target_properties(
		PROPERTY_CONTAINER_NAME "${TARGET_CUSTOM_PROPERTIES}"
		REAL_TARGET             "${TARGET_NAME}"
		#ADDING_SOURCES          "${}"
		ADDING_OBJECTS          "${TARGET_DEPENDENT_OBJECT_LIBRARY}"
		DEPENDENCY_HEADERS      "${COMPILE_DEPENDENCY_HEADER_TARGETS}"
		DEPENDENCY_LIBRARIES    "${COMPILE_DEPENDENCY_TARGETS_FOR_STATIC}"
		#COMPILE_FLAGS           "${}"
		OUTPUT_NAME             "${COMPILE_NAME}"
		LIBRARY_ALIASES         "${COMPILE_STATIC_ALIAS_NAME}"
		${COMPILE_DEBUG}
	)

	unset(TARGET_DEPENDENT_OBJECT_LIBRARY)
	unset(TARGET_CUSTOM_PROPERTIES)
	unset(TARGET_NAME)

	print_newline("-- Adding static library for ${COMPILE_NAME} - done")
endmacro(internal_compile_static_library)

#
#
#
macro(internal_compile_shared_library)
	print_newline("-- Adding shared library for ${COMPILE_NAME}")

	string(CONCAT TARGET_NAME
		"${COMPILE_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_SHARED_MODULE_SUFFIX}")
	string(CONCAT TARGET_CUSTOM_PROPERTIES
		"${TARGET_NAME}"
		"${FLAME_NAME_SEPARATOR}"
		"${FLAME_CUSTOM_TARGET_SUFFIX}")

	string(CONCAT TARGET_INDEPENDENT_OBJECT_LIBRARY
		"${COMPILE_NAME}"
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
		OUTPUT_NAME             "${COMPILE_NAME}"
		LIBRARY_ALIASES         "${COMPILE_SHARED_ALIAS_NAME}"
		${COMPILE_DEBUG}
	)

	unset(TARGET_INDEPENDENT_OBJECT_LIBRARY)
	unset(TARGET_CUSTOM_PROPERTIES)
	unset(TARGET_NAME)

	print_newline("-- Adding shared library for ${COMPILE_NAME} - done")
endmacro(internal_compile_shared_library)

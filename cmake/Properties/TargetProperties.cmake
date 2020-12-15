# TargetProperties.cmake

# Options:
#   DEBUG -
# Values:
#   PROPERTY_CONTAINER_NAME -
#   REAL_TARGET             -
#   INSTALL_PATH            -
# Lists:
#   ADDING_FILES       - Sources and headers
#   INCLUDE_PATHS      -
#   DEPENDENCY_HEADERS -
#   LIBRARY_ALIASES    -
function(internal_add_header_target_properties)
	check_internal_use()

	set(OPTIONS "DEBUG")
	set(VALUES "PROPERTY_CONTAINER_NAME" "REAL_TARGET" "INSTALL_PATH")
	set(LISTS "ADDING_FILES" "INCLUDE_PATHS" "DEPENDENCY_HEADERS" "LIBRARY_ALIASES")

	cmake_parse_arguments("FLAME" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	start_debug_function(internal_add_header_target_properties)

	if(FLAME_DEBUG OR (FLAME_CMAKE_DEBUG AND FLAME_CMAKE_DEBUG_SHOW_PARSE_RESULTS))
		print_debug_function_newline("-------- PARSE RESULT --------")

		print_debug_function_oneline("FLAME_PROPERTY_CONTAINER_NAME = ")
		print_debug_value_newline(${FLAME_PROPERTY_CONTAINER_NAME})

		print_debug_function_oneline("FLAME_REAL_TARGET             = ")
		print_debug_value_newline(${FLAME_REAL_TARGET})

		print_debug_function_oneline("FLAME_ADDING_FILES            = ")
		print_debug_value_newline(${FLAME_ADDING_FILES})

		print_debug_function_oneline("FLAME_INCLUDE_PATHS           = ")
		print_debug_value_newline(${FLAME_INCLUDE_PATHS})

		print_debug_function_oneline("FLAME_DEPENDENCY_HEADERS      = ")
		print_debug_value_newline(${FLAME_DEPENDENCY_HEADERS})

		print_debug_function_oneline("FLAME_LIBRARY_ALIASES         = ")
		print_debug_value_newline(${FLAME_LIBRARY_ALIASES})

		print_debug_function_oneline("FLAME_INSTALL_PATH            = ")
		print_debug_value_newline(${FLAME_INSTALL_PATH})

		print_debug_function_newline("-------- PARSE RESULT --------")
	endif()

	add_custom_target(${FLAME_PROPERTY_CONTAINER_NAME})
	set_property(GLOBAL APPEND PROPERTY FLAME_HEADER_TARGETS
		${FLAME_PROPERTY_CONTAINER_NAME}
	)
	set_target_properties(${FLAME_PROPERTY_CONTAINER_NAME}
		PROPERTIES
			FLAME_REAL_TARGET        "${FLAME_REAL_TARGET}"
			FLAME_ADDING_FILES       "${FLAME_ADDING_FILES}"
			FLAME_DEPENDENCY_HEADERS "${FLAME_DEPENDENCY_HEADERS}"
			FLAME_LIBRARY_ALIASES    "${FLAME_LIBRARY_ALIASES}"
			FLAME_INSTALL_PATH       "${FLAME_INSTALL_PATH}"
	)

	end_debug_function()
endfunction(internal_add_header_target_properties)

# Options:
#   DEBUG                -
#   POSITION_INDEPENDENT -
# Values:
#   PROPERTY_CONTAINER_NAME -
#   REAL_TARGET             -
# Lists:
#   ADDING_FILES       -
#   INCLUDE_PATHS      -
#   DEPENDENCY_HEADERS -
#   COMPILE_FLAGS      -
#   OBJECT_ALIASES     -
function(internal_add_object_target_properties)
	check_internal_use()

	set(OPTIONS "DEBUG" "POSITION_INDEPENDENT")
	set(VALUES "PROPERTY_CONTAINER_NAME" "REAL_TARGET")
	set(LISTS "ADDING_FILES" "INCLUDE_PATHS" "DEPENDENCY_HEADERS" "COMPILE_FLAGS"
		"OBJECT_ALIASES")

	cmake_parse_arguments("FLAME" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	start_debug_function(internal_add_object_target_properties)

	if(FLAME_DEBUG OR (FLAME_CMAKE_DEBUG AND FLAME_CMAKE_DEBUG_SHOW_PARSE_RESULTS))
		print_debug_function_newline("-------- PARSE RESULT --------")

		print_debug_function_oneline("FLAME_PROPERTY_CONTAINER_NAME = ")
		print_debug_value_newline(${FLAME_PROPERTY_CONTAINER_NAME})

		print_debug_function_oneline("FLAME_REAL_TARGET             = ")
		print_debug_value_newline(${FLAME_REAL_TARGET})

		print_debug_function_oneline("FLAME_ADDING_FILES            = ")
		print_debug_value_newline(${FLAME_ADDING_FILES})

		print_debug_function_oneline("FLAME_INCLUDE_PATHS           = ")
		print_debug_value_newline(${FLAME_INCLUDE_PATHS})

		print_debug_function_oneline("FLAME_DEPENDENCY_HEADERS      = ")
		print_debug_value_newline(${FLAME_DEPENDENCY_HEADERS})

		print_debug_function_oneline("FLAME_COMPILE_FLAGS           = ")
		print_debug_value_newline(${FLAME_COMPILE_FLAGS})

		print_debug_function_oneline("FLAME_POSITION_INDEPENDENT    = ")
		print_debug_value_newline(${FLAME_POSITION_INDEPENDENT})

		print_debug_function_oneline("FLAME_OBJECT_ALIASES          = ")
		print_debug_value_newline(${FLAME_OBJECT_ALIASES})

		print_debug_function_newline("-------- PARSE RESULT --------")
	endif()

	add_custom_target(${FLAME_PROPERTY_CONTAINER_NAME})
	set_property(GLOBAL APPEND PROPERTY FLAME_OBJECT_TARGETS
		${FLAME_PROPERTY_CONTAINER_NAME}
	)
	set_target_properties(${FLAME_PROPERTY_CONTAINER_NAME}
		PROPERTIES
			FLAME_REAL_TARGET          "${FLAME_REAL_TARGET}"
			FLAME_ADDING_FILES         "${FLAME_ADDING_FILES}"
			FLAME_INCLUDE_PATHS        "${FLAME_INCLUDE_PATHS}"
			FLAME_DEPENDENCY_HEADERS   "${FLAME_DEPENDENCY_HEADERS}"
			FLAME_COMPILE_FLAGS        "${FLAME_COMPILE_FLAGS}"
			FLAME_POSITION_INDEPENDENT "${FLAME_POSITION_INDEPENDENT}"
			FLAME_OBJECT_ALIASES       "${FLAME_OBJECT_ALIASES}"
	)

	end_debug_function()
endfunction(internal_add_object_target_properties)

# Options:
#   DEBUG -
# Values:
#   PROPERTY_CONTAINER_NAME -
#   REAL_TARGET             -
#   OUTPUT_NAME             -
#   INSTALL_PATH            -
# Lists:
#   ADDING_SOURCES       -
#   ADDING_OBJECTS       -
#   DEPENDENCY_HEADERS   -
#   DEPENDENCY_LIBRARIES -
#   COMPILE_FLAGS        -
#   LIBRARY_ALIASES      -
function(internal_add_static_target_properties)
	check_internal_use()

	set(OPTIONS "DEBUG")
	set(VALUES "PROPERTY_CONTAINER_NAME" "REAL_TARGET" "OUTPUT_NAME" "INSTALL_PATH")
	set(LISTS "ADDING_SOURCES" "ADDING_OBJECTS" "DEPENDENCY_HEADERS"
		"DEPENDENCY_LIBRARIES" "COMPILE_FLAGS" "LIBRARY_ALIASES")

	cmake_parse_arguments("FLAME" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	start_debug_function(internal_add_static_target_properties)

	if(FLAME_DEBUG OR (FLAME_CMAKE_DEBUG AND FLAME_CMAKE_DEBUG_SHOW_PARSE_RESULTS))
		print_debug_function_newline("-------- PARSE RESULT --------")

		print_debug_function_oneline("FLAME_PROPERTY_CONTAINER_NAME = ")
		print_debug_value_newline(${FLAME_PROPERTY_CONTAINER_NAME})

		print_debug_function_oneline("FLAME_REAL_TARGET             = ")
		print_debug_value_newline(${FLAME_REAL_TARGET})

		print_debug_function_oneline("FLAME_ADDING_SOURCES          = ")
		print_debug_value_newline(${FLAME_ADDING_SOURCES})

		print_debug_function_oneline("FLAME_ADDING_OBJECTS          = ")
		print_debug_value_newline(${FLAME_ADDING_OBJECTS})

		print_debug_function_oneline("FLAME_DEPENDENCY_HEADERS      = ")
		print_debug_value_newline(${FLAME_DEPENDENCY_HEADERS})

		print_debug_function_oneline("FLAME_DEPENDENCY_LIBRARIES    = ")
		print_debug_value_newline(${FLAME_DEPENDENCY_LIBRARIES})

		print_debug_function_oneline("FLAME_COMPILE_FLAGS           = ")
		print_debug_value_newline(${FLAME_COMPILE_FLAGS})

		print_debug_function_oneline("FLAME_OUTPUT_NAME             = ")
		print_debug_value_newline(${FLAME_OUTPUT_NAME})

		print_debug_function_oneline("FLAME_LIBRARY_ALIASES         = ")
		print_debug_value_newline(${FLAME_LIBRARY_ALIASES})

		print_debug_function_oneline("FLAME_INSTALL_PATH            = ")
		print_debug_value_newline(${FLAME_INSTALL_PATH})

		print_debug_function_newline("-------- PARSE RESULT --------")
	endif()

	add_custom_target(${FLAME_PROPERTY_CONTAINER_NAME})
	set_property(GLOBAL APPEND PROPERTY FLAME_STATIC_TARGETS
		${FLAME_PROPERTY_CONTAINER_NAME}
	)
	set_target_properties(${FLAME_PROPERTY_CONTAINER_NAME}
		PROPERTIES
			FLAME_REAL_TARGET          "${FLAME_REAL_TARGET}"
			FLAME_ADDING_SOURCES       "${FLAME_ADDING_SOURCES}"
			FLAME_ADDING_OBJECTS       "${FLAME_ADDING_OBJECTS}"
			FLAME_DEPENDENCY_HEADERS   "${FLAME_DEPENDENCY_HEADERS}"
			FLAME_DEPENDENCY_LIBRARIES "${FLAME_DEPENDENCY_LIBRARIES}"
			FLAME_COMPILE_FLAGS        "${FLAME_COMPILE_FLAGS}"
			FLAME_OUTPUT_NAME          "${FLAME_OUTPUT_NAME}"
			FLAME_LIBRARY_ALIASES      "${FLAME_LIBRARY_ALIASES}"
			FLAME_INSTALL_PATH         "${FLAME_INSTALL_PATH}"
	)


	end_debug_function()
endfunction(internal_add_static_target_properties)

# Options:
#   DEBUG -
# Values:
#   PROPERTY_CONTAINER_NAME -
#   REAL_TARGET             -
#   OUTPUT_NAME             -
#   INSTALL_PATH            -
# Lists:
#   ADDING_SOURCES       -
#   ADDING_OBJECTS       -
#   DEPENDENCY_HEADERS   -
#   DEPENDENCY_LIBRARIES -
#   COMPILE_FLAGS        -
#   LINK_FLAGS           -
#   LIBRARY_ALIASES      -
function(internal_add_shared_target_properties)
	check_internal_use()

	set(OPTIONS "DEBUG")
	set(VALUES "PROPERTY_CONTAINER_NAME" "REAL_TARGET" "OUTPUT_NAME" "INSTALL_PATH")
	set(LISTS "ADDING_SOURCES" "ADDING_OBJECTS" "DEPENDENCY_HEADERS"
		"DEPENDENCY_LIBRARIES" "COMPILE_FLAGS" "LINK_FLAGS" "LIBRARY_ALIASES")

	cmake_parse_arguments("FLAME" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	start_debug_function(internal_add_shared_target_properties)

	if(FLAME_DEBUG OR (FLAME_CMAKE_DEBUG AND FLAME_CMAKE_DEBUG_SHOW_PARSE_RESULTS))
		print_debug_function_newline("-------- PARSE RESULT --------")

		print_debug_function_oneline("FLAME_PROPERTY_CONTAINER_NAME = ")
		print_debug_value_newline(${FLAME_PROPERTY_CONTAINER_NAME})

		print_debug_function_oneline("FLAME_REAL_TARGET             = ")
		print_debug_value_newline(${FLAME_REAL_TARGET})

		print_debug_function_oneline("FLAME_ADDING_SOURCES          = ")
		print_debug_value_newline(${FLAME_ADDING_SOURCES})

		print_debug_function_oneline("FLAME_ADDING_OBJECTS          = ")
		print_debug_value_newline(${FLAME_ADDING_OBJECTS})

		print_debug_function_oneline("FLAME_DEPENDENCY_HEADERS      = ")
		print_debug_value_newline(${FLAME_DEPENDENCY_HEADERS})

		print_debug_function_oneline("FLAME_DEPENDENCY_LIBRARIES    = ")
		print_debug_value_newline(${FLAME_DEPENDENCY_LIBRARIES})

		print_debug_function_oneline("FLAME_COMPILE_FLAGS           = ")
		print_debug_value_newline(${FLAME_COMPILE_FLAGS})

		print_debug_function_oneline("FLAME_LINK_FLAGS              = ")
		print_debug_value_newline(${FLAME_LINK_FLAGS})

		print_debug_function_oneline("FLAME_OUTPUT_NAME             = ")
		print_debug_value_newline(${FLAME_OUTPUT_NAME})

		print_debug_function_oneline("FLAME_LIBRARY_ALIASES         = ")
		print_debug_value_newline(${FLAME_LIBRARY_ALIASES})

		print_debug_function_oneline("FLAME_INSTALL_PATH            = ")
		print_debug_value_newline(${FLAME_INSTALL_PATH})

		print_debug_function_newline("-------- PARSE RESULT --------")
	endif()

	add_custom_target(${FLAME_PROPERTY_CONTAINER_NAME})
	set_property(GLOBAL APPEND PROPERTY FLAME_SHARED_TARGETS
		${FLAME_PROPERTY_CONTAINER_NAME}
	)
	set_target_properties(${FLAME_PROPERTY_CONTAINER_NAME}
		PROPERTIES
			FLAME_REAL_TARGET          "${FLAME_REAL_TARGET}"
			FLAME_ADDING_SOURCES       "${FLAME_ADDING_SOURCES}"
			FLAME_ADDING_OBJECTS       "${FLAME_ADDING_OBJECTS}"
			FLAME_DEPENDENCY_HEADERS   "${FLAME_DEPENDENCY_HEADERS}"
			FLAME_DEPENDENCY_LIBRARIES "${FLAME_DEPENDENCY_LIBRARIES}"
			FLAME_COMPILE_FLAGS        "${FLAME_COMPILE_FLAGS}"
			FLAME_OUTPUT_NAME          "${FLAME_OUTPUT_NAME}"
			FLAME_LIBRARY_ALIASES      "${FLAME_LIBRARY_ALIASES}"
			FLAME_INSTALL_PATH         "${FLAME_INSTALL_PATH}"
	)

	end_debug_function()
endfunction(internal_add_shared_target_properties)

# Options:
#   DEBUG -
# Values:
#   PROPERTY_CONTAINER_NAME -
#   REAL_TARGET             -
#   OUTPUT_NAME             -
#   INSTALL_PATH            -
# Lists:
#   ADDING_FILES         -
#   INCLUDE_PATHS        -
#   DEPENDENCY_HEADERS   -
#   DEPENDENCY_LIBRARIES -
#   COMPILE_FLAGS        -
#   LINK_FLAGS           -
function(internal_add_binary_target_properties)
	enable_internal_use()

	set(OPTIONS "DEBUG")
	set(VALUES "PROPERTY_CONTAINER_NAME" "REAL_TARGET" "OUTPUT_NAME" "INSTALL_PATH")
	set(LISTS "ADDING_FILES" "INCLUDE_PATHS" "DEPENDENCY_HEADERS"
		"DEPENDENCY_LIBRARIES" "COMPILE_FLAGS" "LINK_FLAGS")

	cmake_parse_arguments("FLAME" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	start_debug_function(internal_add_binary_target_properties)

	if(FLAME_DEBUG OR (FLAME_CMAKE_DEBUG AND FLAME_CMAKE_DEBUG_SHOW_PARSE_RESULTS))
		print_debug_function_newline("-------- PARSE RESULT --------")

		print_debug_function_oneline("FLAME_PROPERTY_CONTAINER_NAME = ")
		print_debug_value_newline(${FLAME_PROPERTY_CONTAINER_NAME})

		print_debug_function_oneline("FLAME_REAL_TARGET             = ")
		print_debug_value_newline(${FLAME_REAL_TARGET})

		print_debug_function_oneline("FLAME_ADDING_FILES          = ")
		print_debug_value_newline(${FLAME_ADDING_FILES})

		print_debug_function_oneline("FLAME_DEPENDENCY_HEADERS      = ")
		print_debug_value_newline(${FLAME_DEPENDENCY_HEADERS})

		print_debug_function_oneline("FLAME_DEPENDENCY_LIBRARIES    = ")
		print_debug_value_newline(${FLAME_DEPENDENCY_LIBRARIES})

		print_debug_function_oneline("FLAME_COMPILE_FLAGS           = ")
		print_debug_value_newline(${FLAME_COMPILE_FLAGS})

		print_debug_function_oneline("FLAME_LINK_FLAGS              = ")
		print_debug_value_newline(${FLAME_LINK_FLAGS})

		print_debug_function_oneline("FLAME_OUTPUT_NAME             = ")
		print_debug_value_newline(${FLAME_OUTPUT_NAME})

		print_debug_function_oneline("FLAME_INSTALL_PATH            = ")
		print_debug_value_newline(${FLAME_INSTALL_PATH})

		print_debug_function_newline("-------- PARSE RESULT --------")
	endif()

	add_custom_target(${FLAME_PROPERTY_CONTAINER_NAME})
	set_property(GLOBAL APPEND PROPERTY FLAME_BINARY_TARGETS
		${FLAME_PROPERTY_CONTAINER_NAME}
	)
	set_target_properties(${FLAME_PROPERTY_CONTAINER_NAME}
		PROPERTIES
			FLAME_REAL_TARGET          "${FLAME_REAL_TARGET}"
			FLAME_ADDING_FILES         "${FLAME_ADDING_FILES}"
			FLAME_INCLUDE_PATHS        "${FLAME_INCLUDE_PATHS}"
			FLAME_DEPENDENCY_HEADERS   "${FLAME_DEPENDENCY_HEADERS}"
			FLAME_DEPENDENCY_LIBRARIES "${FLAME_DEPENDENCY_LIBRARIES}"
			FLAME_COMPILE_FLAGS        "${FLAME_COMPILE_FLAGS}"
			FLAME_LINK_FLAGS           "${FLAME_LINK_FLAGS}"
			FLAME_OUTPUT_NAME          "${FLAME_OUTPUT_NAME}"
			FLAME_INSTALL_PATH         "${FLAME_INSTALL_PATH}"
	)

	end_debug_function()
endfunction(internal_add_binary_target_properties)

# NAME           -
# TARGET_TYPE    -
# PROPERTY_NAME  -
# PROPERTY_VALUE -
function(internal_target_add_property NAME TARGET_TYPE PROPERTY_NAME PROPERTY_VALUE)
	check_internal_use()
	string(TOUPPER "${TARGET_TYPE}" TARGET_TYPE)
	if (NOT(
			("${TARGET_TYPE}" STREQUAL "HEADER")
			OR ("${TARGET_TYPE}" STREQUAL "OBJECT")
			OR ("${TARGET_TYPE}" STREQUAL "STATIC")
			OR ("${TARGET_TYPE}" STREQUAL "SHARED")
			OR ("${TARGET_TYPE}" STREQUAL "BINARY")
	))
		message_fatal("-- Invalid 'TARGET_TYPE'")
	endif()
endfunction(internal_target_add_property)


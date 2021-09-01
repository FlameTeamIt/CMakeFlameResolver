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

	set(OPTIONS "DEBUG" "NO_DEBUG")
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

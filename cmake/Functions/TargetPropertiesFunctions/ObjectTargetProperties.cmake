# Options:
#   DEBUG                -
#   POSITION_INDEPENDENT -
# Values:
#   PROPERTY_CONTAINER_NAME -
#   REAL_TARGET             -
# Lists:
#   ADDING_FILES       -
#   INCLUDE_PATHS      -
#   DEFINES            -
#   DEPENDENCY_HEADERS -
#   COMPILE_FLAGS      -
#   OBJECT_ALIASES     -
function(internal_add_object_target_properties)
	check_internal_use()

	set(OPTIONS "DEBUG" "NO_DEBUG" "POSITION_INDEPENDENT")
	set(VALUES "PROPERTY_CONTAINER_NAME" "REAL_TARGET")
	set(LISTS "ADDING_FILES" "INCLUDE_PATHS" "DEFINES" "DEPENDENCY_HEADERS" "COMPILE_FLAGS"
		"COMPILE_DIFINITIONS" "OBJECT_ALIASES")

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

		print_debug_function_oneline("FLAME_DEFINES                 = ")
		print_debug_value_newline(${FLAME_DEFINES})

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
			FLAME_DEFINES              "${FLAME_DEFINES}"
			FLAME_DEPENDENCY_HEADERS   "${FLAME_DEPENDENCY_HEADERS}"
			FLAME_COMPILE_FLAGS        "${FLAME_COMPILE_FLAGS}"
			FLAME_POSITION_INDEPENDENT "${FLAME_POSITION_INDEPENDENT}"
			FLAME_OBJECT_ALIASES       "${FLAME_OBJECT_ALIASES}"
	)

	end_debug_function()
endfunction(internal_add_object_target_properties)

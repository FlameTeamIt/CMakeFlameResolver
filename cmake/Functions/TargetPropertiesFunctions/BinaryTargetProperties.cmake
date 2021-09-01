# Options:
#   DEBUG -
#   TEST  -
# Values:
#   PROPERTY_CONTAINER_NAME -
#   REAL_TARGET             -
#   OUTPUT_NAME             -
#   INSTALL_PATH            -
# Lists:
#   ADDING_FILES         -
#   INCLUDE_PATHS        -
#   DEFINES              -
#   DEPENDENCY_HEADERS   -
#   DEPENDENCY_LIBRARIES -
#   COMPILE_FLAGS        -
#   LINK_FLAGS           -
#   TEST_ARGUMENTS       -
function(internal_add_binary_target_properties)
	enable_internal_use()

	set(OPTIONS "DEBUG" "NO_DEBUG" "TEST")
	set(VALUES "PROPERTY_CONTAINER_NAME" "REAL_TARGET" "OUTPUT_NAME" "INSTALL_PATH")
	set(LISTS "ADDING_FILES" "DEFINES" "INCLUDE_PATHS" "DEPENDENCY_HEADERS"
		"DEPENDENCY_LIBRARIES" "COMPILE_FLAGS" "LINK_FLAGS" "TEST_ARGUMENTS")

	cmake_parse_arguments("FLAME" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	start_debug_function(internal_add_binary_target_properties)

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

		print_debug_function_oneline("FLAME_TEST                    = ")
		print_debug_value_newline(${FLAME_TEST})

		print_debug_function_oneline("FLAME_TEST_ARGUMENTS          = ")
		print_debug_value_newline(${FLAME_TEST_ARGUMENTS})

		print_debug_function_newline("-------- PARSE RESULT --------")
	endif()

	add_custom_target(${FLAME_PROPERTY_CONTAINER_NAME})
	set_property(GLOBAL APPEND PROPERTY FLAME_BINARY_TARGETS
		${FLAME_PROPERTY_CONTAINER_NAME}
	)
	if(FLAME_TEST)
		set(TEST TRUE)
	else()
		set(TEST FALSE)
	endif()
	set_target_properties(${FLAME_PROPERTY_CONTAINER_NAME}
		PROPERTIES
			FLAME_REAL_TARGET          "${FLAME_REAL_TARGET}"
			FLAME_ADDING_FILES         "${FLAME_ADDING_FILES}"
			FLAME_INCLUDE_PATHS        "${FLAME_INCLUDE_PATHS}"
			FLAME_DEFINES              "${FLAME_DEFINES}"
			FLAME_DEPENDENCY_HEADERS   "${FLAME_DEPENDENCY_HEADERS}"
			FLAME_DEPENDENCY_LIBRARIES "${FLAME_DEPENDENCY_LIBRARIES}"
			FLAME_COMPILE_FLAGS        "${FLAME_COMPILE_FLAGS}"
			FLAME_LINK_FLAGS           "${FLAME_LINK_FLAGS}"
			FLAME_OUTPUT_NAME          "${FLAME_OUTPUT_NAME}"
			FLAME_INSTALL_PATH         "${FLAME_INSTALL_PATH}"
			FLAME_TEST                 "${TEST}"
			FLAME_TEST_ARGUMENTS       "${FLAME_TEST_ARGUMENTS}"
	)

	end_debug_function()
endfunction(internal_add_binary_target_properties)

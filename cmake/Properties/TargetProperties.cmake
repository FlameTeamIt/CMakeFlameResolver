# ---- header-target -------
# FLAME_REAL_TARGET        #
# FLAME_ADDING_HEADERS     # headers only
# FLAME_INCLUDE_PATHS      #
# FLAME_DEPENDENCY_HEADERS #
# FLAME_LIBRARY_ALIASES    #
# FLAME_INSTALL_PATH       #
# --------------------------

#
#
#
function(internal_add_header_target_properties)
	check_internal_use()

	set(OPTIONS "DEBUG")
	set(VALUES "PROPERTY_CONTAINER_NAME" "REAL_TARGET" "INSTALL_PATH")
	set(LISTS "ADDING_HEADERS" "INCLUDE_PATHS" "DEPENDENCY_HEADERS" "LIBRARY_ALIASES")

	cmake_parse_arguments("FLAME" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	start_debug_function(internal_add_header_target_properties)

	if(FLAME_DEBUG)
		print_debug_function_newline("-------- PARSE RESULT --------")

		print_debug_function_oneline("FLAME_PROPERTY_CONTAINER_NAME = ")
		print_debug_value_newline(${FLAME_PROPERTY_CONTAINER_NAME})

		print_debug_function_oneline("FLAME_REAL_TARGET             = ")
		print_debug_value_newline(${FLAME_REAL_TARGET})

		print_debug_function_oneline("FLAME_ADDING_HEADERS          = ")
		print_debug_value_newline(${FLAME_ADDING_HEADERS})

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
	add_to_global_property(FLAME_HEADER_TARGETS ${FLAME_PROPERTY_CONTAINER_NAME})

	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_REAL_TARGET
		"${FLAME_REAL_TARGET}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_ADDING_HEADERS
		"${FLAME_ADDING_HEADERS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_DEPENDENCY_HEADERS
		"${FLAME_DEPENDENCY_HEADERS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_LIBRARY_ALIASES
		"${FLAME_LIBRARY_ALIASES}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_INSTALL_PATH
		"${FLAME_INSTALL_PATH}")

	end_debug_function()
endfunction(internal_add_header_target_properties)

# ------ object-target -------
# FLAME_REAL_TARGET           #
# FLAME_ADDING_SOURCES        # headers + sources
# FLAME_INCLUDE_PATHS         #
# FLAME_DEPENDENCY_HEADERS    #
# FLAME_COMPILE_FLAGS         #
# FLAME_POSITION_INDEPENDENT  #
# FLAME_OBJECT_ALIASES        #
# ----------------------------

#
#
#
function(internal_add_object_target_properties)
	check_internal_use()

	set(OPTIONS "DEBUG" "POSITION_INDEPENDENT")
	set(VALUES "PROPERTY_CONTAINER_NAME" "REAL_TARGET")
	set(LISTS "ADDING_SOURCES" "INCLUDE_PATHS" "DEPENDENCY_HEADERS" "COMPILE_FLAGS"
		"OBJECT_ALIASES")

	cmake_parse_arguments("FLAME" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	start_debug_function(internal_add_object_target_properties)

	if(FLAME_DEBUG)
		print_debug_function_newline("-------- PARSE RESULT --------")

		print_debug_function_oneline("FLAME_PROPERTY_CONTAINER_NAME = ")
		print_debug_value_newline(${FLAME_PROPERTY_CONTAINER_NAME})

		print_debug_function_oneline("FLAME_REAL_TARGET             = ")
		print_debug_value_newline(${FLAME_REAL_TARGET})

		print_debug_function_oneline("FLAME_ADDING_SOURCES          = ")
		print_debug_value_newline(${FLAME_ADDING_SOURCES})

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
	add_to_global_property(FLAME_OBJECT_TARGETS ${FLAME_PROPERTY_CONTAINER_NAME})

	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_REAL_TARGET
		"${FLAME_REAL_TARGET}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_ADDING_SOURCES
		"${FLAME_ADDING_SOURCES}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_INCLUDE_PATHS
		"${FLAME_INCLUDE_PATHS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_DEPENDENCY_HEADERS
		"${FLAME_DEPENDENCY_HEADERS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_COMPILE_FLAGS
		"${FLAME_COMPILE_FLAGS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_POSITION_INDEPENDENT
		"${FLAME_POSITION_INDEPENDENT}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_OBJECT_ALIASES
		"${FLAME_OBJECT_ALIASES}")

	end_debug_function()
endfunction(internal_add_object_target_properties)

# ---- static-library-target -
# FLAME_REAL_TARGET          #
# FLAME_ADDING_SOURCES       # headers + sources
# FLAME_ADDING_OBJECTS       #
# FLAME_DEPENDENCY_HEADERS   #
# FLAME_DEPENDENCY_LIBRARIES #
# FLAME_COMPILE_FLAGS        # need for adding sources
# FLAME_OUTPUT_NAME          #
# FLAME_LIBRARY_ALIASES      #
# FLAME_INSTALL_PATH         #
# ----------------------------

#
#
#
function(internal_add_static_target_properties)
	check_internal_use()

	set(OPTIONS "DEBUG")
	set(VALUES "PROPERTY_CONTAINER_NAME" "REAL_TARGET" "OUTPUT_NAME" "INSTALL_PATH")
	set(LISTS "ADDING_SOURCES" "ADDING_OBJECTS" "DEPENDENCY_HEADERS"
		"DEPENDENCY_LIBRARIES" "COMPILE_FLAGS" "LIBRARY_ALIASES")

	cmake_parse_arguments("FLAME" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	start_debug_function(internal_add_static_target_properties)

	if(FLAME_DEBUG)
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
	add_to_global_property(FLAME_STATIC_TARGETS ${FLAME_PROPERTY_CONTAINER_NAME})

	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_REAL_TARGET
		"${FLAME_REAL_TARGET}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_ADDING_SOURCES
		"${FLAME_ADDING_SOURCES}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_ADDING_OBJECTS
		"${FLAME_ADDING_OBJECTS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_DEPENDENCY_HEADERS
		"${FLAME_DEPENDENCY_HEADERS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_DEPENDENCY_LIBRARIES
		"${FLAME_DEPENDENCY_LIBRARIES}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_COMPILE_FLAGS
		"${FLAME_COMPILE_FLAGS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_OUTPUT_NAME
		"${FLAME_OUTPUT_NAME}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_LIBRARY_ALIASES
		"${FLAME_LIBRARY_ALIASES}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_INSTALL_PATH
		"${FLAME_INSTALL_PATH}")

	end_debug_function()
endfunction(internal_add_static_target_properties)

# ---- shared-library-target -
# FLAME_REAL_TARGET          #
# FLAME_ADDING_SOURCES       # headers + sources
# FLAME_ADDING_OBJECTS       #
# FLAME_DEPENDENCY_HEADERS   #
# FLAME_DEPENDENCY_LIBRARIES #
# FLAME_COMPILE_FLAGS        # need for adding sources
# FLAME_LINK_FLAGS           #
# FLAME_OUTPUT_NAME          #
# FLAME_LIBRARY_ALIASES      #
# FLAME_INSTALL_PATH         #
# ----------------------------

#
#
#
function(internal_add_shared_target_properties)
	check_internal_use()

	set(OPTIONS "DEBUG")
	set(VALUES "PROPERTY_CONTAINER_NAME" "REAL_TARGET" "OUTPUT_NAME" "INSTALL_PATH")
	set(LISTS "ADDING_SOURCES" "ADDING_OBJECTS" "DEPENDENCY_HEADERS"
		"DEPENDENCY_LIBRARIES" "COMPILE_FLAGS" "LINK_FLAGS" "LIBRARY_ALIASES")

	cmake_parse_arguments("FLAME" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	start_debug_function(internal_add_shared_target_properties)

	if(FLAME_DEBUG)
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
	add_to_global_property(FLAME_SHARED_TARGETS ${FLAME_PROPERTY_CONTAINER_NAME})

	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_REAL_TARGET
		"${FLAME_REAL_TARGET}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_ADDING_SOURCES
		"${FLAME_ADDING_SOURCES}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_ADDING_OBJECTS
		"${FLAME_ADDING_OBJECTS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_DEPENDENCY_HEADERS
		"${FLAME_DEPENDENCY_HEADERS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_DEPENDENCY_LIBRARIES
		"${FLAME_DEPENDENCY_LIBRARIES}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_COMPILE_FLAGS
		"${FLAME_COMPILE_FLAGS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_OUTPUT_NAME
		"${FLAME_OUTPUT_NAME}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_LIBRARY_ALIASES
		"${FLAME_LIBRARY_ALIASES}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_INSTALL_PATH
		"${FLAME_INSTALL_PATH}")

	end_debug_function()
endfunction(internal_add_shared_target_properties)

# ---- binary-target ---------
# FLAME_REAL_TARGET          #
# FLAME_ADDING_HEADERS       #
# FLAME_ADDING_SOURCES       #
# FLAME_INCLUDE_PATHS        #
# FLAME_DEPENDENCY_HEADERS   #
# FLAME_DEPENDENCY_LIBRARIES #
# FLAME_COMPILE_FLAGS        #
# FLAME_LINK_FLAGS           #
# FLAME_OUTPUT_NAME          #
# FLAME_INSTALL_PATH         #
# ----------------------------

#
#
#
function(internal_add_binary_target_properties)
	enable_internal_use()

	set(OPTIONS "DEBUG")
	set(VALUES "PROPERTY_CONTAINER_NAME" "REAL_TARGET" "OUTPUT_NAME" "INSTALL_PATH")
	set(LISTS "ADDING_HEADERS" "ADDING_SOURCES" "INCLUDE_PATHS" "DEPENDENCY_HEADERS"
		"DEPENDENCY_LIBRARIES" "COMPILE_FLAGS" "LINK_FLAGS" )

	cmake_parse_arguments("FLAME" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	start_debug_function(internal_add_binary_target_properties)

	if(FLAME_DEBUG)
		print_debug_function_newline("-------- PARSE RESULT --------")

		print_debug_function_oneline("FLAME_PROPERTY_CONTAINER_NAME = ")
		print_debug_value_newline(${FLAME_PROPERTY_CONTAINER_NAME})

		print_debug_function_oneline("FLAME_REAL_TARGET             = ")
		print_debug_value_newline(${FLAME_REAL_TARGET})

		print_debug_function_oneline("FLAME_ADDING_SOURCES          = ")
		print_debug_value_newline(${FLAME_ADDING_SOURCES})

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
	add_to_global_property(FLAME_BINARY_TARGETS ${FLAME_PROPERTY_CONTAINER_NAME})

	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_REAL_TARGET
		"${FLAME_REAL_TARGET}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_ADDING_HEADERS
		"${FLAME_ADDING_HEADERS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_ADDING_SOURCES
		"${FLAME_ADDING_SOURCES}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_INCLUDE_PATHS
		"${FLAME_INCLUDE_PATHS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_DEPENDENCY_HEADERS
		"${FLAME_DEPENDENCY_HEADERS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_DEPENDENCY_LIBRARIES
		"${FLAME_DEPENDENCY_LIBRARIES}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_COMPILE_FLAGS
		"${FLAME_COMPILE_FLAGS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_LINK_FLAGS
		"${FLAME_LINK_FLAGS}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_OUTPUT_NAME
		"${FLAME_OUTPUT_NAME}")
	target_property_set(${FLAME_PROPERTY_CONTAINER_NAME} FLAME_INSTALL_PATH
		"${FLAME_INSTALL_PATH}")

	end_debug_function()
endfunction(internal_add_binary_target_properties)

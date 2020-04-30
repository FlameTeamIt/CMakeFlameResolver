#
#
#
function(internal_resolve_headers)
	check_internal_use()

	start_debug_function(internal_resolve_headers)

	get_global_property(FLAME_HEADER_TARGETS HEADER_TARGETS)

	foreach(target.property ${HEADER_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)

		print_oneline("-- Header library ${REAL_TARGET} - ")

		target_property_get(${target.property} FLAME_ADDING_HEADERS
			HEADER_LIST)
		add_library(${REAL_TARGET} INTERFACE)
		target_sources(${REAL_TARGET} INTERFACE "$<BUILD_INTERFACE:${HEADER_LIST}>")

		target_property_get(${target.property} FLAME_INCLUDE_PATHS
			INCLUDE_PATHS)
		if(INCLUDE_PATHS)
			target_include_directories(${REAL_TARGET} INTERFACE ${INCLUDE_PATHS})
		endif()

		target_property_get(${target.property} FLAME_LIBRARY_ALIASES
			LIBRARY_ALIASES)
		if(LIBRARY_ALIASES)
			foreach(alias ${LIBRARY_ALIASES})
				add_library(${alias} ALIAS ${REAL_TARGET})
			endforeach()
		endif()

		print_newline("done")
	endforeach()

	foreach(target.property ${HEADER_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)

		target_property_get(${target.property} FLAME_DEPENDENCY_HEADERS
			DEPENDENCY_LIST)
		if(DEPENDENCY_LIST)
			print_oneline("-- Dependencies for header library ${REAL_TARGET} - ")

			target_link_libraries(${REAL_TARGET} INTERFACE ${DEPENDENCY_LIST})

			print_newline("done")
		endif()
	endforeach()

	end_debug_function()
endfunction(internal_resolve_headers)

#
#
#
function(internal_resolve_object_libraries)
	start_debug_function(internal_resolve_object_libraries)

	get_global_property(FLAME_OBJECT_TARGETS OBJECT_TARGETS)
	foreach(target.property ${OBJECT_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)

		print_oneline("-- Object library ${REAL_TARGET} - ")

		target_property_get(${target.property} FLAME_ADDING_SOURCES
			SOURCE_LIST)
		if(NOT SOURCE_LIST)
			print_newline("fail")
		endif()
		add_library(${REAL_TARGET} OBJECT ${SOURCE_LIST})

		target_property_get(${target.property} FLAME_OBJECT_ALIASES
			OBJECT_ALIASES)
		if(OBJECT_ALIASES)
			foreach(alias ${OBJECT_ALIASES})
				add_library(${alias} ALIAS ${REAL_TARGET})
			endforeach()
		endif()

		target_property_get(${target.property} FLAME_INCLUDE_PATHS
			INCLUDE_PATHS)
		if(INCLUDE_PATHS)
			target_include_directories(${REAL_TARGET} PUBLIC ${INCLUDE_PATHS})
		endif()

		target_property_get(${target.property} FLAME_POSITION_INDEPENDENT
			POSITION_INDEPENDENT)
		if(POSITION_INDEPENDENT)
			set_property(TARGET ${REAL_TARGET} PROPERTY
				POSITION_INDEPENDENT_CODE ${POSITION_INDEPENDENT})
		endif()

		target_property_get(${target.property} FLAME_DEPENDENCY_HEADERS
			HEADER_DEPENDENCIES)
		if(HEADER_DEPENDENCIES)
			target_link_libraries(${REAL_TARGET} PUBLIC ${dependency})
		endif()

		# Not supported now
		#target_property_get(${target.property} FLAME_COMPILE_FLAGS
		#	COMPILE_FLAGS)

		print_newline("done")
	endforeach()

	end_debug_function()
endfunction(internal_resolve_object_libraries)

#
#
#
function(internal_resolve_static_libraries)
	start_debug_function(internal_resolve_static_libraries)

	get_global_property(FLAME_STATIC_TARGETS STATIC_TARGETS)
	foreach(target.property ${STATIC_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)

		print_oneline("-- Static library ${REAL_TARGET} - ")

		target_property_get(${target.property} FLAME_ADDING_SOURCES
			SOURCE_LIST)

		target_property_get(${target.property} FLAME_ADDING_OBJECTS
			OBJECT_TARGETS)
		if(OBJECT_TARGETS)
			foreach(target ${OBJECT_TARGETS})
				list(APPEND SOURCE_LIST $<TARGET_OBJECTS:${target}>)
			endforeach()
		endif()
		if((NOT SOURCE_LIST) AND (NOT OBJECT_TARGETS))
			print_newline("fail")
		endif()
		add_library(${REAL_TARGET} STATIC ${SOURCE_LIST})

		target_property_get(${target.property} FLAME_LIBRARY_ALIASES
			LIBRARY_ALIASES)
		if(LIBRARY_ALIASES)
			foreach(alias ${LIBRARY_ALIASES})
				add_library(${alias} ALIAS ${REAL_TARGET})
			endforeach()
		endif()

		target_property_get(${target.property} FLAME_DEPENDENCY_HEADERS
			HEADER_TARGETS)
		if(HEADER_TARGETS)
			target_link_libraries(${REAL_TARGET} PUBLIC ${HEADER_TARGETS})
		endif()

		# Not supported now
		#target_property_get(${target.property} FLAME_COMPILE_FLAGS
		#	COMPILE_FLAGS)

		target_property_get(${target.property} FLAME_OUTPUT_NAME
			OUTPUT_NAME)
		if(OUTPUT_NAME)
			set_target_properties(${REAL_TARGET} PROPERTIES
				OUTPUT_NAME "${OUTPUT_NAME}")
		endif()

		# Not supported now
		#target_property_get(${target.property} FLAME_INSTALL_PATH
		#	INSTALL_PATH)

		print_newline("done")
	endforeach()

	foreach(target.property ${STATIC_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_DEPENDENCY_LIBRARIES
			LIBRARY_TARGETS)

		if(LIBRARY_TARGETS)
			print_oneline("-- "
				"Compiled dependencies for static library ${REAL_TARGET} - ")

			target_link_libraries(${REAL_TARGET} PUBLIC ${LIBRARY_TARGETS})

			print_newline("done")
		endif()
	endforeach()

	end_debug_function()
endfunction(internal_resolve_static_libraries)

#
#
#
function(internal_resolve_shared_libraries)
	start_debug_function(internal_resolve_shared_libraries)

	get_global_property(FLAME_SHARED_TARGETS SHARED_TARGETS)
	foreach(target.property ${SHARED_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)

		print_oneline("-- Shared library ${REAL_TARGET} - ")

		target_property_get(${target.property} FLAME_ADDING_SOURCES
			SOURCE_LIST)

		target_property_get(${target.property} FLAME_ADDING_OBJECTS
			OBJECT_TARGETS)
		if(OBJECT_TARGETS)
			foreach(target ${OBJECT_TARGETS})
				list(APPEND SOURCE_LIST $<TARGET_OBJECTS:${target}>)
			endforeach()
		endif()
		if((NOT SOURCE_LIST) AND (NOT OBJECT_TARGETS))
			print_newline("fail")
		endif()
		add_library(${REAL_TARGET} SHARED ${SOURCE_LIST})

		target_property_get(${target.property} FLAME_LIBRARY_ALIASES
			LIBRARY_ALIASES)
		if(LIBRARY_ALIASES)
			foreach(alias ${LIBRARY_ALIASES})
				add_library(${alias} ALIAS ${REAL_TARGET})
			endforeach()
		endif()

		target_property_get(${target.property} FLAME_DEPENDENCY_HEADERS
			HEADER_TARGETS)
		if(HEADER_TARGETS)
			target_link_libraries(${REAL_TARGET} PUBLIC ${HEADER_TARGETS})
		endif()

		# Not supported now
		#target_property_get(${target.property} FLAME_COMPILE_FLAGS
		#	COMPILE_FLAGS)

		# Not supported now
		#target_property_get(${target.property} FLAME_LINK_FLAGS
		#	LINK_FLAGS)

		target_property_get(${target.property} FLAME_OUTPUT_NAME
			OUTPUT_NAME)
		if(OUTPUT_NAME)
			set_target_properties(${REAL_TARGET} PROPERTIES
				OUTPUT_NAME "${OUTPUT_NAME}")
		endif()

		print_newline("done")
	endforeach()

	foreach(target.property ${SHARED_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)

		target_property_get(${target.property} FLAME_DEPENDENCY_LIBRARIES
			LIBRARY_TARGETS)
		if(LIBRARY_TARGETS)
			print_oneline("-- "
				"Compiled dependencies for shared library ${REAL_TARGET} - ")

			if(LIBRARY_TARGETS)
				foreach(target ${LIBRARY_TARGETS})
					target_link_libraries(${REAL_TARGET} PUBLIC ${target})
				endforeach()
			endif()

			print_newline("done")
		endif()
	endforeach()

	end_debug_function()
endfunction(internal_resolve_shared_libraries)

#
#
#
function(internal_resolve_binaries)
	check_internal_use()

	start_debug_function(internal_resolve_binaries)

	get_global_property(FLAME_BINARY_TARGETS BINARY_TARGETS)
	foreach(target.property ${BINARY_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)

		print_oneline("-- Binary ${REAL_TARGET} - ")

		target_property_get(${target.property} FLAME_ADDING_SOURCES
			SOURCE_LIST)
		if(SOURCE_LIST)
			list(APPEND SOURCE_LIST ${ADDING_SOURCES})
		else()
			print_newline("fail")
		endif()
		add_executable(${REAL_TARGET} ${SOURCE_LIST})

		target_property_get(${target.property} FLAME_INCLUDE_PATHS
			INCLUDE_PATHS)
		if(INCLUDE_PATHS)
			target_include_directories(${REAL_TARGET} PUBLIC ${INCLUDE_PATHS})
		endif()

		target_property_get(${target.property} FLAME_DEPENDENCY_LIBRARIES
			DEPENDENCY_LIBRARIES)
		if(DEPENDENCY_LIBRARIES)
			target_link_libraries(${REAL_TARGET} PUBLIC ${DEPENDENCY_LIBRARIES})
		endif()

		target_property_get(${target.property} FLAME_DEPENDENCY_HEADERS
			DEPENDENCY_HEADERS)
		if(DEPENDENCY_HEADERS)
			target_link_libraries(${REAL_TARGET} PUBLIC ${DEPENDENCY_HEADERS})
		endif()

		# Not supported now
		#target_property_get(${target.property} FLAME_COMPILE_FLAGS
		#	COMPILE_FLAGS)

		# Not supported now
		#target_property_get(${target.property} FLAME_LINK_FLAGS
		#	LINK_FLAGS)

		target_property_get(${target.property} FLAME_OUTPUT_NAME
			OUTPUT_NAME)
		if(OUTPUT_NAME)
			set_target_properties(${REAL_TARGET} PROPERTIES
				OUTPUT_NAME "${OUTPUT_NAME}")
		endif()

		# Not supported now
		#target_property_get(${target.property} FLAME_INSTALL_PATH
		#	INSTALL_PATH)

		target_property_get(${target.property} FLAME_BINARY_ALIASES
			BINARY_ALIASES)
		if(BINARY_ALIASES)
			foreach(alias ${BINARY_ALIASES})
				add_executable(${alias} ALIAS ${REAL_TARGET})
			endforeach()
		endif()

		print_newline("done")
	endforeach()

	end_debug_function()
endfunction(internal_resolve_binaries)

#
#
#
function(internal_clean_global_properties)
	check_internal_use()

	set_global_property(FLAME_HEADER_TARGETS "")
	set_global_property(FLAME_OBJECT_TARGETS "")
	set_global_property(FLAME_STATIC_TARGETS "")
	set_global_property(FLAME_SHARED_TARGETS "")
	set_global_property(FLAME_BINARY_TARGETS "")
endfunction(internal_clean_global_properties)

#
#
#
function(resolve_dependencies)
	enable_internal_use()

	message("-- Start resolving")

	internal_resolve_headers()

	internal_resolve_object_libraries()
	internal_resolve_static_libraries()
	internal_resolve_shared_libraries()

	internal_resolve_binaries()

	internal_clean_global_properties()

	message("-- Resolve finished")
endfunction(resolve_dependencies)

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
		target_property_get(${target.property} FLAME_ADDING_HEADERS
			HEADER_LIST)
		target_property_get(${target.property} FLAME_INCLUDE_PATHS
			INCLUDE_PATHS)
		target_property_get(${target.property} FLAME_LIBRARY_ALIASES
			LIBRARY_ALIASES)

		print_oneline("-- Header library ${REAL_TARGET} - ")

		add_library(${REAL_TARGET} INTERFACE)
		target_sources(${REAL_TARGET} INTERFACE "$<BUILD_INTERFACE:${HEADER_LIST}>")
		if(INCLUDE_PATHS)
			target_include_directories(${REAL_TARGET} INTERFACE ${INCLUDE_PATHS})
		endif()
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

			foreach(dependency ${DEPENDENCY_LIST})
				target_link_libraries(${REAL_TARGET} INTERFACE ${dependency})
			endforeach()

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
		target_property_get(${target.property} FLAME_ADDING_SOURCES
			SOURCE_LIST)

		print_oneline("-- Object library ${REAL_TARGET} - ")
		if(NOT SOURCE_LIST)
			print_newline("Fail")
		endif()
		add_library(${REAL_TARGET} OBJECT ${SOURCE_LIST})
		print_newline("done")
	endforeach()

	foreach(target.property ${OBJECT_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_OBJECT_ALIASES
			OBJECT_ALIASES)

		if(OBJECT_ALIASES)
			print_oneline("-- Make aliases for object library ${REAL_TARGET} - ")

			foreach(alias ${OBJECT_ALIASES})
				add_library(${alias} ALIAS ${REAL_TARGET})
			endforeach()

			print_newline("done")
		endif()
	endforeach()

	foreach(target.property ${OBJECT_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_INCLUDE_PATHS
			INCLUDE_PATHS)

		if(INCLUDE_PATHS)
			print_oneline("-- "
				"Set include paths for object library ${REAL_TARGET} - ")

			target_include_directories(${REAL_TARGET} PUBLIC ${INCLUDE_PATHS})

			print_newline("done")
		endif()
	endforeach()

	# Not support now
	#foreach(target.property ${OBJECT_TARGETS})
	#	target_property_get(${target.property} FLAME_REAL_TARGET
	#		REAL_TARGET)
	#	target_property_get(${target.property} FLAME_COMPILE_FLAGS
	#		COMPILE_FLAGS)
	#endforeach()

	foreach(target.property ${OBJECT_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_POSITION_INDEPEND
			POSITION_INDEPEND)

		if(POSITION_INDEPEND)
			print_oneline("-- "
				"Position independ code for object library ${REAL_TARGET} - ")

			set_property(TARGET ${REAL_TARGET} PROPERTY
				POSITION_INDEPENDENT_CODE ${POSITION_INDEPEND})

			print_newline("done")
		endif()
	endforeach()

	foreach(target.property ${OBJECT_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_DEPENDENCY_HEADERS
			HEADER_DEPENDENCIES)

		if(HEADER_DEPENDENCIES)
			print_oneline("-- Header dependencies for object library ${REAL_TARGET} - ")

			foreach(dependency ${HEADER_DEPENDENCIES})
				target_link_libraries(${REAL_TARGET} PUBLIC ${dependency})
			endforeach()

			print_newline("done")
		endif()
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
		target_property_get(${target.property} FLAME_ADDING_SOURCES
			SOURCE_LIST)
		target_property_get(${target.property} FLAME_ADDING_OBJECTS
			OBJECT_TARGETS)

		print_oneline("-- Static library ${REAL_TARGET} - ")

		set(SOURCES)
		if(SOURCE_LIST)
			set(SOURCES ${SOURCE_LIST})
		endif()
		if(OBJECT_TARGETS)
			foreach(target ${OBJECT_TARGETS})
				list(APPEND SOURCES $<TARGET_OBJECTS:${target}>)
			endforeach()
		endif()
		if((NOT SOURCE_LIST) AND (NOT OBJECT_TARGETS))
			print_newline("Fail")
		endif()

		add_library(${REAL_TARGET} STATIC ${SOURCES})

		print_newline("done")
	endforeach()

	foreach(target.property ${STATIC_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_LIBRARY_ALIASES
			LIBRARY_ALIASES)

		if(LIBRARY_ALIASES)
			print_oneline("-- "
				"Aliases for static library ${REAL_TARGET} - ")

			foreach(alias ${LIBRARY_ALIASES})
				add_library(${alias} ALIAS ${REAL_TARGET})
			endforeach()

			print_newline("done")
		endif()
	endforeach()


	foreach(target.property ${STATIC_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_DEPENDENCY_HEADERS
			HEADER_TARGETS)

		if(HEADER_TARGETS)
			print_oneline("-- "
				"Header dependencies for static library ${REAL_TARGET} - ")

			foreach(target ${HEADER_TARGETS})
				target_link_libraries(${REAL_TARGET} PUBLIC ${target})
			endforeach()

			print_newline("done")
		endif()
	endforeach()

	# Not support now
	#foreach(target.property ${STATIC_TARGETS})
	#	target_property_get(${target.property} FLAME_REAL_TARGET
	#		REAL_TARGET)
	#	target_property_get(${target.property} FLAME_COMPILE_FLAGS
	#		COMPILE_FLAGS)
	#endforeach()

	foreach(target.property ${STATIC_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_OUTPUT_NAME
			OUTPUT_NAME)

		if(OUTPUT_NAME)
			print_oneline("-- "
				"Output name for static library ${REAL_TARGET} - ")

			set_target_properties(${REAL_TARGET} PROPERTIES
				OUTPUT_NAME "${OUTPUT_NAME}")

			print_newline("done")
		endif()
	endforeach()

	# Not support now
	#foreach(target.property ${STATIC_TARGETS})
	#	target_property_get(${target.property} FLAME_REAL_TARGET
	#		REAL_TARGET)
	#	target_property_get(${target.property} FLAME_INSTALL_PATH
	#		INSTALL_PATH)
	#endforeach()

	foreach(target.property ${STATIC_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_DEPENDENCY_LIBRARIES
			LIBRARY_TARGETS)

		if(LIBRARY_TARGETS)
			print_oneline("-- "
				"Compiled dependencies for static library ${REAL_TARGET} - ")

			if(LIBRARY_TARGETS)
				foreach(target ${LIBRARY_TARGETS})
					target_link_libraries(${REAL_TARGET} PUBLIC ${target})
				endforeach()
			endif()

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
		target_property_get(${target.property} FLAME_ADDING_SOURCES
			SOURCE_LIST)
		target_property_get(${target.property} FLAME_ADDING_OBJECTS
			OBJECT_TARGETS)

		print_oneline("-- Shared library ${REAL_TARGET} - ")

		set(SOURCES)
		if(SOURCE_LIST)
			set(SOURCES ${SOURCE_LIST})
		endif()
		if(OBJECT_TARGETS)
			foreach(target ${OBJECT_TARGETS})
				list(APPEND SOURCES $<TARGET_OBJECTS:${target}>)
			endforeach()
		endif()
		if((NOT SOURCE_LIST) AND (NOT OBJECT_TARGETS))
			print_newline("Fail")
		endif()

		add_library(${REAL_TARGET} SHARED ${SOURCES})

		print_newline("done")
	endforeach()

	foreach(target.property ${SHARED_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_LIBRARY_ALIASES
			LIBRARY_ALIASES)

		if(LIBRARY_ALIASES)
			print_oneline("-- "
				"Aliases for shared library ${REAL_TARGET} - ")

			foreach(alias ${LIBRARY_ALIASES})
				add_library(${alias} ALIAS ${REAL_TARGET})
			endforeach()

			print_newline("done")
		endif()
	endforeach()

	foreach(target.property ${SHARED_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_DEPENDENCY_HEADERS
			HEADER_TARGETS)

		if(HEADER_TARGETS)
			print_oneline("-- "
				"Header dependencies for static library ${REAL_TARGET} - ")

			foreach(target ${HEADER_TARGETS})
				target_link_libraries(${REAL_TARGET} PUBLIC ${target})
			endforeach()

			print_newline("done")
		endif()
	endforeach()

	# Not support now
	#foreach(target.property ${SHARED_TARGETS})
	#	target_property_get(${target.property} FLAME_REAL_TARGET
	#		REAL_TARGET)
	#	target_property_get(${target.property} FLAME_COMPILE_FLAGS
	#		COMPILE_FLAGS)
	#endforeach()

	# Not support now
	#foreach(target.property ${SHARED_TARGETS})
	#	target_property_get(${target.property} FLAME_REAL_TARGET
	#		REAL_TARGET)
	#	target_property_get(${target.property} FLAME_LINK_FLAGS
	#		LINK_FLAGS)
	#endforeach()

	foreach(target.property ${SHARED_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_OUTPUT_NAME
			OUTPUT_NAME)

		if(OUTPUT_NAME)
			print_oneline("-- "
				"Output name for shared library ${REAL_TARGET} - ")

			set_target_properties(${REAL_TARGET} PROPERTIES
				OUTPUT_NAME "${OUTPUT_NAME}")

			print_newline("done")
		endif()
	endforeach()

	# Not support now
	#foreach(target.property ${SHARED_TARGETS})
	#	target_property_get(${target.property} FLAME_REAL_TARGET
	#		REAL_TARGET)
	#	target_property_get(${target.property} FLAME_INSTALL_PATH
	#		INSTALL_PATH)
	#endforeach()

	foreach(target.property ${SHARED_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_DEPENDENCY_LIBRARIES
			LIBRARY_TARGETS)

		if(LIBRARY_TARGETS)
			print_oneline("-- "
				"Dependencies for shared library ${REAL_TARGET} - ")

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
		target_property_get(${target.property} FLAME_ADDING_SOURCES
			ADDING_SOURCES)
		target_property_get(${target.property} FLAME_ADDING_HEADERS
			ADDING_HEADERS)

		print_oneline("-- Binary ${REAL_TARGET} - ")

		set(SOURCE_LIST)
		if(ADDING_SOURCES)
			list(APPEND SOURCE_LIST ${ADDING_SOURCES})
		else()
			print_newline("fail")
		endif()
		if(ADDING_HEADERS)
			list(APPEND SOURCE_LIST ${ADDING_HEADERS})
		endif()

		add_executable(${REAL_TARGET} ${SOURCE_LIST})

		print_newline("done")
	endforeach()

	foreach(target.property ${BINARY_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_INCLUDE_PATHS
			INCLUDE_PATHS)

		if(INCLUDE_PATHS)
			print_oneline("-- Include paths for binary ${REAL_TARGET} - ")

			target_include_directories(${REAL_TARGET} PUBLIC ${INCLUDE_PATHS})

			print_newline("done")
		endif()
	endforeach()


	foreach(target.property ${BINARY_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_DEPENDENCY_LIBRARIES
			DEPENDENCY_LIBRARIES)

		if(DEPENDENCY_LIBRARIES)
			print_oneline("-- "
				"Dependency libraries for binary ${REAL_TARGET} - ")

			foreach(target ${DEPENDENCY_LIBRARIES})
				target_link_libraries(${REAL_TARGET} PUBLIC ${target})
			endforeach()

			print_newline("done")
		endif()
	endforeach()

	foreach(target.property ${BINARY_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_DEPENDENCY_HEADERS
			DEPENDENCY_HEADERS)

		if(DEPENDENCY_HEADERS)
			print_oneline("-- "
				"Header libraries for binary ${REAL_TARGET} - ")

			foreach(target ${DEPENDENCY_HEADERS})
				target_link_libraries(${REAL_TARGET} PUBLIC ${target})
			endforeach()

			print_newline("done")
		endif()
	endforeach()

	# Not support now
	#foreach(target.property ${BINARY_TARGETS})
	#	target_property_get(${target.property} FLAME_REAL_TARGET
	#		REAL_TARGET)
	#	target_property_get(${target.property} FLAME_COMPILE_FLAGS
	#		COMPILE_FLAGS)
	#endforeach()

	# Not support now
	#foreach(target.property ${BINARY_TARGETS})
	#	target_property_get(${target.property} FLAME_REAL_TARGET
	#		REAL_TARGET)
	#	target_property_get(${target.property} FLAME_LINK_FLAGS
	#		LINK_FLAGS)
	#endforeach()

	foreach(target.property ${BINARY_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_OUTPUT_NAME
			OUTPUT_NAME)

		if(OUTPUT_NAME)
			print_oneline("-- "
				"Output name for binary ${REAL_TARGET} - ")

			set_target_properties(${REAL_TARGET} PROPERTIES
				OUTPUT_NAME "${OUTPUT_NAME}")

			print_newline("done")
		endif()
	endforeach()

	# Not support now
	#foreach(target.property ${BINARY_TARGETS})
	#	target_property_get(${target.property} FLAME_REAL_TARGET
	#		REAL_TARGET)
	#	target_property_get(${target.property} FLAME_INSTALL_PATH
	#		INSTALL_PATH)
	#endforeach()

	foreach(target.property ${BINARY_TARGETS})
		target_property_get(${target.property} FLAME_REAL_TARGET
			REAL_TARGET)
		target_property_get(${target.property} FLAME_BINARY_ALIASES
			BINARY_ALIASES)

		if(BINARY_ALIASES)
			print_oneline("-- "
				"Aliases for binary ${REAL_TARGET} - ")

			foreach(alias ${BINARY_ALIASES})
				add_executable(${alias} ALIAS ${REAL_TARGET})
			endforeach()

			print_newline("done")
		endif()
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

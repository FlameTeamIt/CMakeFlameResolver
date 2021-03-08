#
#
#
function(internal_resolve_headers)
	check_internal_use()

	start_debug_function(internal_resolve_headers)

	get_property(HEADER_TARGETS GLOBAL PROPERTY FLAME_HEADER_TARGETS)
	foreach(target.property ${HEADER_TARGETS})
		get_target_property(REAL_TARGET ${target.property} FLAME_REAL_TARGET)

		print_oneline("-- Header library ${REAL_TARGET} - ")

		get_target_property(HEADER_LIST ${target.property} FLAME_ADDING_FILES)
		add_library(${REAL_TARGET} INTERFACE)
		target_sources(${REAL_TARGET} INTERFACE "$<BUILD_INTERFACE:${HEADER_LIST}>")

		get_target_property(INCLUDE_PATHS ${target.property} FLAME_INCLUDE_PATHS)
		if(INCLUDE_PATHS)
			target_include_directories(${REAL_TARGET} INTERFACE ${INCLUDE_PATHS})
		endif()

		get_target_property(LIBRARY_ALIASES ${target.property} FLAME_LIBRARY_ALIASES)
		if(LIBRARY_ALIASES)
			foreach(alias ${LIBRARY_ALIASES})
				add_library(${alias} ALIAS ${REAL_TARGET})
			endforeach()
		endif()

		# Not supported now
		#get_target_property(INSTALL_PATH ${target.property} FLAME_INSTALL_PATH)

		print_newline("done")
	endforeach()

	foreach(target.property ${HEADER_TARGETS})
		get_target_property(REAL_TARGET ${target.property} FLAME_REAL_TARGET)
		get_target_property(DEPENDENCY_LIST ${target.property} FLAME_DEPENDENCY_HEADERS)
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

	get_property(OBJECT_TARGETS GLOBAL PROPERTY FLAME_OBJECT_TARGETS)
	foreach(target.property ${OBJECT_TARGETS})
		get_target_property(REAL_TARGET ${target.property} FLAME_REAL_TARGET)

		print_oneline("-- Object library ${REAL_TARGET} - ")

		get_target_property(SOURCE_LIST ${target.property} FLAME_ADDING_FILES)
		if(NOT SOURCE_LIST)
			print_newline("fail")
		endif()
		add_library(${REAL_TARGET} OBJECT ${SOURCE_LIST})

		get_target_property(OBJECT_ALIASES ${target.property} FLAME_OBJECT_ALIASES)
		if(OBJECT_ALIASES)
			foreach(alias ${OBJECT_ALIASES})
				add_library(${alias} ALIAS ${REAL_TARGET})
			endforeach()
		endif()

		get_target_property(INCLUDE_PATHS ${target.property} FLAME_INCLUDE_PATHS)
		if(INCLUDE_PATHS)
			target_include_directories(${REAL_TARGET} PUBLIC ${INCLUDE_PATHS})
		endif()

		get_target_property(POSITION_INDEPENDENT ${target.property} FLAME_POSITION_INDEPENDENT)
		if(POSITION_INDEPENDENT)
			set_property(TARGET ${REAL_TARGET} PROPERTY
				POSITION_INDEPENDENT_CODE ${POSITION_INDEPENDENT})
		endif()

		get_target_property(HEADER_DEPENDENCIES ${target.property} FLAME_DEPENDENCY_HEADERS)
		if(HEADER_DEPENDENCIES)
			target_link_libraries(${REAL_TARGET} PUBLIC ${dependency})
		endif()

		get_target_property(COMPILE_FLAGS ${target.property} FLAME_COMPILE_FLAGS)
		if(COMPILE_FLAGS)
			foreach(flag ${COMPILE_FLAGS})
				target_compile_options(${REAL_TARGET} PUBLIC ${flag})
			endforeach()
		endif()

		print_newline("done")
	endforeach()

	end_debug_function()
endfunction(internal_resolve_object_libraries)

#
#
#
function(internal_resolve_static_libraries)
	start_debug_function(internal_resolve_static_libraries)

	get_property(STATIC_TARGETS GLOBAL PROPERTY FLAME_STATIC_TARGETS)
	foreach(target.property ${STATIC_TARGETS})
		get_target_property(REAL_TARGET ${target.property} FLAME_REAL_TARGET)

		print_oneline("-- Static library ${REAL_TARGET} - ")

		get_target_property(SOURCE_LIST ${target.property} FLAME_ADDING_SOURCES)
		get_target_property(OBJECT_TARGETS ${target.property} FLAME_ADDING_OBJECTS)
		if(OBJECT_TARGETS)
			foreach(target ${OBJECT_TARGETS})
				list(APPEND SOURCE_LIST $<TARGET_OBJECTS:${target}>)
			endforeach()
		endif()
		if((NOT SOURCE_LIST) AND (NOT OBJECT_TARGETS))
			print_newline("fail")
		endif()
		add_library(${REAL_TARGET} STATIC ${SOURCE_LIST})

		get_target_property(LIBRARY_ALIASES ${target.property} FLAME_LIBRARY_ALIASES)
		if(LIBRARY_ALIASES)
			foreach(alias ${LIBRARY_ALIASES})
				add_library(${alias} ALIAS ${REAL_TARGET})
			endforeach()
		endif()

		get_target_property(HEADER_TARGETS ${target.property} FLAME_DEPENDENCY_HEADERS)
		if(HEADER_TARGETS)
			target_link_libraries(${REAL_TARGET} PUBLIC ${HEADER_TARGETS})
		endif()

		# Not supported now
		#get_target_property(COMPILE_FLAGS ${target.property} FLAME_COMPILE_FLAGS)

		get_target_property(OUTPUT_NAME ${target.property} FLAME_OUTPUT_NAME)
		if(OUTPUT_NAME)
			set_target_properties(${REAL_TARGET} PROPERTIES
				OUTPUT_NAME "${OUTPUT_NAME}")
		endif()

		# Not supported now
		#get_target_property(INSTALL_PATH ${target.property} FLAME_INSTALL_PATH)

		print_newline("done")
	endforeach()

	foreach(target.property ${STATIC_TARGETS})
		get_target_property(REAL_TARGET ${target.property} FLAME_REAL_TARGET)
		get_target_property(LIBRARY_TARGETS ${target.property} FLAME_DEPENDENCY_LIBRARIES)
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

	get_property(SHARED_TARGETS GLOBAL PROPERTY FLAME_SHARED_TARGETS)
	foreach(target.property ${SHARED_TARGETS})
		get_target_property(REAL_TARGET ${target.property} FLAME_REAL_TARGET)

		print_oneline("-- Shared library ${REAL_TARGET} - ")

		get_target_property(SOURCE_LIST ${target.property} FLAME_ADDING_SOURCES)
		get_target_property(OBJECT_TARGETS ${target.property} FLAME_ADDING_OBJECTS)
		if(OBJECT_TARGETS)
			foreach(target ${OBJECT_TARGETS})
				list(APPEND SOURCE_LIST $<TARGET_OBJECTS:${target}>)
			endforeach()
		endif()
		if((NOT SOURCE_LIST) AND (NOT OBJECT_TARGETS))
			print_newline("fail")
		endif()
		add_library(${REAL_TARGET} SHARED ${SOURCE_LIST})

		get_target_property(LIBRARY_ALIASES ${target.property} FLAME_LIBRARY_ALIASES)
		if(LIBRARY_ALIASES)
			foreach(alias ${LIBRARY_ALIASES})
				add_library(${alias} ALIAS ${REAL_TARGET})
			endforeach()
		endif()

		get_target_property(HEADER_TARGETS ${target.property} FLAME_DEPENDENCY_HEADERS)
		if(HEADER_TARGETS)
			target_link_libraries(${REAL_TARGET} PUBLIC ${HEADER_TARGETS})
		endif()

		# Not supported now
		#get_target_property(COMPILE_FLAGS ${target.property} FLAME_COMPILE_FLAGS)

		# Not supported now
		#get_target_property(LINK_FLAGS ${target.property} FLAME_LINK_FLAGS)

		get_target_property(OUTPUT_NAME ${target.property} FLAME_OUTPUT_NAME)
		if(OUTPUT_NAME)
			set_target_properties(${REAL_TARGET} PROPERTIES
				OUTPUT_NAME "${OUTPUT_NAME}")
		endif()

		if(FLAME_IMPLIB_LIBRARY_SUFFIX)
			set_target_properties(${REAL_TARGET} PROPERTIES
				IMPORT_SUFFIX "${FLAME_IMPLIB_LIBRARY_SUFFIX}")
		endif()

		print_newline("done")
	endforeach()

	foreach(target.property ${SHARED_TARGETS})
		get_target_property(REAL_TARGET ${target.property} FLAME_REAL_TARGET)
		get_target_property(LIBRARY_TARGETS ${target.property} FLAME_DEPENDENCY_LIBRARIES)
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

	get_property(BINARY_TARGETS GLOBAL PROPERTY FLAME_BINARY_TARGETS)
	foreach(target.property ${BINARY_TARGETS})
		get_target_property(REAL_TARGET ${target.property} FLAME_REAL_TARGET)

		print_oneline("-- Binary ${REAL_TARGET} - ")

		get_target_property(SOURCE_LIST ${target.property} FLAME_ADDING_FILES)
		if(SOURCE_LIST)
			list(APPEND SOURCE_LIST ${ADDING_SOURCES})
		else()
			print_newline("fail")
		endif()
		add_executable(${REAL_TARGET} ${SOURCE_LIST})

		get_target_property(INCLUDE_PATHS ${target.property} FLAME_INCLUDE_PATHS)
		if(INCLUDE_PATHS)
			target_include_directories(${REAL_TARGET} PUBLIC ${INCLUDE_PATHS})
		endif()

		get_target_property(DEPENDENCY_LIBRARIES ${target.property} FLAME_DEPENDENCY_LIBRARIES)
		if(DEPENDENCY_LIBRARIES)
			target_link_libraries(${REAL_TARGET} PUBLIC ${DEPENDENCY_LIBRARIES})
		endif()

		get_target_property(DEPENDENCY_HEADERS ${target.property} FLAME_DEPENDENCY_HEADERS)
		if(DEPENDENCY_HEADERS)
			target_link_libraries(${REAL_TARGET} PUBLIC ${DEPENDENCY_HEADERS})
		endif()

		get_target_property(COMPILE_FLAGS ${target.property} FLAME_COMPILE_FLAGS)
		if(COMPILE_FLAGS)
			foreach(flag ${COMPILE_FLAGS})
				target_compile_options(${REAL_TARGET} PUBLIC ${flag})
			endforeach()
		endif()

		# Not supported now
		#get_target_property(LINK_FLAGS ${target.property} FLAME_LINK_FLAGS)

		get_target_property(OUTPUT_NAME ${target.property} FLAME_OUTPUT_NAME)
		if(OUTPUT_NAME)
			set_target_properties(${REAL_TARGET} PROPERTIES
				OUTPUT_NAME "${OUTPUT_NAME}")
		endif()

		# Not supported now
		#get_target_property(INSTALL_PATH ${target.property} FLAME_INSTALL_PATH)

		get_target_property(BINARY_ALIASES ${target.property} FLAME_BINARY_ALIASES)
		if(BINARY_ALIASES)
			foreach(alias ${BINARY_ALIASES})
				add_executable(${alias} ALIAS ${REAL_TARGET})
			endforeach()
		endif()

		get_target_property(IS_TEST ${target.property} FLAME_TEST)
		if(IS_TEST)
			get_target_property(TEST_ARGUMENTS ${target.property} FLAME_TEST_ARGUMENTS)
			add_test(
				NAME "${REAL_TARGET}"
				COMMAND ${OUTPUT_NAME} ${TEST_ARGUMENTS}
			)
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
	if(FLAME_CLEAN_AFTER_RESOLVE)
		foreach(property ${FLAME_GLOBAL_PROPERTY_LIST})
			set_property(GLOBAL PROPERTY ${property} "")
		endforeach()
	endif()
endfunction(internal_clean_global_properties)

#
#
#
function(internal_resolve_targets)
	check_internal_use()

	message("-- Start resolving")

	internal_resolve_headers()

	internal_resolve_object_libraries()
	internal_resolve_static_libraries()
	internal_resolve_shared_libraries()

	internal_resolve_binaries()

	internal_clean_global_properties()

	message("-- Resolve finished")
endfunction(internal_resolve_targets)

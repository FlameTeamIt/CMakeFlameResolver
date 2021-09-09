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

		get_target_property(INSTALL_PATH ${target.property} FLAME_INSTALL_PATH)
		if(INSTALL_PATH)
			install(FILES ${HEADER_LIST} DESTINATION ${INSTALL_PATH})
		endif()

		if(FLAME_CMAKE_PACKAGING)
			flame_create_cmake_package(TARGET_NAME ${REAL_TARGET})
		endif()

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

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

		get_target_property(DEFINES ${target.property} FLAME_DEFINES)
		if(DEFINES)
			target_compile_definitions(${REAL_TARGET} PRIVATE ${DEFINES})
		endif()

		get_target_property(DEPENDENCY_LIBRARIES ${target.property} FLAME_DEPENDENCY_LIBRARIES)
		if(DEPENDENCY_LIBRARIES)
			target_link_libraries(${REAL_TARGET} PUBLIC ${DEPENDENCY_LIBRARIES})
		endif()

		get_target_property(DEPENDENCY_HEADERS ${target.property} FLAME_DEPENDENCY_HEADERS)
		if(DEPENDENCY_HEADERS)
			target_link_libraries(${REAL_TARGET} PRIVATE ${DEPENDENCY_HEADERS})
		endif()

		get_target_property(COMPILE_FLAGS ${target.property} FLAME_COMPILE_FLAGS)
		if(COMPILE_FLAGS)
			foreach(flag ${COMPILE_FLAGS})
				target_compile_options(${REAL_TARGET} PRIVATE ${flag})
			endforeach()
		endif()

		# Not supported now
		#get_target_property(LINK_FLAGS ${target.property} FLAME_LINK_FLAGS)

		get_target_property(OUTPUT_NAME ${target.property} FLAME_OUTPUT_NAME)
		if(OUTPUT_NAME)
			set_target_properties(${REAL_TARGET} PROPERTIES
				OUTPUT_NAME "${OUTPUT_NAME}")
		endif()

		get_target_property(INSTALL_PATH ${target.property} FLAME_INSTALL_PATH)
		if(INSTALL_PATH)
			install(TARGETS ${REAL_TARGET}
				${FLAME_PLATFORM_BINARY_INSTALL_TYPE}
				DESTINATION ${INSTALL_PATH})
		endif()

		if(FLAME_CMAKE_PACKAGING)
			flame_create_cmake_package(TARGET_NAME ${REAL_TARGET})
		endif()

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

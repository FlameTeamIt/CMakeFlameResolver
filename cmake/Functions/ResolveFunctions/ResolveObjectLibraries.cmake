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
		if(NOT FLAME_INPLACE_OBJECTS)
			add_library(${REAL_TARGET} OBJECT ${SOURCE_LIST})
		endif()

		get_target_property(OBJECT_ALIASES ${target.property} FLAME_OBJECT_ALIASES)
		if(OBJECT_ALIASES)
			foreach(alias ${OBJECT_ALIASES})
				add_library(${alias} ALIAS ${REAL_TARGET})
			endforeach()
		endif()

		get_target_property(INCLUDE_PATHS ${target.property} FLAME_INCLUDE_PATHS)
		if(INCLUDE_PATHS)
			target_include_directories(${REAL_TARGET} PRIVATE ${INCLUDE_PATHS})
		endif()

		get_target_property(DEFINES ${target.property} FLAME_DEFINES)
		if(DEFINES)
			target_compile_definitions(${REAL_TARGET} PRIVATE ${DEFINES})
		endif()

		get_target_property(POSITION_INDEPENDENT ${target.property}
			FLAME_POSITION_INDEPENDENT)
		if(POSITION_INDEPENDENT)
			set_property(TARGET ${REAL_TARGET} PROPERTY
				POSITION_INDEPENDENT_CODE ${POSITION_INDEPENDENT})

			get_target_property(EXPORT_ALL_SYMBOLS ${target.property}
				FLAME_EXPORT_ALL_SYMBOLS)
			if(EXPORT_ALL_SYMBOLS)
				flame_shared_set_export_symbols("${REAL_TARGET}")
			endif()
		endif()

		get_target_property(HEADER_DEPENDENCIES ${target.property}
			FLAME_DEPENDENCY_HEADERS)
		if(HEADER_DEPENDENCIES)
			target_link_libraries(${REAL_TARGET} PRIVATE ${dependency})
		endif()

		get_target_property(COMPILE_FLAGS ${target.property} FLAME_COMPILE_FLAGS)
		if(COMPILE_FLAGS)
			foreach(flag ${COMPILE_FLAGS})
				target_compile_options(${REAL_TARGET} PRIVATE ${flag})
			endforeach()
		endif()

		print_newline("done")
	endforeach()

	end_debug_function()
endfunction(internal_resolve_object_libraries)

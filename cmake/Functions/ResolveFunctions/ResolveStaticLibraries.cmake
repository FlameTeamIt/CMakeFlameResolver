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
			target_link_libraries(${REAL_TARGET} PRIVATE ${HEADER_TARGETS})
		endif()

		# Not supported now
		#get_target_property(COMPILE_FLAGS ${target.property} FLAME_COMPILE_FLAGS)

		get_target_property(OUTPUT_NAME ${target.property} FLAME_OUTPUT_NAME)
		if(OUTPUT_NAME)
			set_target_properties(${REAL_TARGET} PROPERTIES
				OUTPUT_NAME "${OUTPUT_NAME}")
		endif()

		get_target_property(INSTALL_PATH ${target.property} FLAME_INSTALL_PATH)
		if(INSTALL_PATH)
			install(TARGETS ${REAL_TARGET} DESTINATION ${INSTALL_PATH})
		endif()

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

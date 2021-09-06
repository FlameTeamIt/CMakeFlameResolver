#
#
#
function(flame_get_real_target CURRENT_TARGET_NAME REAL_TARGET_NAME)
	if(TARGET ${CURRENT_TARGET_NAME})
		get_target_property(aliased ${CURRENT_TARGET_NAME} ALIASED_TARGET)
		if(aliased)
			set(${REAL_TARGET_NAME} ${aliased} PARENT_SCOPE)
		else()
			set(${REAL_TARGET_NAME} ${CURRENT_TARGET_NAME} PARENT_SCOPE)
		endif()
	else()
		message_fatal("-- '${CURRENT_TARGET_NAME}' is not a target")
	endif()
endfunction(flame_get_real_target)

#
#
#
function(internal_flame_find_lib NAME)
	check_internal_use()
	find_library(LIBRARY_${CMAKE_FIND_LIBRARY_SUFFIXES} ${NAME})
	if (NOT LIBRARY_${CMAKE_FIND_LIBRARY_SUFFIXES})
		message("NAME ('${CMAKE_FIND_LIBRARY_SUFFIXES}') not found")
	endif()
	set(LIBRARY_${CMAKE_FIND_LIBRARY_SUFFIXES}
		"${LIBRARY_${CMAKE_FIND_LIBRARY_SUFFIXES}}"
		PARENT_SCOPE)
endfunction()

#
#
#
function(flame_find_static_lib NAME LOCATION)
	enable_internal_use()
	set(CMAKE_FIND_LIBRARY_SUFFIXES "${FLAME_STATIC_LIBRARY_SUFFIX}")
	internal_flame_find_lib(${NAME})
	set(${LOCATION} ${LIBRARY_${CMAKE_FIND_LIBRARY_SUFFIXES}} PARENT_SCOPE)
endfunction()

#
#
#
function(flame_find_shared_lib NAME LOCATION)
	enable_internal_use()
	set(CMAKE_FIND_LIBRARY_SUFFIXES "${FLAME_SHARED_LIBRARY_SUFFIX}")
	internal_flame_find_lib(${NAME})
	set(${LOCATION} ${LIBRARY_${CMAKE_FIND_LIBRARY_SUFFIXES}} PARENT_SCOPE)
endfunction()

#
#
#
macro(internal_settings)
	check_internal_use()
	set(OPTIONS
		# Common options
		"CMAKE_DEBUG"
		"CMAKE_DEBUG_SHOW_PARSE_RESULTS"
		"PRINT_COMMON_STATISTIC"
		"PRINT_DETAILED_STATISTIC"
		"LOGGING"
		"CLEAN_AFTER_RESOLVE"
		"THREADING"
		"TESTING"
		"INSTALL"
		"LOCAL_INSTALL"

		# Code generation options
		"ONLY_POSITION_INDEPENDENT_OBJECTS"
		"MAKE_STATIC"
		"MAKE_SHARED"
		"MAKE_STANDALONE"
		"EXPORT_ALL_SYMBOLS"

		# Flag options
		"CXX_NO_RTTI"
		"CXX_NO_EXCEPTIONS"
		"PLATFORM_DEFINES"
	)
	set(VALUES "PROJECT_ROOT_PATH" "LOCAL_INSTALL_PREFIX")
	set(LISTS)

	cmake_parse_arguments("FLAME" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")
	foreach(option ${OPTIONS})
		set(FLAME_${option} ${FLAME_${option}} PARENT_SCOPE)
	endforeach()
	foreach(value ${VALUES})
		set(FLAME_${value} ${FLAME_${value}} PARENT_SCOPE)
	endforeach()
endmacro()

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

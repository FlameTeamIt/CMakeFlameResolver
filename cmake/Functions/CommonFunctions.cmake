#
#
#
function(remove_source_dir PATH REMOVE_PATH OUT)
	string(REPLACE "${REMOVE_PATH}" "" ${OUT} "${PATH}")
	set(${OUT} "${${OUT}}" PARENT_SCOPE)
endfunction(remove_source_dir)

#
#
#
function(get_real_target CURRENT_TARGET_NAME REAL_TARGET_NAME)
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
endfunction(get_real_target)


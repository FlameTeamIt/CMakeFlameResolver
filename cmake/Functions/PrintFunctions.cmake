#
#
#
function(message_debug)
	if(FLAME_CMAKE_DEBUG)
		message(${ARGV})
	endif()
endfunction(message_debug)

#
#
#
function(message_fatal)
	message(FATAL_ERROR ${ARGV})
endfunction(message_fatal)

#
#
#
function(message_warning)
	message(WARNING ${ARGV})
endfunction(message_warning)

#
#
#
function(print_oneline)
	if(FLAME_LOGGING)
		foreach(str ${ARGV})
			string(CONCAT RESULT_MESSAGE ${RESULT_MESSAGE} ${str})
		endforeach()
		execute_process(COMMAND ${CMAKE_COMMAND} -E echo_append "${RESULT_MESSAGE}")
	endif()
endfunction(print_oneline)

#
#
#
function(print_newline)
	if(FLAME_LOGGING)
		foreach(str ${ARGV})
			string(CONCAT RESULT_MESSAGE ${RESULT_MESSAGE} ${str})
		endforeach()
		execute_process(COMMAND ${CMAKE_COMMAND} -E echo "${RESULT_MESSAGE}")
	endif()
endfunction(print_newline)

#
#
#
function(print_debug_oneline)
	if(FLAME_CMAKE_DEBUG)
		foreach(str ${ARGV})
			string(CONCAT RESULT_MESSAGE ${RESULT_MESSAGE} ${str})
		endforeach()
		execute_process(COMMAND ${CMAKE_COMMAND}
			-E echo_append "${RESULT_MESSAGE}")
	endif()
endfunction(print_debug_oneline)

#
#
#
function(print_debug_newline)
	if(FLAME_CMAKE_DEBUG)
		foreach(str ${ARGV})
			string(CONCAT RESULT_MESSAGE ${RESULT_MESSAGE} ${str})
		endforeach()
		execute_process(COMMAND ${CMAKE_COMMAND}
			-E echo "${RESULT_MESSAGE}")
	endif()
endfunction(print_debug_newline)

#
#
#
function(print_debug_list_newline)
	set(ARG_LIST ${ARGV})
	if(ARG_LIST)
		list(GET ARG_LIST 0 RESULT)
		list(REMOVE_AT ARG_LIST 0)
		foreach(arg ${ARG_LIST})
			string(CONCAT RESULT ${RESULT} ", " ${arg})
		endforeach()
	endif()

	print_debug_newline("${RESULT}")
endfunction(print_debug_list_newline)

#
#
#
function(internal_print_warning_not_support VAR_VALUE VAR_NAME)
	check_internal_use()

	if(VAR_VALUE)
		message_warning("-- '${VAR_NAME}' is not supporting now")
	endif()
endfunction(internal_print_warning_not_support)

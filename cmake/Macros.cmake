#
#
#
macro(start_debug_function FUNC_NAME)
	set(FUNCTION_NAME ${FUNC_NAME})
	message_debug("->>- ${FUNCTION_NAME}()")
endmacro(start_debug_function)

#
#
#
macro(end_debug_function)
	message_debug("-<<- ${FUNCTION_NAME}()")
	unset(FUNCTION_NAME)
endmacro(end_debug_function)

#
#
#
macro(message_debug_function)
	message_debug("---| ${FUNCTION_NAME}() : " "${ARGV}")
endmacro(message_debug_function)

#
#
#
macro(print_debug_function_oneline)
	print_debug_oneline("---| ${FUNCTION_NAME}() : " "${ARGV}")
endmacro(print_debug_function_oneline)

#
#
#
macro(print_debug_function_newline)
	print_debug_newline("---| ${FUNCTION_NAME}() : " "${ARGV}")
endmacro(print_debug_function_newline)

#
#
#
macro(enable_internal_use)
	set(INTERNAL_USE TRUE)
endmacro(enable_internal_use)

#
#
#
macro(check_internal_use)
	if(NOT INTERNAL_USE)
		message_fatal("-- It's internal function. You can not use it")
	endif()
endmacro(check_internal_use)
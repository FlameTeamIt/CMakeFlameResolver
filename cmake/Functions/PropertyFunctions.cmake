#
#
#
function(target_property_define PROPERTY_NAME PROPERTY_INFO PROPERTY_FULL_INFO)
	define_property(TARGET
		PROPERTY   ${PROPERTY_NAME}
		BRIEF_DOCS "${PROPERTY_INFO}"
		FULL_DOCS  "${PROPERTY_FULL_INFO}"
	)
endfunction(target_property_define)


#
#
#
function(target_property_set TARGET_NAME PROPERTY_NAME PROPERTY_VALUE)
	set_target_properties(
		${TARGET_NAME}
		PROPERTIES ${PROPERTY_NAME} "${PROPERTY_VALUE}"
	)
endfunction(target_property_set)

#
#
#
function(target_property_get TARGET_NAME PROPERTY_NAME PROPERTY_VALUE)
	get_target_property("${PROPERTY_VALUE}"
		${TARGET_NAME}
		${PROPERTY_NAME}
	)
	set(${PROPERTY_VALUE} "${${PROPERTY_VALUE}}" PARENT_SCOPE)
endfunction(target_property_get)

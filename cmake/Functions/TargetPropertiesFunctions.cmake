include(Functions/TargetPropertiesFunctions/BinaryTargetProperties)
include(Functions/TargetPropertiesFunctions/HeaderTargetProperties)
include(Functions/TargetPropertiesFunctions/ObjectTargetProperties)
include(Functions/TargetPropertiesFunctions/SharedTargetProperties)
include(Functions/TargetPropertiesFunctions/StaticTargetProperties)

# NAME           -
# TARGET_TYPE    -
# PROPERTY_NAME  -
# PROPERTY_VALUE -
function(internal_target_add_property NAME TARGET_TYPE PROPERTY_NAME PROPERTY_VALUE)
	check_internal_use()
	string(TOUPPER "${TARGET_TYPE}" TARGET_TYPE)
	if (NOT(
			("${TARGET_TYPE}" STREQUAL "HEADER")
			OR ("${TARGET_TYPE}" STREQUAL "OBJECT")
			OR ("${TARGET_TYPE}" STREQUAL "STATIC")
			OR ("${TARGET_TYPE}" STREQUAL "SHARED")
			OR ("${TARGET_TYPE}" STREQUAL "BINARY")
	))
		message_fatal("Invalid 'TARGET_TYPE' (TARGET_TYPE != {HEADER, OBJECT, STATIC, SHARED, BINARY})")
	endif()
endfunction(internal_target_add_property)

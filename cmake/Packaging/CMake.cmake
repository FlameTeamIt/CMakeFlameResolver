if(NOT FLAME_CMAKE_PACKAGING)
	return()
endif()

include(CMakePackageConfigHelpers)

set(FLAME_PACKAGE_CONFIG_FILE "${CMAKE_CURRENT_LIST_DIR}/CMakePackageConfig.cmake.in")
set(FLAME_PACKAGE_INSTALL_DIR "share/cmake")

# Options:
# Values:
# Lists:
function(flame_create_cmake_package)
	set(VALUES
		"TARGET_NAME"
	)
	cmake_parse_arguments("FLAME" "${OPTIONS}" "${VALUES}" "${LISTS}" "${ARGN}")

	set(RESULT_PACKAGE_CONFIG_FILE ${CMAKE_CURRENT_BINARY_DIR}/${FLAME_TARGET_NAME}.config.cmake)
	set(DESTINATION_PATH ${FLAME_LOCAL_INSTALL_PREFIX}/share/cmake)
	configure_package_config_file(
		${FLAME_PACKAGE_CONFIG_FILE} #input
		${RESULT_PACKAGE_CONFIG_FILE} # output
		INSTALL_DESTINATION ${DESTINATION_PATH}
		# [PATH_VARS <var1> <var2> ... <varN>]
		# [NO_SET_AND_CHECK_MACRO]
		# [NO_CHECK_REQUIRED_COMPONENTS_MACRO]
		INSTALL_PREFIX ${FLAME_LOCAL_INSTALL_PREFIX}
	)
	install(FILES ${RESULT_PACKAGE_CONFIG_FILE} DESTINATION ${DESTINATION_PATH})

endfunction()

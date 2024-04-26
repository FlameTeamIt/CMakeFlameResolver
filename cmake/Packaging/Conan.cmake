if (NOT FLAME_CONAN_SUPPORT)
	return()
endif()

set(FLAME_CONAN_VERSION "1.*")

function(flame_conan_find CONAN_EXE)
	set(PATH $ENV{PATH})
	find_program(CONAN
		NAMES conan
		PATHS ${PATH}
	)
	if ("${CONAN}" STREQUAL "CONAN-NOTFOUND")
		find_program(CONAN
			NAMES conan
			PATHS ${FLAME_LOCAL_INSTALL_CONAN_DIR}/bin
		)
		if ("${CONAN}" STREQUAL "CONAN-NOTFOUND")
			return()
		endif()
	endif()
	set(ENV{PYTHONPATH} ${FLAME_LOCAL_INSTALL_CONAN_DIR})
	set(ENV{CONAN_USER_HOME} ${FLAME_LOCAL_INSTALL_CONAN_DIR}/home)

	set(${CONAN_EXE} ${CONAN} PARENT_SCOPE)
endfunction()

function(flame_pip_find PIP_EXE)
	set(PATH $ENV{PATH})
	find_program(PIP
		NAMES pip pip3
		PATHS ${PATH} ${FLAME_PIP_PATH}
	)
	if ("${PIP}" STREQUAL "PIP-NOTFOUND")
		message_fatal("pip not found. Specify 'FLAME_PIP_PATH' for installing conan")
	endif()
	set(${PIP_EXE} ${PIP} PARENT_SCOPE)
endfunction()

function(flame_conan_install PIP_EXE)
	message_status("Installing conan")
	execute_process(
		COMMAND ${PIP_EXE} install -t ${FLAME_LOCAL_INSTALL_CONAN_DIR} conan==${FLAME_CONAN_VERSION}
		RESULT_VARIABLE CONAN_INSTALL_RESULT
		OUTPUT_VARIABLE CONAN_INSTALL_OUTPUT
		ERROR_VARIABLE CONAN_INSTALL_ERROR
	)
	if (NOT CONAN_INSTALL_RESULT EQUAL "0")
		message_status("Installing conan - failed")
		message(${CONAN_INSTALL_OUTPUT})
		message_fatal("${CONAN_INSTALL_ERROR}")
	endif()
	message_status("Installing conan - done")

	message_status("Setuping conan")
	set(CONAN_HOME ${FLAME_LOCAL_INSTALL_CONAN_DIR}/home)
	set(CONAN_CACHE ${FLAME_LOCAL_INSTALL_CONAN_DIR}/cache)
	set(CONAN_DATA ${FLAME_LOCAL_INSTALL_CONAN_DIR}/data)

	flame_conan_find(CONAN_EXE)
	execute_process(
		COMMAND ${CMAKE} -E make_directory ${CONAN_HOME}
	)
	execute_process(
		COMMAND ${CMAKE} -E make_directory ${CONAN_CACHE}
	)
	execute_process(
		COMMAND ${CMAKE} -E make_directory ${CONAN_DATA}
	)
	execute_process(
		COMMAND ${CONAN_EXE} config set general.use_always_short_paths=False
		RESULT_VARIABLE CONAN_CONFIGURE_RESULT
	)
	execute_process(
		COMMAND ${CONAN_EXE} config set general.user_home_short=${CONAN_HOME}
		RESULT_VARIABLE CONAN_CONFIGURE_RESULT
	)
	execute_process(
		COMMAND ${CONAN_EXE} config set general.cmake_generator=${CMAKE_GENERATOR}
		RESULT_VARIABLE CONAN_CONFIGURE_RESULT
	)
	execute_process(
		COMMAND ${CONAN_EXE} config set storage.download_cache=${CONAN_CACHE}
		RESULT_VARIABLE CONAN_CONFIGURE_RESULT
	)
	execute_process(
		COMMAND ${CONAN_EXE} config set storage.path=${CONAN_DATA}
		RESULT_VARIABLE CONAN_CONFIGURE_RESULT
	)
	message_status("Setuping conan - done")
endfunction()

function(flame_download_cmake_conan)
	find_package(Git REQUIRED)
	if(NOT Git_FOUND)
		message_fatal("Git not found")
	endif()

	set(NAME cmake-conan)
	set(PATH ${FLAME_LOCAL_INSTALL_CONAN_DIR}/${NAME})
	set(URL "https://github.com/conan-io/${NAME}.git")
	set(VERSION "0.18.1")
	if(NOT (EXISTS "${PATH}" AND IS_DIRECTORY "${PATH}"))
		message_status("Cloning ${NAME} branch='${VERSION}'")
		execute_process(
			COMMAND
				${GIT_EXECUTABLE} clone ${URL} --branch ${VERSION}
				${PATH}
			RESULT_VARIABLE CLONE_RESULT
			OUTPUT_VARIABLE CLONE_OUTPUT
			ERROR_VARIABLE CLONE_ERROR
		)
		if (NOT CLONE_RESULT EQUAL "0")
			message_status("Cloning ${NAME} branch='${VERSION}' - failed")
			message_fatal("${CLONE_ERROR}")
		endif()
		message_status("Cloning ${NAME} branch='${VERSION}' - done")
	else()
		message_status("Not need to clone ${NAME} branch='${VERSION}'")
	endif()
	set(FLAME_CONAN_INTEGRATION_MODULE ${PATH}/conan.cmake PARENT_SCOPE)
endfunction()

function(flame_conan_init)
	flame_conan_find(CONAN_EXE)
	if (NOT CONAN_EXE)
		flame_pip_find(PIP_EXE)
		flame_conan_install(${PIP_EXE})
		flame_conan_find(CONAN_EXE)
		if (NOT CONAN_EXE)
			message_fatal("conan not found after installation")
		endif()
	endif()
	flame_download_cmake_conan()
	set(FLAME_CONAN_INTEGRATION_MODULE ${FLAME_CONAN_INTEGRATION_MODULE} PARENT_SCOPE)
	set(FLAME_CONAN_EXECUTABLE ${CONAN_EXE} PARENT_SCOPE)
endfunction()

flame_conan_init()
set(CONAN_COMMAND ${FLAME_CONAN_EXECUTABLE})
include(${FLAME_CONAN_INTEGRATION_MODULE})

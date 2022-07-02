if (NOT FLAME_CONAN_SUPPORT)
	return()
endif()

function(flame_conan_find CONAN_EXE)
	set(PATH $ENV{PATH})
	find_program(CONAN
		NAMES conan
		PATHS ${PATH}
	)
	if ("${CONAN}" STREQUAL "CONAN-NOTFOUND")
		find_program(CONAN
			NAMES conan
			PATHS ${FLAME_LOCAL_INSTALL_CONAN_PATH}/bin
		)
		if ("${CONAN}" STREQUAL "CONAN-NOTFOUND")
			return()
		endif()

		set(ENV{PATH} $ENV{PATH} ${FLAME_LOCAL_INSTALL_CONAN_PATH}/bin)
		set(ENV{PYTHONPATH} ${FLAME_LOCAL_INSTALL_CONAN_PATH})
		set(ENV{CONAN_USER_HOME} ${FLAME_LOCAL_INSTALL_CONAN_PATH}/home)
	endif()

	set(${CONAN_EXE} ${CONAN} PARENT_SCOPE)
endfunction()

function(flame_pip_find PIP_EXE)
	set(PATH $ENV{PATH})
	find_program(PIP
		NAMES pip pip3
		PATHS ${PATH}
	)
	if ("${PIP}" STREQUAL "PIP-NOTFOUND")
		message_fatal("${PATH}; pip not found")
	endif()
	set(${PIP_EXE} ${PIP} PARENT_SCOPE)
endfunction()

function(flame_conan_install PIP_EXE)
	message_status("conan install")
	execute_process(
		COMMAND ${PIP_EXE} install -t ${FLAME_LOCAL_INSTALL_CONAN_PATH} conan
	)
	message_status("conan install - done")

	message_status("conan init")
	set(CONAN_HOME ${FLAME_LOCAL_INSTALL_CONAN_PATH}/home)
	set(CONAN_CACHE ${FLAME_LOCAL_INSTALL_CONAN_PATH}/cache)
	set(CONAN_DATA ${FLAME_LOCAL_INSTALL_CONAN_PATH}/data)

	flame_conan_find(CONAN_EXE)
	execute_process(COMMAND ${CMAKE} -E make_directory ${CONAN_HOME} )
	execute_process(COMMAND ${CMAKE} -E make_directory ${CONAN_CACHE})
	execute_process(COMMAND ${CMAKE} -E make_directory ${CONAN_DATA})
	execute_process(COMMAND ${CONAN_EXE} config home)
	execute_process(COMMAND ${CONAN_EXE} config set storage.download_cache=${CONAN_CACHE})
	execute_process(COMMAND ${CONAN_EXE} config set storage.path=${CONAN_DATA})
	message_status("conan init - done")
endfunction()

function(flame_download_cmake_conan)
	find_package(Git REQUIRED)
	if(NOT Git_FOUND)
		message_fatal("Git not found")
	endif()

	set(NAME cmake-conan)
	set(PATH ${CMAKE_CURRENT_LIST_DIR}/${NAME})
	set(URL "https://github.com/conan-io/${NAME}.git")
	set(VERSION "0.18.1")
	if(NOT (EXISTS "${PATH}" AND IS_DIRECTORY "${PATH}"))
		execute_process(
			COMMAND
				${GIT_EXECUTABLE} clone ${URL} --branch ${VERSION}
				${PATH}
		)
	else()
		message(STATUS "Not need to clone '${NAME} ${VERSION}'")
	endif()
	set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PATH} PARENT_SCOPE)
endfunction()

function(flame_conan_init)
	flame_conan_find(CONAN_EXE)
	if (NOT CONAN_EXE)
		flame_pip_find(PIP_EXE)
		flame_conan_install(${PIP_EXE})
	endif()
	flame_download_cmake_conan()
endfunction()

flame_conan_init()
include(${CMAKE_CURRENT_LIST_DIR}/cmake-conan/conan.cmake)
conan_cmake_autodetect(settings)

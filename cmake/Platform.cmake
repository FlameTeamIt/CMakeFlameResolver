if(FLAME_THREADING)
	find_package(Threads REQUIRED)
	if(NOT (TARGET Threads::Threads))
		message(FATAL_ERROR "Target 'Threads::Threads' not found")
	endif()
endif()

if(UNIX)
	include(Platform/Unix)
endif(UNIX)

if(WIN32)
	include(Platform/Windows)
endif(WIN32)

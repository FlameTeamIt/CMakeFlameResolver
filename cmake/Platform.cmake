if(UNIX)
	include(Platform/Unix)
endif(UNIX)

if(WIN32)
	include(Platform/Windows)
endif(WIN32)

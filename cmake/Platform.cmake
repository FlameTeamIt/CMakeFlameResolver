if(FLAME_THREADING)
	find_package(Threads REQUIRED)
	if(NOT (TARGET Threads::Threads))
		message(FATAL_ERROR "Target 'Threads::Threads' not found")
	endif()
endif()

if(CMAKE_CXX_COMPILER)
	if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
		set(FLAME_CXX_FLAG_NO_RTTI "-fno-rtti")
		set(FLAME_CXX_FLAG_RTTI "-frtti")

		set(FLAME_CXX_FLAG_NO_EXCEPTIONS "-fno-cxx-exceptions")
		set(FLAME_CXX_FLAG_EXCEPTIONS "-fcxx-exceptions")
	elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
		set(FLAME_CXX_FLAG_NO_RTTI "-fno-rtti")
		set(FLAME_CXX_FLAG_RTTI "")

		set(FLAME_CXX_FLAG_NO_EXCEPTIONS "-fno-exceptions")
		set(FLAME_CXX_FLAG_EXCEPTIONS "-fexceptions")
	elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
		set(FLAME_CXX_FLAG_NO_RTTI "/GR")
		set(FLAME_CXX_FLAG_RTTI "/GR-")

		set(FLAME_CXX_FLAG_NO_EXCEPTIONS "/EHsc-")
		set(FLAME_CXX_FLAG_EXCEPTIONS "/EHsc")
	endif()
endif()
string(REPLACE
	"${FLAME_CXX_FLAG_NO_RTTI}" ""
	CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS}
)
string(REPLACE
	"${FLAME_CXX_FLAG_RTTI}" ""
	CMAKE_CXX_FLAGS
	"${CMAKE_CXX_FLAGS}"
)
string(REPLACE
	"${FLAME_CXX_FLAG_NO_EXCEPTIONS}" ""
	CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS}
)
string(REPLACE
	"${FLAME_CXX_FLAG_EXCEPTIONS}" ""
	CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS}
)

if(UNIX)
	include(Platform/Unix)
endif(UNIX)

if(WIN32)
	include(Platform/Windows)
endif(WIN32)

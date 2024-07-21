if((NOT CMAKE_CXX_COMPILER) AND (NOT CMAKE_C_COMPILER))
	message(FATAL_ERROR "Only for C and/or C++")
endif()

include(Compilers/Common)
include(Compilers/Gcc)
include(Compilers/Clang)
include(Compilers/Msvc)

if(NOT CMAKE_RESOLVER_COMPILER_CURRENT_ID)
	message(FATAL_ERROR "Compiler is not supported")
endif()

set(FLAME_DEFINE_COMPILER_CURRENT
	CMAKE_RESOLVER_COMPILER_CURRENT=${CMAKE_RESOLVER_COMPILER_CURRENT_ID})

set(FLAME_FLAGS
	${FLAME_CXX_FLAG_NO_RTTI}
	${FLAME_CXX_FLAG_RTTI}
	${FLAME_CXX_FLAG_NO_EXCEPTIONS}
	${FLAME_CXX_FLAG_EXCEPTIONS}
)
foreach(flag ${FLAME_FLAGS})
	string(REPLACE "${flag}" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
endforeach()

function(flame_shared_set_export_symbols TARGET_NAME)
	if(CMAKE_RESOLVER_COMPILER_CURRENT_ID EQUAL CMAKE_RESOLVER_COMPILER_GCC_ID)
		flame_shared_set_export_symbols_gcc(${TARGET_NAME})
	elseif(CMAKE_RESOLVER_COMPILER_CURRENT_ID EQUAL CMAKE_RESOLVER_COMPILER_CLANG_ID)
		flame_shared_set_export_symbols_clang(${TARGET_NAME})
	elseif(CMAKE_RESOLVER_COMPILER_CURRENT_ID EQUAL CMAKE_RESOLVER_COMPILER_MSVC_ID)
		flame_shared_set_export_symbols_msvc(${TARGET_NAME})
	endif()
endfunction()

function(flame_get_platform_defines OUT_LIST)
	set(FLAME_PLATFORM_FLAGS
		${FLAME_DEFINE_COMPILER_CURRENT}
		${FLAME_DEFINE_COMPILER_GCC}
		${FLAME_DEFINE_COMPILER_CLANG}
		${FLAME_DEFINE_COMPILER_MSVC}
		${FLAME_DEFINE_EXPORT}
	)
	set(${OUT_LIST} ${FLAME_PLATFORM_FLAGS} PARENT_SCOPE)
endfunction()

function(flame_get_rtti_defines RTTI_ON OUT_LIST)
	if(RTTI_ON)
		set(DEFINE_RTTI
			CMAKE_RESOLVER_RTTI_ENABLED=1
			CMAKE_RESOLVER_RTTI_DISABLED=0)
	else()
		set(DEFINE_RTTI
			CMAKE_RESOLVER_RTTI_ENABLED=0
			CMAKE_RESOLVER_RTTI_DISABLED=1)
	endif()

	set(${OUT_LIST} ${DEFINE_RTTI} PARENT_SCOPE)
endfunction()

function(flame_get_exception_defines EXCEPTIONS_ON OUT_LIST)
	if(EXCEPTIONS_ON)
		set(DEFINE_EXCEPTIONS
			CMAKE_RESOLVER_EXCEPTIONS_ENABLED=1
			CMAKE_RESOLVER_EXCEPTIONS_DISABLED=0)
	else()
		set(DEFINE_EXCEPTIONS
			CMAKE_RESOLVER_EXCEPTIONS_ENABLED=0
			CMAKE_RESOLVER_EXCEPTIONS_DISABLED=1)
	endif()

	set(${OUT_LIST} ${DEFINE_EXCEPTIONS} PARENT_SCOPE)
endfunction()

function(flame_get_warning_flags OUT_LIST)
	if(FLAME_WARNINGS)
		set(FLAG_LIST ${FLAME_WARNING_FLAG_LIST})
		if(FLAME_WARNINGS_AS_ERRORS)
			list(APPEND FLAG_LIST ${FLAME_WARNING_AS_ERROR_FLAG})
		endif()
	endif()
	set(${OUT_LIST} ${FLAG_LIST} PARENT_SCOPE)
endfunction()

if((NOT CMAKE_CXX_COMPILER) AND (NOT CMAKE_C_COMPILER))
	message(FATAL_ERROR "Only for C and/or C++")
endif()

include(Compilers/Gcc)
include(Compilers/Clang)
include(Compilers/Msvc)

if(NOT CMAKE_RESOLVER_COMPILER_CURRENT_ID)
	message(FATAL_ERROR "Compiler is not support")
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

function(flame_set_platform_defines TARGET_NAME)
	set(FLAME_PLATFORM_FLAGS
		${FLAME_DEFINE_COMPILER_CURRENT}
		${FLAME_DEFINE_COMPILER_GCC}
		${FLAME_DEFINE_COMPILER_CLANG}
		${FLAME_DEFINE_COMPILER_MSVC}
		${FLAME_DEFINE_EXPORT}
	)
	target_compile_definitions(${TARGET_NAME} PUBLIC ${FLAME_PLATFORM_FLAGS})

	get_target_property(OPTIONS ${TARGET_NAME} COMPILE_OPTIONS)
	#message(FATAL_ERROR "Options = ${OPTIONS}")
endfunction()

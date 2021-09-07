generate_random_id(CMAKE_RESOLVER_COMPILER_CLANG_ID)

set(FLAME_DEFINE_COMPILER_CLANG
	CMAKE_RESOLVER_COMPILER_CLANG=${CMAKE_RESOLVER_COMPILER_CLANG_ID})

if(("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
		OR ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang"))
	message(STATUS "Detect clang")

	set(FLAME_DEFINE_EXPORT "CMAKE_RESOLVER_EXPORT=__attribute__((visibility(default)))")

	set(CMAKE_RESOLVER_COMPILER_CURRENT_ID ${CMAKE_RESOLVER_COMPILER_CLANG_ID})

	set(FLAME_FLAG_ALL_EXPORT "-fvisibility=default")
	set(FLAME_FLAG_NO_EXPORT "-fvisibility=hidden")

	if(CMAKE_CXX_COMPILER)
		set(FLAME_CXX_FLAG_NO_RTTI "-fno-rtti")
		set(FLAME_CXX_FLAG_RTTI "-frtti")

		set(FLAME_CXX_FLAG_NO_EXCEPTIONS "-fno-cxx-exceptions")
		set(FLAME_CXX_FLAG_EXCEPTIONS "-fcxx-exceptions")
	endif()

	set(FLAME_WARNING_FLAG_LIST "-Wall" "-Wextra" "-Wstrict-aliasing")
	set(FLAME_WARNING_AS_ERROR_FLAG "-Werror")
endif()

function(flame_shared_set_export_symbols_clang TARGET_NAME)
	flame_shared_set_export_symbols_gcc(${TARGET_NAME})
endfunction()

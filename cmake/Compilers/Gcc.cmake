generate_random_id(CMAKE_RESOLVER_COMPILER_GCC_ID)

set(FLAME_DEFINE_COMPILER_GCC
	CMAKE_RESOLVER_COMPILER_GCC=${CMAKE_RESOLVER_COMPILER_GCC_ID})

if(("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
		OR ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU"))
	message(STATUS "Detect GCC")

	set(FLAME_DEFINE_EXPORT "CMAKE_RESOLVER_EXPORT=__attribute__((visibility(\"default\")))")

	set(CMAKE_RESOLVER_COMPILER_CURRENT_ID ${CMAKE_RESOLVER_COMPILER_GCC_ID})

	set(FLAME_FLAG_ALL_EXPORT "-fvisibility=default")
	set(FLAME_FLAG_NO_EXPORT "-fvisibility=hidden")

	if(CMAKE_CXX_COMPILER)
		set(FLAME_CXX_FLAG_NO_RTTI "-fno-rtti")
		set(FLAME_CXX_FLAG_RTTI "")

		set(FLAME_CXX_FLAG_NO_EXCEPTIONS "-fno-exceptions")
		set(FLAME_CXX_FLAG_EXCEPTIONS "-fexceptions")
	endif()

	set(FLAME_WARNING_FLAG_LIST "-Wall" "-Wextra" "-Wstrict-aliasing")
	set(FLAME_WARNING_AS_ERROR_FLAG "-Werror")

	if(FLAME_THREADING AND ("${FLAME_PLATFORM}" STREQUAL "Posix"))
		flame_internal_enable_pthread_linking()
	endif()
endif()

function(flame_shared_set_export_symbols_gcc TARGET_NAME)
	target_compile_options(${TARGET_NAME} PRIVATE ${FLAME_FLAG_ALL_EXPORT})
endfunction()

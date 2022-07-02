if(FLAME_THREADING AND ("${FLAME_PLATFORM}" STREQUAL "Posix"))

	function(flame_internal_enable_pthread_linking)
		add_library(flame_static_linking_pthread INTERFACE)
		add_library(flame_dynamic_linking_pthread INTERFACE)

		target_link_options(flame_static_linking_pthread INTERFACE
			"-pthread")
		target_link_options(flame_dynamic_linking_pthread INTERFACE
			"-pthread")

		set(FLAME_DEPENDENCY_STATIC_THREAD_LIBRARY flame_static_linking_pthread
			PARENT_SCOPE)
		set(FLAME_DEPENDENCY_SHARED_THREAD_LIBRARY flame_dynamic_linking_pthread
			PARENT_SCOPE)
	endfunction()

endif()

include(Functions/ResolveFunctions/ResolveBinaries)
include(Functions/ResolveFunctions/ResolveHeaders)
include(Functions/ResolveFunctions/ResolveObjectLibraries)
include(Functions/ResolveFunctions/ResolveSharedLibraries)
include(Functions/ResolveFunctions/ResolveStaticLibraries)

#
#
#
function(internal_clean_global_properties)
	check_internal_use()
	if(FLAME_CLEAN_AFTER_RESOLVE)
		foreach(property ${FLAME_GLOBAL_PROPERTY_LIST})
			set_property(GLOBAL PROPERTY ${property} "")
		endforeach()
	endif()
endfunction(internal_clean_global_properties)

#
#
#
function(internal_resolve_targets)
	check_internal_use()

	message("-- Start resolving")

	internal_resolve_headers()

	internal_resolve_object_libraries()
	internal_resolve_static_libraries()
	internal_resolve_shared_libraries()

	internal_resolve_binaries()

	internal_clean_global_properties()

	message("-- Resolve finished")
endfunction(internal_resolve_targets)

function(flame_header_library)
	enable_internal_use()
	internal_header_library(${ARGN})
endfunction(flame_header_library)

function(flame_compile_library)
	enable_internal_use()
	internal_compile_library(${ARGN})
endfunction(flame_compile_library)

function(flame_compile_binary)
	enable_internal_use()
	internal_compile_binary(${ARGN})
endfunction(flame_compile_binary)

function(flame_resolve_targets)
	enable_internal_use()
	internal_resolve_targets()
endfunction(flame_resolve_targets)

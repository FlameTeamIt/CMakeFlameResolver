cmake_minimum_required(VERSION 3.14)

include(Macros)

include(Options)
include(Properties)
include(Variables)
include(Functions)
include(Compilers)
include(Platform)

# Public API:

# Options:
#   DEBUG -
#   HELP  -
# Values:
#   NAME               -
#   LIBRARY_ALIAS_NAME -
#   INSTALL_PATH       -
# Lists:
#   DEPENDENCY_TARGET_LIST -
#   HEADER_LIST            -
#   INCLUDE_PATHS          -
function(flame_header_library)
	enable_internal_use()
	internal_header_library(${ARGN})
endfunction(flame_header_library)

# Options:
#   DEBUG                                 -
#   HELP                                  -
#   MAKE_STATIC                           -
#   MAKE_SHARED                           -
#   NOT_MAKE_POSITION_DEPENDENT_OBJECTS   -
#   NOT_MAKE_POSITION_INDEPENDENT_OBJECTS -
#   EXPORT_ALL                            -
#   USE_RESOLVER_DEFINES                  -
# Values:
#   NAME                          -
#   OBJECT_ALIAS_NAME             -
#   INDEPENDENT_OBJECT_ALIAS_NAME -
#   STATIC_ALIAS_NAME             -
#   SHARED_ALIAS_NAME             -
#   STATIC_INSTALL_PATH           -
#   SHARED_INSTALL_PATH           -
# Lists:
#   INCLUDE_PATHS                 -
#   DEFINES                       -
#   SOURCE_LIST                   -
#   SOURCE_LIST_STATIC            -
#   SOURCE_LIST_SHARED            -
#   COMMPILE_FLAGS                -
#   LINK_FLAGS                    -
#   DEPENDENCY_HEADER_TARGETS     -
#   DEPENDENCY_TARGETS_FOR_STATIC -
#   DEPENDENCY_TARGETS_FOR_SHARED -
# see CompileLibraryFunctions.cmake
function(flame_compile_library)
	enable_internal_use()
	internal_compile_library(${ARGN})
endfunction(flame_compile_library)

# Options:
#   DEBUG                -
#   HELP                 -
#   USE_RESOLVER_DEFINES -
# Values:
#   NAME         -
#   ALIAS_NAME   -
#   INSTALL_PATH -
# Lists:
#   INCLUDE_PATHS                 -
#   SOURCE_LIST                   -
#   DEFINES                       -
#   COMPILE_FLAGS                 -
#   LINK_FLAGS                    -
#   DEPENDENCY_HEADER_TARGETS     -
#   DEPENDENCY_TARGETS_FOR_STATIC -
#   DEPENDENCY_TARGETS_FOR_SHARED -
function(flame_compile_binary)
	enable_internal_use()
	internal_compile_binary(${ARGN})
endfunction(flame_compile_binary)

function(flame_resolve_targets)
	enable_internal_use()
	internal_resolve_targets()
endfunction(flame_resolve_targets)

# NAME           - Name of taget
# TARGET_TYPE    - Target type (HEADER, OBJECT, STATIC or SHARED)
# PROPERTY_NAME  - Name of property
# PROPERTY_VALUE - Value of
function(flame_target_add_property)
	enable_internal_use()
	internal_target_add_property(${ARGN})
endfunction(flame_target_add_property)

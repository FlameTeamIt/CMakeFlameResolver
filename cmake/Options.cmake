# common options

option(FLAME_CMAKE_DEBUG
	"Print debug messages"
	OFF
)

option(FLAME_CMAKE_DEBUG_SHOW_PARSE_RESULTS
	"Print debug messages with parse results"
	OFF
)

option(FLAME_PRINT_COMMON_STATISTIC
	"Print statistic about targets. Not support"
	OFF
)

option(FLAME_PRINT_COMMON_STATISTIC
	"Print detailed statistic about targets with add files, flags and etc. Not support"
	OFF
)

option(FLAME_LOGGING
	"Show log messages"
	ON
)

option(FLAME_THREADING
	"Use native threads"
	ON
)

option(FLAME_TESTING
	"Enable testing. Not support"
	ON
)

option(FLAME_LOCAL_INSTALL
	"Installing to local directory (<binary directory>/install). Not support"
	OFF
)

# code generation options

option(FLAME_ONLY_POSITION_INDEPENDENT_OBJECTS
	"Static and shared libraries are using one object library"
	ON
)
option(FLAME_MAKE_STATIC
	"Creating static libraries"
	ON
)
option(FLAME_MAKE_SHARED
	"Creating shared libraries"
	ON
)

option(FLAME_MAKE_STANDALONE
	"Make all modules as standalone. Not support"
	OFF
)

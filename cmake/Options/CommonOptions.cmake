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

option(FLAME_PRINT_DETAILED_STATISTIC
	"Print detailed statistic about targets with add files, flags and etc. Not support"
	OFF
)

option(FLAME_LOGGING
	"Show log messages"
	ON
)

option(FLAME_CLEAN_AFTER_RESOLVE
	"Clean global properties after resove dependencies"
	ON
)

option(FLAME_THREADING
	"Use native threads"
	ON
)

option(FLAME_TESTING
	"Enable testing"
	ON
)

option(FLAME_INSTALL
	"Enable adding install target"
	OFF
)

option(FLAME_LOCAL_INSTALL
	"Install to local directory (<binary directory>/install)"
	OFF
)

option(FLAME_CMAKE_PACKAGING
	"Enable helpers for creating CMake packages"
	ON
)

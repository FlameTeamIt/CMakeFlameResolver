# code generation and install options

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

option(FLAME_ALL_EXPORT_SYMBOLS
	"Export all symbols from shared libraries"
	ON
)

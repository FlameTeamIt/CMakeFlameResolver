cmake_minimum_required(VERSION 3.14)
project(CMakeFlameResolver VERSION 1.3)

include(GNUInstallDirs) # for FHS paths
include(CMakePackageConfigHelpers) # for package versions

install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
	DESTINATION "${CMAKE_INSTALL_DATADIR}/cmake/CMakeFlameResolver")

configure_package_config_file("${CMAKE_CURRENT_SOURCE_DIR}/CMakeFlameResolverConfig.cmake.in" "${CMAKE_CURRENT_BINARY_DIR}/CMakeFlameResolverConfig.cmake"
	INSTALL_DESTINATION "${CMAKE_INSTALL_DATADIR}/cmake/CMakeFlameResolver/CMakeFlameResolverConfig.cmake")

write_basic_package_version_file(${CMAKE_CURRENT_BINARY_DIR}/CMakeFlameResolverConfigVersion.cmake COMPATIBILITY SameMajorVersion ARCH_INDEPENDENT)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/CMakeFlameResolverConfig.cmake"
	"${CMAKE_CURRENT_BINARY_DIR}/CMakeFlameResolverConfigVersion.cmake"
	DESTINATION "${CMAKE_INSTALL_DATADIR}/cmake/CMakeFlameResolver")

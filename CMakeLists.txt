cmake_minimum_required(VERSION 3.14.0)

project(crosspod LANGUAGES CXX)

set(PROJECT_VERSION_MAJOR 0)
set(PROJECT_VERSION_MINOR 1)
set(PROJECT_VERSION_PATCH 0)
set(PROJECT_VERSION
    ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH})
set(PROJECT_MAINTAINER "Ernesto Cruz Olivera")
set(PROJECT_MAINTAINER_EMAIL "ernesto@ecruzolivera.tech")
set(PROJECT_GIT_URL "https://gitlab.com/ecruzolivera/crosspod")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# compiler options
include(cmake/StandardProjectSettingsConfig.cmake)

add_library(project_options_and_warnings INTERFACE)

# standard compiler warnings
include(cmake/CompilerOptionsAndWarningsConfig.cmake)
set_project_options_and_warnings(project_options_and_warnings)

# enable doxygen
include(cmake/DoxygenConfig.cmake)

# project satinizers
include(cmake/Sanitizers.cmake)
enable_sanitizers(project_options_and_warnings)

# static analyzers
include(cmake/CppCheckConfig.cmake)
include(cmake/ClangTidyConfig.cmake)
# include(cmake/StaticAnalyzers.cmake)

# Rust integration
find_package(Corrosion REQUIRED)
corrosion_import_crate(MANIFEST_PATH crosspod-rs/Cargo.toml)

add_subdirectory(app)

option(ENABLE_TESTING "Enable Test Builds" ON)

if(ENABLE_TESTING)
  message(STATUS "Building Tests")
  include(CTest)
  add_subdirectory(test)
endif()

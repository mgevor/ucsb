# Speedb:
# https://github.com/speedb-io/speedb/blob/main/CMakeLists.txt

set(PREFIX_DIR ${CMAKE_BINARY_DIR}/_deps)

include(ExternalProject)

ExternalProject_Add(
    speedb_external

    GIT_REPOSITORY "https://github.com/speedb-io/speedb.git"
    GIT_TAG speedb/v2.4.1
    GIT_SHALLOW 1
    GIT_PROGRESS 0
    
    PREFIX "${PREFIX_DIR}"
    DOWNLOAD_DIR "${PREFIX_DIR}/speedb-src"
    LOG_DIR "${PREFIX_DIR}/speedb-log"
    STAMP_DIR "${PREFIX_DIR}/speedb-stamp"
    TMP_DIR "${PREFIX_DIR}/speedb-tmp"
    SOURCE_DIR "${PREFIX_DIR}/speedb-src"
    INSTALL_DIR "${PREFIX_DIR}/speedb-install"
    BINARY_DIR "${PREFIX_DIR}/speedb-build"

    BUILD_ALWAYS 0
    UPDATE_COMMAND ""

    CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX_DIR}/speedb-install
    -DCMAKE_INSTALL_LIBDIR=lib
    -DCMAKE_INSTALL_RPATH:PATH=<INSTALL_DIR>/lib
    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
    -DENABLE_STATIC:STRING=ON
    -DENABLE_CPPSUITE:BOOL=OFF
    -DCMAKE_C_FLAGS=-Wno-maybe-uninitialized
    -DCMAKE_CXX_FLAGS=-Wno-unused-variable
    -DENABLE_PYTHON:BOOL=OFF
    -DENABLE_LLVM:BOOL=OFF
    -DHAVE_UNITTEST:BOOL=OFF
    -DENABLE_SHARED:BOOL=OFF
    -DWITH_JNI:BOOL=OFF
    -DWITH_TESTS:BOOL=OFF
    -DWITH_BENCHMARK_TOOLS:BOOL=OFF
    -DWITH_TOOLS:BOOL=OFF
    -DWITH_CORE_TOOLS:BOOL=OFF
)

set(speedb_INCLUDE_DIR ${PREFIX_DIR}/speedb-src/include)
set(speedb_LIBRARY_PATH ${PREFIX_DIR}/speedb-install/lib/libspeedb.a)

file(MAKE_DIRECTORY ${speedb_INCLUDE_DIR})
add_library(speedb STATIC IMPORTED)

set_property(TARGET speedb PROPERTY IMPORTED_LOCATION ${speedb_LIBRARY_PATH})
set_property(TARGET speedb APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${speedb_INCLUDE_DIR})

include_directories(${speedb_INCLUDE_DIR})
add_dependencies(speedb speedb_external)
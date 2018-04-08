cmake_minimum_required(VERSION 3.9)
project(test17)

set(CMAKE_CXX_STANDARD 17)

find_package(OpenMP)
if (OPENMP_FOUND)
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
    set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}")
endif()

find_package(Boost 1.66 COMPONENTS system filesystem REQUIRED)
include_directories(${Boost_INCLUDE_DIRS})

find_library(QL_LIBRARY QuantLib)
find_path(QL_INCLUDE ql/version.hpp)

# Extract QL_VERSION and QL_LIB_VERSION from <ql/version.hpp>
# Disregards ${QL_VERSION}-debug suffix.
set(QL_VERSION 0)
set(QL_LIB_VERSION "")
file(STRINGS "${QL_INCLUDE}/ql/version.hpp" _ql_VERSION_HPP_CONTENTS REGEX "#define QL_(LIB_)?VERSION ")
set(_QL_VERSION_REGEX "\"([0-9.]+)\"")
set(_QL_LIB_VERSION_REGEX "\"([0-9_]+)\"")
foreach(v VERSION LIB_VERSION)
    if("${_ql_VERSION_HPP_CONTENTS}" MATCHES "#define QL_${v} ${_QL_${v}_REGEX}")
        set(QL_${v} "${CMAKE_MATCH_1}")
    endif()
endforeach()

message(STATUS "QuantLib version: ${QL_VERSION}")
message(STATUS "QuantLib library version: ${QL_LIB_VERSION}")

unset(_boost_VERSION_HPP_CONTENTS)

message(STATUS "Found QuantLib library: ${QuantLib_LIBRARY}")
message(STATUS "Found QuantLib include: ${QuantLib_INCLUDE}")
add_executable(main main.cpp)
target_link_libraries(main ${Boost_LIBRARIES})
target_link_libraries(main ${QL_LIBRARY})

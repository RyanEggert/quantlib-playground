
### VARIABLES
# QuantLib_VERSION
# QuantLib_LIB_VERSION
# QuantLib_LIBRARY
# QuantLib_INCLUDE

find_library(QuantLib_LIBRARY QuantLib)
find_path(QuantLib_INCLUDE ql/version.hpp)

# Extract QuantLib_VERSION and QuantLib_LIB_VERSION from <ql/version.hpp>
# Disregards ${QuantLib_VERSION}-debug suffix.
# Adapted from Boost version.hpp checker
set(QuantLib_VERSION 0)
set(QuantLib_LIB_VERSION "")
file(STRINGS "${QuantLib_INCLUDE}/ql/version.hpp" _QuantLib_VERSION_HPP_CONTENTS REGEX "#define QL_(LIB_)?VERSION ")
set(_QuantLib_VERSION_REGEX "\"([0-9.]+)\"")
set(_QuantLib_LIB_VERSION_REGEX "\"([0-9_]+)\"")
foreach(v VERSION LIB_VERSION)
    if("${_QuantLib_VERSION_HPP_CONTENTS}" MATCHES "#define QL_${v} ${_QuantLib_${v}_REGEX}")
        set(QuantLib_${v} "${CMAKE_MATCH_1}")
    endif()
endforeach()
unset(_QuantLib_VERSION_HPP_CONTENTS)

if(NOT QuantLib_FIND_QUIETLY)
    message(STATUS "QuantLib version: ${QuantLib_VERSION}")
    message(STATUS "  path: ${QuantLib_INCLUDE}")
endif()


cmake_minimum_required(VERSION 3.9)
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)

project(quantlib-playground)
set(CMAKE_CXX_STANDARD 17)

find_package(OpenMP)
if (OPENMP_FOUND)
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
    set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}")
endif()

find_package(Boost 1.66 COMPONENTS system filesystem REQUIRED)
include_directories(${Boost_INCLUDE_DIRS})

find_package(QuantLib)

add_executable(main main.cpp)
target_link_libraries(main ${Boost_LIBRARIES})
target_link_libraries(main ${QL_LIBRARY})

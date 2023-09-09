cmake_minimum_required(VERSION 3.13 FATAL_ERROR)

project(compliance_one)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(CRUDPP_PATH "Path to the crudpp repository" ${CMAKE_CURRENT_SOURCE_DIR})

set(CMAKE_PREFIX_PATH "${CRUDPP_PARTH};${CMAKE_PREFIX_PATH}")
add_subdirectory(${CRUDPP_PATH} ${CMAKE_BINARY_DIR}/crudpp)
include_directories(${CRUDPP_PATH}/include)

set(AGGREGATES
    ${CMAKE_CURRENT_SOURCE_DIR}/sovereignty.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/country.hpp)

set(SERVER_SOURCES
    ${AGGREGATES}
    ${CMAKE_CURRENT_SOURCE_DIR}/ctrl_macro.cpp)

make_drogon_server()

option(VERDIGRIS_PATH "Path to the verdigris repository" ${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${VERDIGRIS_PATH}/src)

set(CLIENT_SOURCES
    ${AGGREGATES}
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/ressources/compliance_one.qrc
)

make_qt_client()

cmake_minimum_required(VERSION 3.13 FATAL_ERROR)

project(compliance_one)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(CRUDPP_PATH "Path to the crudpp repository" ${CMAKE_CURRENT_SOURCE_DIR})

set(CMAKE_PREFIX_PATH "${CRUDPP_PARTH};${CMAKE_PREFIX_PATH}")
add_subdirectory(${CRUDPP_PATH} ${CMAKE_BINARY_DIR}/crudpp)

make_all(
    INCLUDE ${CMAKE_CURRENT_SOURCE_DIR}/compliance_one.hpp
    USER_CLASS user
    CLASSES
        sovereignty
        country
        product_group
        product
        contact
        individual
    EXTRA_CLIENT_SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/ressources/compliance_one.qrc)

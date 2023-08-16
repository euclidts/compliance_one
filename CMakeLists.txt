cmake_minimum_required(VERSION 3.13 FATAL_ERROR)

project(compliance_one)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(CRUDPP_PATH "Path to the crudpp repository" ${CMAKE_CURRENT_SOURCE_DIR})

set(CMAKE_PREFIX_PATH "${CRUDPP_PARTH};${CMAKE_PREFIX_PATH}")
add_subdirectory(${CRUDPP_PATH} ${CMAKE_BINARY_DIR}/crudpp)
include_directories(${CRUDPP_PATH}/include)

set(AGGREGATES
    ${CMAKE_CURRENT_SOURCE_DIR}/sovereignty.hpp)

set(SERVER_SOURCES
    ${AGGREGATES}
    ${CMAKE_CURRENT_SOURCE_DIR}/ctrl_macro.cpp)

make_drogon_server()

## Temporary used for the client side

set(CMAKE_AUTOUIC OFF)
set(CMAKE_AUTOMOC OFF)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS
    Core
    Quick)

set(CLIENT_SOURCES
    ${AGGREGATES}
    main.cpp
    # temporarry path
    visitors/json_reader.hpp
    wrappers/list.hpp
    wrappers/model.hpp
    wrappers/utils.hpp
    wrappers/controller.hpp
)

option(VERDIGRIS_PATH "Path to the verdigris repository" ${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${VERDIGRIS_PATH}/src)

qt_add_executable(${PROJECT_NAME}
    MANUAL_FINALIZATION
    ${CLIENT_SOURCES}
    wrappers/controller.hpp)

target_compile_definitions(${PROJECT_NAME}
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Core
    Qt6::Quick)

qt_import_qml_plugins(${PROJECT_NAME})

qt_finalize_executable(${PROJECT_NAME})

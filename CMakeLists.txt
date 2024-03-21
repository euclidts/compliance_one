cmake_minimum_required(VERSION 3.13 FATAL_ERROR)

project(compliance_one)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED 20)

option(CRUDPP_PATH "Path to the crudpp repository" ${CMAKE_CURRENT_SOURCE_DIR})

set(CMAKE_PREFIX_PATH "${CRUDPP_PARTH};${CMAKE_PREFIX_PATH}")
add_subdirectory(${CRUDPP_PATH} ${CMAKE_BINARY_DIR}/crudpp)

make_all(
   INCLUDE ${CMAKE_CURRENT_SOURCE_DIR}/compliance_one.hpp
   USER_CLASS user
   CLASSES
       country
       product_group
       product
       ctp_group
       ctp_type
       contact
       address
       individual
       company
       vessel
   EXTRA_CLIENT_SOURCES
       ${CMAKE_CURRENT_SOURCE_DIR}/resources/compliance_one.qrc
   )

if(NOT ANDROID AND NOT IOS AND CMAKE_BUILD_TYPE STREQUAL "Release")
    set(COMPONENT_NAME_MAIN "${PROJECT_NAME}")
    set(COMPONENT_NAME_DEPENDENCIES "RuntimeLibs")

    include(GNUInstallDirs)
    install(TARGETS ${PROJECT_NAME}
            DESTINATION ${CMAKE_INSTALL_BINDIR}
            COMPONENT ${COMPONENT_NAME_MAIN})

    if(MINGW)
        message(STATUS "Installing system-libraries: MinGW DLLs.")
        get_target_property(QMAKE_EXECUTABLE Qt::qmake IMPORTED_LOCATION)
        get_filename_component(QT_BINARY_DIR "${QMAKE_EXECUTABLE}" DIRECTORY)
        set(CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS
            ${QT_BINARY_DIR}/libgcc_s_seh-1.dll
            ${QT_BINARY_DIR}/libstdc++-6.dll
            ${QT_BINARY_DIR}/libwinpthread-1.dll)
    endif()

    set(CMAKE_INSTALL_SYSTEM_RUNTIME_COMPONENT ${COMPONENT_NAME_DEPENDENCIES})
    include(InstallRequiredSystemLibraries)

    set(CPACK_GENERATOR "IFW")
    set(CPACK_IFW_PACKAGE_NAME "${PROJECT_NAME}")
    set(CPACK_IFW_PACKAGE_TITLE "${PROJECT_NAME}")
    set(CPACK_IFW_PACKAGE_PUBLISHER "${PROJECT_NAME}")
    set(CPACK_IFW_PACKAGE_WIZARD_STYLE "Classic")
    set(CPACK_IFW_PACKAGE_WIZARD_SHOW_PAGE_LIST OFF)

    set(CPACK_RESOURCE_FILE_LICENSE ${CMAKE_CURRENT_SOURCE_DIR}/LICENSE)

    if (WIN32)
        find_program(WINDEPLOYQT windeployqt HINTS "${_qt_bin_dir}")
        configure_file("${CMAKE_CURRENT_SOURCE_DIR}/ci/deploy-qt-windows.cmake.in"
            "${CMAKE_CURRENT_SOURCE_DIR}/deploy-qt-windows.cmake" @ONLY)

        if(CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS)
            install(PROGRAMS ${CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS}
                DESTINATION ${CMAKE_INSTALL_BINDIR}
                COMPONENT ${COMPONENT_NAME_MAIN})
        endif()

        set(CPACK_IFW_PACKAGE_ICON "${CMAKE_CURRENT_SOURCE_DIR}/resources/icons/C1_logov1.ico")
        set(CPACK_IFW_PACKAGE_LOGO "${CMAKE_CURRENT_SOURCE_DIR}/resources/icons/C1_logov1.ico")
        set(CPACK_PRE_BUILD_SCRIPTS ${CMAKE_CURRENT_SOURCE_DIR}/deploy-qt-windows.cmake)
    endif()

    include(CPack)
    include(CPackIFW)

    CPACK_ADD_COMPONENT(${COMPONENT_NAME_MAIN})

    cpack_ifw_configure_component(${COMPONENT_NAME_DEPENDENCIES} VIRTUAL FORCED_INSTALLATION)
    cpack_ifw_configure_component(${COMPONENT_NAME_MAIN} ESSENTIAL FORCED_INSTALLATION)
    cpack_ifw_configure_component(${COMPONENT_NAME_MAIN} LICENSES
        "LGPL License" ${CPACK_RESOURCE_FILE_LICENSE})
    cpack_ifw_configure_component(${COMPONENT_NAME_MAIN} SCRIPT
        ${CMAKE_CURRENT_SOURCE_DIR}/ci/installScript.qs)
endif()

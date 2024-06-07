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
       region
       country
       product_group
       product
       company_group
       company_type
       exchange
       regulator
       jurisdiction
       contact
       address
       individual
       individual_view
       company
       company_view
       vessel
    CLIENT_RESOURCE_DIR
       ${CMAKE_CURRENT_SOURCE_DIR}/resources
   )

if(CMAKE_BUILD_TYPE STREQUAL "Release")
    if(WIN32)
        # Installer setup copyed from
        # https://github.com/christopro/AwesomeWorld-Cmake/blob/main/AwesomeWorld/CMakeList.txt
        set(COMPONENT_NAME_MAIN "${PROJECT_NAME}")
        set(COMPONENT_NAME_DEPENDENCIES "RuntimeLibs")

        install(TARGETS ${PROJECT_NAME}
            DESTINATION ${CMAKE_INSTALL_BINDIR}
            COMPONENT ${COMPONENT_NAME_MAIN})

        set(CMAKE_INSTALL_SYSTEM_RUNTIME_COMPONENT ${COMPONENT_NAME_DEPENDENCIES})

        find_program(WINDEPLOYQT windeployqt HINTS "${_qt_bin_dir}")
        configure_file("${CMAKE_CURRENT_SOURCE_DIR}/ci/deploy-qt-windows.cmake.in"
            "${CMAKE_CURRENT_SOURCE_DIR}/ci/deploy-qt-windows.cmake"
            @ONLY)

        set(CPACK_GENERATOR "IFW")
        set(CPACK_IFW_PACKAGE_NAME "${PROJECT_NAME}")
        set(CPACK_IFW_PACKAGE_TITLE "${PROJECT_NAME}")
        set(CPACK_IFW_PACKAGE_PUBLISHER "${PROJECT_NAME}")
        set(CPACK_IFW_PACKAGE_WIZARD_STYLE "Classic")
        set(CPACK_IFW_PACKAGE_WIZARD_SHOW_PAGE_LIST OFF)
        set(CPACK_IFW_PACKAGE_ICON "${CMAKE_CURRENT_SOURCE_DIR}/resources/icons/C1_logov1.ico")
        set(CPACK_IFW_PACKAGE_LOGO "${CMAKE_CURRENT_SOURCE_DIR}/resources/icons/C1_logov1.ico")
        set(CPACK_PRE_BUILD_SCRIPTS ${CMAKE_CURRENT_SOURCE_DIR}/ci/deploy-qt-windows.cmake)
        set(CPACK_RESOURCE_FILE_LICENSE ${CMAKE_CURRENT_SOURCE_DIR}/LICENSE)

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

    # if(APPLE)
    #     set_target_properties(${PROJECT_NAME} PROPERTIES
    #         MACOSX_BUNDLE TRUE
    #         MACOSX_BUNDLE_ICON_FILE ${ICON_NAME})

    #     find_program(MACDEPLOYQT macdeployqt HINTS "${_qt_bin_dir}")

    #     add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    #         COMMAND ${MACDEPLOYQT} ${CMAKE_BINARY_DIR}"/bin/${PROJECT_NAME}.app"
    #         -qmldir"=${CMAKE_CURRENT_SOURCE_DIR}"
    #         -dmg)
    # endif()
endif()

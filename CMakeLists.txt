cmake_minimum_required(VERSION 3.16)

project(todo_manager VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(apptodo_manager
    main.cpp
)

qt_add_qml_module(apptodo_manager
    URI todo_manager
    VERSION 1.0
    QML_FILES
        Main.qml
    SOURCES taskmanager.h taskmanager.cpp task.h task.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(apptodo_manager PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.apptodo_manager
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(apptodo_manager
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS apptodo_manager
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

cmake_minimum_required(VERSION 3.20)

project(todo_manager VERSION 0.1 LANGUAGES CXX)

#Нереализованная часть обработки на C++( альтернативный вариант), можно отключить
set(MY_CPP_INTEGRATION ON)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

#Блок опциональной интеграции

if (${MY_CPP_INTEGRATION})
    qt_add_executable(apptodo_manager
        main.cpp
    )

    qt_add_qml_module(apptodo_manager
        URI todo_manager
        VERSION 1.0
        QML_FILES
            Main.qml
            Delegator.qml
            Topbar.qml
        SOURCES
            taskmanager.h
            taskmanager.cpp
            task.h
            task.cpp
        RESOURCES external_res.qrc
    )
else()
    qt_add_executable(apptodo_manager
        NoManagermain.cpp
    )

    qt_add_qml_module(apptodo_manager
        URI todo_manager
        VERSION 1.0
        QML_FILES
            NoManagerMain.qml
            Delegator.qml
            Topbar.qml
        RESOURCES external_res.qrc
    )
endif()

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

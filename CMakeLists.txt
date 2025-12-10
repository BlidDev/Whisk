cmake_minimum_required(VERSION 3.19)
project(Whisk VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXE_LINKER_FLAGS "-fuse-ld=gold")


include("cmake/settings.cmake")

#set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "Disable GLFW examples")
#set(GLFW_BUILD_TESTS OFF CACHE BOOL "Disable GLFW tests")
#set(GLFW_BUILD_DOCS OFF CACHE BOOL "Disable GLFW docs")
#set(GLFW_STATIC TRUE CACHE BOOL "Set to build as static library")
#add_subdirectory("vendor/glfw")

add_subdirectory("vendor/dou_engine")

set(OUT_PATH "${CMAKE_SOURCE_DIR}/bin/${CMAKE_SYSTEM_NAME} - ${CMAKE_SYSTEM_PROCESSOR}/${CMAKE_BUILD_TYPE}")

set(NAME whisk)
file(GLOB whisk_SRC
    "src/*.c"
    "src/*.cpp"
    )

file(GLOB editor_SRC
    "vendor/imgui/*.cpp"
    "vendor/ImGuizmo/*.cpp"
    "vendor/imgui/backends/*.cpp"
    "vendor/imgui/misc/cpp/*.cpp"
    "vendor/tinyfiledialogs/tinyfiledialogs.cpp"
)

add_executable(${NAME} ${${NAME}_SRC} ${editor_SRC})

set_target_properties(${NAME} 
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${OUT_PATH}"
)
set_target_properties(${NAME} 
    PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY "${OUT_PATH}"
)

target_include_directories(${NAME} PRIVATE
    "include"
    "vendor/include"
    "vendor/dou_engine/vendor/glfw/include"
    "vendor/dou_engine/vendor/glad/include"
    "vendor/dou_engine/vendor/glm"
    "vendor/imgui"
    "vendor/ImGuizmo"
    "vendor/imgui/backends"
    "vendor/tinyfiledialogs"
    "vendor/google_md"
)


set(HEADER_FILES PRIVATE 
    "vendor/dou_engine/engine/include/epch.h"
    "vendor/dou_engine/engine/include/engine.h"
    "vendor/google_md/IconsMaterialDesign.h"
)

find_package(OpenGL REQUIRED)

target_precompile_headers(${NAME} PRIVATE ${HEADER_FILES})
target_compile_definitions(${NAME} PUBLIC IMGUI_IMPL_OPENGL_LOADER_CUSTOM)

if(UNIX AND NOT APPLE)
    target_link_libraries(${NAME} PRIVATE
        X11
        Xi
        Xcursor
        Xrandr
        Xinerama
    )
endif()


target_link_libraries(${NAME} PRIVATE OpenGL::GL engine)

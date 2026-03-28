set(NAME whisk)
set(VENDOR "${DYNAMIC_SOURCE}/vendor")

file(GLOB_RECURSE whisk_SRC 
    "src/*.cpp" 
    "src/*.c"
    "include/*.h" 
    "include/*.hpp"
)

file(GLOB editor_SRC
    "${DYNAMIC_SOURCE}/shared/src/*.cpp" 
    "${DYNAMIC_SOURCE}/shared/src/*.c"
    "${DYNAMIC_SOURCE}/vendor/imgui/*.cpp"
    "${VENDOR}/ImGuizmo/*.cpp"
    "${VENDOR}/imgui/backends/*.cpp"
    "${VENDOR}/imgui/misc/cpp/*.cpp"
    "${VENDOR}/tinyfiledialogs/tinyfiledialogs.cpp"
)

add_executable(${NAME} ${${NAME}_SRC} ${editor_SRC})
source_group(TREE "${CMAKE_CURRENT_SOURCE_DIR}" FILES ${whisk_SRC})


target_include_directories(${NAME} PRIVATE
    "include"
    "${DYNAMIC_SOURCE}/shared/include"
    "${VENDOR}/dou_engine/vendor/glfw/include"
    "${VENDOR}/dou_engine/vendor/glad/include"
    "${VENDOR}/dou_engine/vendor/glm"
    "${VENDOR}/imgui"
    "${VENDOR}/ImGuizmo"
    "${VENDOR}/imgui/backends"
    "${VENDOR}/tinyfiledialogs"
    "${VENDOR}/google_md"
)


set(HEADER_FILES PRIVATE 
    "${VENDOR}/dou_engine/engine/include/epch.h"
    "${VENDOR}/dou_engine/engine/include/engine.h"
    "${VENDOR}/google_md/IconsMaterialDesign.h"
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
set(NAME player)
set(VENDOR "${DYNAMIC_SOURCE}/vendor")

file(GLOB_RECURSE player_SRC 
    "src/*.cpp" 
    "src/*.c"
    "include/*.h" 
    "include/*.hpp"
)

file(GLOB backend_SRC
    "${DYNAMIC_SOURCE}/shared/src/*.cpp" 
    "${DYNAMIC_SOURCE}/shared/src/*.c"
)

add_executable(${NAME} ${${NAME}_SRC} ${backend_SRC})
source_group(TREE "${CMAKE_CURRENT_SOURCE_DIR}" FILES ${player_SRC})


target_include_directories(${NAME} PRIVATE
    "include"
    "${DYNAMIC_SOURCE}/shared/include"
    #"${VENDOR}/dou_engine/vendor/glfw/include"
    #"${VENDOR}/dou_engine/vendor/glad/include"
    #"${VENDOR}/dou_engine/vendor/glm"
)


set(HEADER_FILES PRIVATE 
    "${VENDOR}/dou_engine/engine/include/epch.h"
    "${VENDOR}/dou_engine/engine/include/engine.h"
)

find_package(OpenGL REQUIRED)

target_precompile_headers(${NAME} PRIVATE ${HEADER_FILES})

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
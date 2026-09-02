local WSK_ROOT = _MAIN_SCRIPT_DIR


local SHARED_FILES = {
    "shared/src/**.cpp",
    "shared/src/**.c",
    "shared/include/**.h",
    "shared/include/**.hpp"
}


workspace "WhiskEditor"
    architecture "x86_64"
    configurations { "Debug", "Release" }

    location "build"
    pic "On"

    debugdir "%{WSK_ROOT}"
    targetdir "bin/%{cfg.buildcfg}"
    objdir "build/bin-int/%{cfg.buildcfg}/%{prj.name}"

    filter "configurations:Debug"
        symbols "On"

    filter "configurations:Release"
        optimize "Speed"


    filter "toolset:gcc"
        buildoptions { "-fdiagnostics-color=always" }

    filter "toolset:clang"
        buildoptions { "-fcolor-diagnostics" }

    filter {}


-- = ENGINE INCLUDE ===========================================
DOU_STANDALONE = false
local dou_vars = include(WSK_ROOT .. "/vendor/dou_engine/premake5")
local DOU_ROOT = "vendor/dou_engine"
-- ============================================================

project "editor"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"

    targetdir "bin/%{cfg.buildcfg}"
    objdir "build/bin-int/%{cfg.buildcfg}/%{prj.name}"

    files {
        "editor/src/**.cpp",
        "editor/src/**.c",
        "editor/include/**.h",
        "editor/include/**.hpp",

        SHARED_FILES,

        "vendor/imgui/*.cpp",
        "vendor/imgui/backends/*.cpp",
        "vendor/imgui/misc/cpp/*.cpp",
        "vendor/ImGuizmo/*.cpp",
        "vendor/tinyfiledialogs/tinyfiledialogs.cpp",
        DOU_ROOT .. "/engine/src/epch.cpp"
    }

    includedirs(dou_vars.get_dou_includes(DOU_ROOT))

    includedirs {
        "editor/include",
        "shared/include",

        "vendor/imgui",
        "vendor/ImGuizmo",
        "vendor/imgui/backends",
        "vendor/tinyfiledialogs",
        "vendor/google_md"
    }

    defines {
        --"IMGUI_IMPL_OPENGL_LOADER_CUSTOM"
    }


    libdirs {
        DOU_ROOT .. "/bin/%{cfg.buildcfg}",
        DOU_ROOT .. "/vendor/bin/%{cfg.buildcfg}/Glad",
        DOU_ROOT .. "/vendor/bin/%{cfg.buildcfg}/YAML_CPP",
        DOU_ROOT .. "/vendor/bin/%{cfg.buildcfg}/GLFW"
    }

    link_dou_engine(DOU_ROOT)

    pchheader "epch.h"
    pchsource (DOU_ROOT .. "/engine/src/epch.cpp")

    dou_vars.utf8_filter()
    filter "system:linux"
        links {
            "GL",
            "X11",
            "Xi",
            "Xcursor",
            "Xrandr",
            "Xinerama"
        }

    filter {}




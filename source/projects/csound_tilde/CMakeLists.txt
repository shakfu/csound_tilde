include(${CMAKE_CURRENT_SOURCE_DIR}/../../max-sdk-base/script/max-pretarget.cmake)

#############################################################
# csound~
#############################################################


# list(APPEND CMAKE_PREFIX_PATH
#     "/usr/local"
#     "/usr/opt"
#     "$ENV{HOME}/Library/Frameworks"
#     $<${HAS_HOMEBREW}:${HOMEBREW_PREFIX}>
# )

message(STATUS "CMAKE_PREFIX_PATH:  ${CMAKE_PREFIX_PATH}")

include_directories( 
    "${MAX_SDK_INCLUDES}"
    "${MAX_SDK_MSP_INCLUDES}"
    "${MAX_SDK_JIT_INCLUDES}"
)

set(SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)
set(SCRIPTS_DIR ${CMAKE_SOURCE_DIR}/source/scripts)

set(PROJECT_SRC
    ${SRC_DIR}/Args.cpp
    ${SRC_DIR}/atom_buffer.cpp
    ${SRC_DIR}/channel.cpp
    ${SRC_DIR}/CsoundObject.cpp
    ${SRC_DIR}/CsoundTable.cpp
    ${SRC_DIR}/csound~.cpp
    ${SRC_DIR}/Lock.cpp
    ${SRC_DIR}/memory.cpp
    ${SRC_DIR}/message_buffer.cpp
    ${SRC_DIR}/midi.cpp
    ${SRC_DIR}/PatchScripter.cpp
    ${SRC_DIR}/sequencer.cpp
    ${SRC_DIR}/util.cpp
)

set(PROJECT_HEADERS
    ${SRC_DIR}/Args.h
    ${SRC_DIR}/CsoundObject.h
    ${SRC_DIR}/CsoundTable.h
    ${SRC_DIR}/Lock.h
    ${SRC_DIR}/Parser.h
    ${SRC_DIR}/PatchScripter.h
    ${SRC_DIR}/atom_buffer.h
    ${SRC_DIR}/channel.h
    ${SRC_DIR}/csound~.h
    ${SRC_DIR}/definitions.h
    ${SRC_DIR}/eksepshun.h
    ${SRC_DIR}/includes.h
    ${SRC_DIR}/max_headers.h
    ${SRC_DIR}/memory.h
    ${SRC_DIR}/message_buffer.h
    ${SRC_DIR}/midi.h
    ${SRC_DIR}/sequencer.h
    ${SRC_DIR}/util.h
)

if(APPLE)
    message(STATUS "building on macOS")

    set(CMAKE_OSX_DEPLOYMENT_TARGET 10.13 CACHE STRING 
        "override default MACOS_DEPLOYMENT_TARGET" FORCE)

    if(BUILD_RELEASE)
        include(${SCRIPTS_DIR}/macos_release.cmake)

    else()
        include(${SCRIPTS_DIR}/macos_common.cmake)        

        if(BUILD_HYBRID)
            include(${SCRIPTS_DIR}/macos_hybrid.cmake)
        
        else()
            include(${SCRIPTS_DIR}/macos_local.cmake)
        
        endif()

    endif()

elseif(WIN32)
    message(STATUS "building on Windows")

    # added windows-specific source
    list(APPEND PROJECT_SRC ${SRC_DIR}/dllmain_win.c)

    include(${SCRIPTS_DIR}/windows_release.cmake)

else()
    message(FATAL_ERROR "can only build on macOS or windows")

endif()


include(${CMAKE_CURRENT_SOURCE_DIR}/../../max-sdk-base/script/max-posttarget.cmake)

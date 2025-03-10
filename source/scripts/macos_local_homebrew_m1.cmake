# --------------------------------------------------------------------
# Local or Non-Relocatable build

add_library( 
    ${PROJECT_NAME} 
    MODULE
    ${PROJECT_SRC}
    ${PROJECT_HEADERS}
)

# the below is not working on Mac for me so finding and specifying 
# header and library explicitly
# find_package(Csound)

MESSAGE(STATUS "HAS_HOMEBREW: ${HAS_HOMEBREW}")
MESSAGE(STATUS "HOMEBREW_PREFIX: ${HOMEBREW_PREFIX}")

if(APPLE)
    find_path(
        CSOUND_HEADER_PATH
        NAMES csound.h
        PATH_SUFFIXES csound
        PATHS
        $<${HAS_HOMEBREW}:${HOMEBREW_PREFIX}/include>
        $<${HAS_HOMEBREW}:${HOMEBREW_PREFIX}/opt/csound/include>
    )
    find_library(
        CSOUND_LIBRARY 
        NAMES CsoundLib64
        PATH_SUFFIXES Frameworks
        PATHS
        $<${HAS_HOMEBREW}:${HOMEBREW_PREFIX}/opt/csound>
    )
else()
    find_path(CSOUND_HEADER_PATH csound/csound.h)
    find_library(CSOUND_LIBRARY csound64.lib)
endif()

if(CSOUND_HEADER_PATH)
    MESSAGE("found csound header path: ${CSOUND_HEADER_PATH}")
else()
    MESSAGE(FATAL_ERROR "could not find csound header path")
endif()
    
if(CSOUND_LIBRARY)
  MESSAGE("found csound library path: ${CSOUND_LIBRARY}")
else()
  MESSAGE(FATAL_ERROR "could not find csound library path")
endif()

target_include_directories(${PROJECT_NAME}
    PUBLIC
    ${SRC_DIR}
    ${CSOUND_HEADER_PATH}
    $<${HAS_HOMEBREW}:${HOMEBREW_PREFIX}/include>
)

target_compile_definitions(${PROJECT_NAME}
    PUBLIC
    MACOSX
)

target_link_directories(${PROJECT_NAME}
    PUBLIC
    $<${HAS_HOMEBREW}:${HOMEBREW_PREFIX}/lib>
)

target_link_libraries(${PROJECT_NAME}
    PUBLIC
    ${CSOUND_LIBRARY}
    ${LIBSNDFILE_DYLIB}
    "-framework CoreFoundation"
    "-framework CoreServices"
)

    
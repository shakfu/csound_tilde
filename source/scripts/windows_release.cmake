set(DEPS ${CMAKE_BINARY_DIR}/deps)
set(VCPKG_ROOT ${DEPS}/vcpkg)
set(VCPKG_PREFIX ${VCPKG_ROOT}/installed/x64-windows)

list(APPEND CMAKE_PREFIX_PATH
    ${VCPKG_PREFIX}
    "C:/Program Files/Csound6_x64"
)
message(STATUS "CMAKE_PREFIX_PATH:  ${CMAKE_PREFIX_PATH}")

find_package(Boost)
find_library(LIBSNDFILE_LIBRARY sndfile     PATHS ${CMAKE_INCLUDE_PATH})
find_library(LIBOGG_LIBRARY     ogg         PATHS ${CMAKE_INCLUDE_PATH})
find_library(LIBVORBIS_LIBRARY  vorbis      PATHS ${CMAKE_INCLUDE_PATH})
find_library(LIBPTHREAD_LIBRARY pthreadVC3  PATHS ${CMAKE_INCLUDE_PATH})
find_library(LIBFLAC_LIBRARY    flac        PATHS ${CMAKE_INCLUDE_PATH})
find_library(LIBCSOUND_LIBRARY  libcsound64 PATHS ${CMAKE_INCLUDE_PATH})
find_library(LIBSYN123_LIBRARY  syn123      PATHS ${CMAKE_INCLUDE_PATH})

# set(BUILD_SHARED_LIBS OFF)

add_library( ${PROJECT_NAME} 
    MODULE # works if set to STATIC
    ${PROJECT_SRC}
    ${PROJECT_HEADERS}
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
    ${SRC_DIR}
    ${CMAKE_INCLUDE_PATH}
    ${VCPKG_PREFIX}/include
    ${Boost_INCLUDE_DIRS}
    "C:/Program Files/Csound6_x64/include/csound"
)

# target_compile_options(${PROJECT_NAME}
#     PUBLIC
#     "/MT"
# )


target_compile_definitions(${PROJECT_NAME}
    PUBLIC
    WIN_VERSION
    WIN_EXT_VERSION
    _WINDOWS
)

target_link_directories(${PROJECT_NAME}
    PUBLIC
    ${CMAKE_LIBRARY_PATH}
    ${VCPKG_PREFIX}/lib
    "C:/Program Files/Csound6_x64/lib"
)

target_link_options(${PROJECT_NAME}
    PUBLIC
    "-static-libstdc++" 
    "-static-libgcc"
)

# set(CSOUND_WINDOWS_LIBRARIES
#     advapi32
#     comctl32
#     comdlg32
#     glu32
#     kernel32
#     odbc32
#     odbccp32
#     ole32
#     oleaut32
#     shell32
#     user32
#     uuid
#     winmm
#     winspool
#     ws2_32
#     wsock32
# )

target_link_libraries(${PROJECT_NAME}
    PRIVATE
    ws2_32
    ${LIBSNDFILE_LIBRARY}
    ${LIBFLAC_LIBRARY}
    ${LIBOGG_LIBRARY}
    ${LIBCSOUND_LIBRARY}
    ${LIBVORBIS_LIBRARY}
    ${LIBPTHREAD_LIBRARY}
    ${LIBSYN123_LIBRARY}
    # ${CSOUND_WINDOWS_LIBRARIES}
)




set(VCPKG_ROOT ${CMAKE_BINARY_DIR}/deps/vcpkg)
set(VCPKG_PREFIX ${VCPKG_ROOT}/installed/x64-windows-static)
set(DEPS ${CMAKE_BINARY_DIR}/deps)
set(CSOUND_LIBRARY ${DEPS}/csound-build/libCsoundLib64.lib)
set(CSOUND_HEADER_PATH ${DEPS}/csound-build/CsoundLib64.framework/Headers)
set(EXTERNAL_PATH {CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${PROJECT_NAME}.mxe64)

SET(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} "${VCPKG_PACKAGES_DIR}/libsndfile_x64-windows-static/include")
SET(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} "${VCPKG_PACKAGES_DIR}/libvorbis_x64-windows-static/include")
SET(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} "${VCPKG_PACKAGES_DIR}/pthreads_x64-windows/include")
SET(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} "C:/Program Files/Csound6_x64/include/csound")
SET(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} "${VCPKG_PACKAGES_DIR}/libogg_x64-windows-static/include")
SET(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} "${VCPKG_PACKAGES_DIR}/libflac_x64-windows-static/include")

SET(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} "${VCPKG_PACKAGES_DIR}/libsndfile_x64-windows-static/lib")
SET(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} "${VCPKG_PACKAGES_DIR}/libvorbis_x64-windows-static/lib")
SET(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} "${VCPKG_PACKAGES_DIR}/pthreads_x64-windows/lib")
SET(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} "C:/Program Files/Csound6_x64/lib")
SET(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} "${VCPKG_PACKAGES_DIR}/libogg_x64-windows-static/lib")
SET(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} "${VCPKG_PACKAGES_DIR}/libflac_x64-windows-static/lib")


find_library(MAX_AUDIO_FRAMEWORK MaxAudio PATHS ${MSP_LIB_DIR})
find_library(MAX_API_FRAMEWORK MaxAPI PATHS ${MAX_LIB_DIR})
find_library(LIBSNDFILE_LIBRARY libsndfile PATHS ${CMAKE_INCLUDE_PATH})
find_library(LIBOGG_LIBRARY ogg PATHS ${CMAKE_INCLUDE_PATH})
find_library(LIBVORBIS_LIBRARY vorbis PATHS ${CMAKE_INCLUDE_PATH})
find_library(LIBPTHREAD_LIBRARY pthreadVC3 PATHS ${CMAKE_INCLUDE_PATH})
find_library(LIBFLAC_LIBRARY flac PATHS ${CMAKE_INCLUDE_PATH})
find_library(LIBCSOUND_LIBRARY libcsound64 PATHS ${CMAKE_INCLUDE_PATH})

set_target_properties(${MAX_OUTPUT_LIB}
  PROPERTIES LINK_FLAGS "-static-libstdc++ -static-libgcc")
include_directories(${MAX_INCLUDES_DIR})
include_directories(${MSP_INCLUDES_DIR})
include_directories(${Boost_INCLUDE_DIRS})
link_directories(${CMAKE_LIBRARY_PATH})


set_target_properties(${MAX_OUTPUT_LIB} PROPERTIES
    COMPILE_FLAGS "-DWIN_VERSION -DWIN_EXT_VERSION -D_WINDOWS"
    SUFFIX .mxe64
)

target_link_libraries(${MAX_OUTPUT_LIB}  
    ws2_32
    ${LIBSNDFILE_LIBRARY}
    ${LIBFLAC_LIBRARY}
    ${LIBOGG_LIBRARY}
    ${LIBCSOUND_LIBRARY}
    ${LIBVORBIS_LIBRARY}
    ${LIBPTHREAD_LIBRARY}
)
include_directories(${CMAKE_INCLUDE_PATH})
include_directories(${MSP_INCLUDES_DIR})
include_directories(${MAX_INCLUDES_DIR})
include_directories(${Boost_INCLUDE_DIRS})


MESSAGE("CSOUND_HEADER_PATH: ${CSOUND_HEADER_PATH}")

add_library( 
    ${PROJECT_NAME} 
    MODULE
    ${PROJECT_SRC}
    ${PROJECT_HEADERS}
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
    ${SRC_DIR}
    ${CSOUND_HEADER_PATH}
    ${VCPKG_PREFIX}/include
)


target_compile_definitions(${PROJECT_NAME}
    PUBLIC
    MACOSX
)

target_link_directories(${PROJECT_NAME}
    PUBLIC
    ${VCPKG_PREFIX}/lib
)

# set_target_properties(${PROJECT_NAME} PROPERTIES FRAMEWORK YES)

target_link_libraries(${PROJECT_NAME}
    PUBLIC
    ${CSOUND_LIBRARY}
    ${DEPS/libcsnd6.lib}
    ${VCPKG_PREFIX}/lib/libFLAC++.lib
    ${VCPKG_PREFIX}/lib/libFLAC.lib
    # ${VCPKG_PREFIX}/lib/libboost_atomic.lib
    # ${VCPKG_PREFIX}/lib/libboost_chrono.lib
    # ${VCPKG_PREFIX}/lib/libboost_container.lib
    # ${VCPKG_PREFIX}/lib/libboost_date_time.lib
    # ${VCPKG_PREFIX}/lib/libboost_exception.lib
    # ${VCPKG_PREFIX}/lib/libboost_regex.lib
    # ${VCPKG_PREFIX}/lib/libboost_serialization.lib
    # ${VCPKG_PREFIX}/lib/libboost_system.lib
    # ${VCPKG_PREFIX}/lib/libboost_thread.lib
    # ${VCPKG_PREFIX}/lib/libboost_wserialization.lib
    ${VCPKG_PREFIX}/lib/libmp3lame.lib
    ${VCPKG_PREFIX}/lib/libmpg123.lib
    ${VCPKG_PREFIX}/lib/libogg.lib
    ${VCPKG_PREFIX}/lib/libopus.lib
    ${VCPKG_PREFIX}/lib/libout123.lib
    ${VCPKG_PREFIX}/lib/libsndfile.lib
    ${VCPKG_PREFIX}/lib/libsyn123.lib
    ${VCPKG_PREFIX}/lib/libvorbis.lib
    ${VCPKG_PREFIX}/lib/libvorbisenc.lib
    # ${VCPKG_PREFIX}/lib/libvorbisfile.lib
    -lcurl
    "-framework CoreFoundation"
    "-framework CoreServices"
    "-framework Accelerate"
)


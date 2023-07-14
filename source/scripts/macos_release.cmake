
set(VCPKG_ROOT ${CMAKE_BINARY_DIR}/deps/vcpkg)
set(VCPKG_PREFIX ${VCPKG_ROOT}/installed/x64-osx)
set(DEPS ${CMAKE_BINARY_DIR}/deps)
set(CSOUND_LIBRARY ${DEPS}/csound-build/libCsoundLib64.a)
set(CSOUND_HEADER_PATH ${DEPS}/csound-build/CsoundLib64.framework/Headers)
set(EXTERNAL_PATH {CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${PROJECT_NAME}.mxo)

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
    ${DEPS/libcsnd6.a}
    ${VCPKG_PREFIX}/lib/libFLAC++.a
    ${VCPKG_PREFIX}/lib/libFLAC.a
    # ${VCPKG_PREFIX}/lib/libboost_atomic.a
    # ${VCPKG_PREFIX}/lib/libboost_chrono.a
    # ${VCPKG_PREFIX}/lib/libboost_container.a
    # ${VCPKG_PREFIX}/lib/libboost_date_time.a
    # ${VCPKG_PREFIX}/lib/libboost_exception.a
    # ${VCPKG_PREFIX}/lib/libboost_regex.a
    # ${VCPKG_PREFIX}/lib/libboost_serialization.a
    # ${VCPKG_PREFIX}/lib/libboost_system.a
    # ${VCPKG_PREFIX}/lib/libboost_thread.a
    # ${VCPKG_PREFIX}/lib/libboost_wserialization.a
    ${VCPKG_PREFIX}/lib/libmp3lame.a
    ${VCPKG_PREFIX}/lib/libmpg123.a
    ${VCPKG_PREFIX}/lib/libogg.a
    ${VCPKG_PREFIX}/lib/libopus.a
    ${VCPKG_PREFIX}/lib/libout123.a
    ${VCPKG_PREFIX}/lib/libsndfile.a
    ${VCPKG_PREFIX}/lib/libsyn123.a
    ${VCPKG_PREFIX}/lib/libvorbis.a
    ${VCPKG_PREFIX}/lib/libvorbisenc.a
    # ${VCPKG_PREFIX}/lib/libvorbisfile.a
    -lcurl
    "-framework CoreFoundation"
    "-framework CoreServices"
    "-framework Accelerate"
)


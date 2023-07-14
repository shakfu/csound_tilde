
# --------------------------------------------------------------------
# Relocatable

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

# set_target_properties(${PROJECT_NAME} PROPERTIES FRAMEWORK YES)

target_link_libraries(${PROJECT_NAME}
    PUBLIC
    ${CSOUND_LIBRARY}
    ${DEPS/libcsnd6.a}
    ${LIBSNDFILE_DYLIB}
    -lcurl
    "-framework CoreFoundation"
    "-framework CoreServices"
    "-framework Accelerate"
)

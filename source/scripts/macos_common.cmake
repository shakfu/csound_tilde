find_package(Boost)

find_library(LIBSNDFILE_DYLIB libsndfile.dylib 
    PATHS 
    ${MAX_INCLUDES_DIR}
    $<${HAS_HOMEBREW}:${HOMEBREW_PREFIX}>
)

if (Boost_FOUND)
    message("found Boost library: ${Boost_FOUND}")
else()
    message(FATAL_ERROR "could not find Boost library")
endif()

if (LIBSNDFILE_DYLIB)
    message("found libsndfile library: ${LIBSNDFILE_DYLIB}")
else()
    message(FATAL_ERROR "could not find libsndfile library")
endif()

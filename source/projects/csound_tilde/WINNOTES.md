VCPKG_DEFAULT_TRIPLET=x64-windows


The package boost is compatible with built-in CMake targets:

    find_package(Boost REQUIRED [COMPONENTS <libs>...])
    target_link_libraries(main PRIVATE Boost::boost Boost::<lib1> Boost::<lib2> ...)

libsndfile provides CMake targets:

    # this is heuristically generated, and may not be correct
    find_package(SndFile CONFIG REQUIRED)
    target_link_libraries(main PRIVATE SndFile::sndfile)

https://github.com/csound/csound/releases/download/6.18.1/Csound6_x64-6.18.1-windows-x64-installer.zip


repos\vcpkg\installed\x64-windows\lib

pkgconfig
-a----         7/14/2023   8:39 AM           7814 boost_atomic-vc140-mt.lib
-a----         7/14/2023   8:39 AM          24940 boost_chrono-vc140-mt.lib
-a----         7/14/2023   8:40 AM          42786 boost_container-vc140-mt.lib
-a----         7/14/2023   8:40 AM           2356 boost_date_time-vc140-mt.lib
-a----         7/14/2023   8:37 AM           7094 boost_exception-vc140-mt.lib
-a----         7/14/2023   8:38 AM           3384 boost_regex-vc140-mt.lib
-a----         7/14/2023   8:42 AM         204058 boost_serialization-vc140-mt.
                                                  lib
-a----         7/14/2023   8:39 AM           2254 boost_system-vc140-mt.lib
-a----         7/14/2023   8:40 AM          29214 boost_thread-vc140-mt.lib
-a----         7/14/2023   8:42 AM          93414 boost_wserialization-vc140-mt
                                                  .lib
-a----         7/14/2023   8:46 AM         209814 FLAC++.lib
-a----         7/14/2023   8:46 AM          87708 FLAC.lib
-a----         7/14/2023   8:48 AM          52020 libmp3lame.lib
-a----         7/14/2023   8:51 AM          25174 mpg123.lib
-a----         7/14/2023   8:44 AM          14758 ogg.lib
-a----         7/14/2023   8:53 AM          18322 opus.lib
-a----         7/14/2023   8:51 AM           8150 out123.lib
-a----         7/14/2023   8:55 AM           9412 sndfile.lib
-a----         7/14/2023   8:51 AM          10460 syn123.lib
-a----         7/14/2023   8:47 AM          10576 vorbis.lib
-a----         7/14/2023   8:47 AM           2978 vorbisenc.lib
-a----         7/14/2023   8:47 AM           8256 vorbisfile.lib
-a----         7/14/2023   8:21 AM          93258 yasm.lib

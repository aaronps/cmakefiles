# this file is intended to be used with Zeranoe FFmpeg Builds <http://ffmpeg.zeranoe.com/builds/>

string(REGEX MATCH "-[^-]+$" FFMPEG_MINUS_VERSION ${CMAKE_CURRENT_LIST_DIR})
string(SUBSTRING ${FFMPEG_MINUS_VERSION} 1 -1 FFMPEG_VERSION)

if (${CMAKE_SIZEOF_VOID_P} MATCHES 8)
	set(FFMPEG_BASE "${CMAKE_CURRENT_LIST_DIR}/ffmpeg-${FFMPEG_VERSION}-win64")
else ()
	set(FFMPEG_BASE "${CMAKE_CURRENT_LIST_DIR}/ffmpeg-${FFMPEG_VERSION}-win32")
endif ()

set(FFMPEG_INCLUDE_DIRS "${FFMPEG_BASE}-dev/include")

set(FFMPEG_LIBDIR "${FFMPEG_BASE}-dev/lib")
set(FFMPEG_RUNTIME_LIBDIR  "${FFMPEG_BASE}-shared/bin")

# dll dependencies:
# avdevice: avcodec avfilter avformat avutil
# avfilter: avcodec avformat avutil postproc swresample swscale
# avformat: avcodec avutil
# avcodec: swreample avutil
# postproc: avutil
# swresample: avutil
# swscale: avutil
# avutil

if ( MINGW )
	set(FFMPEG_LIBRARIES
		-L${FFMPEG_LIBDIR}
		-lavdevice
		-lavfilter
		-lavformat
		-lavcodec
		-lswscale
		-lswresample
		-lavutil)

	string(STRIP "${FFMPEG_LIBRARIES}" FFMPEG_LIBRARIES)
	
elseif ( MSVC )
    # note: need to test this one
	set(FFMPEG_LIBRARIES
		"${FFMPEG_LIBDIR}/avdevice.lib"
		"${FFMPEG_LIBDIR}/avfilter.lib"
		"${FFMPEG_LIBDIR}/avformat.lib"
		"${FFMPEG_LIBDIR}/avcodec.lib"
		"${FFMPEG_LIBDIR}/swscale.lib"
		"${FFMPEG_LIBDIR}/swresample.lib"
		"${FFMPEG_LIBDIR}/avutil.lib"
	)

	string(STRIP "${FFMPEG_LIBRARIES}" FFMPEG_LIBRARIES)
endif ()

file(GLOB FFMPEG_RUNTIME_LIBRARIES LIST_DIRECTORIES false "${FFMPEG_RUNTIME_LIBDIR}/*.dll")

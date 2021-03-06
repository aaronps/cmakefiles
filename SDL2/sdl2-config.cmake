
string(REGEX MATCH "-[^-]+$" SDL2_MINUS_VERSION ${CMAKE_CURRENT_LIST_DIR})
string(SUBSTRING ${SDL2_MINUS_VERSION} 1 -1 SDL2_VERSION)

if ( MINGW )
	set(SDL2_BASE "${CMAKE_CURRENT_LIST_DIR}/SDL2-${SDL2_VERSION}-mingw")
	
	if (${CMAKE_SIZEOF_VOID_P} MATCHES 8)
		set(SDL2_PREFIX "${SDL2_BASE}/x86_64-w64-mingw32")
		set(SDL2_EXEC_PREFIX "${SDL2_BASE}/x86_64-w64-mingw32")
	else ()
		set(SDL2_PREFIX "${SDL2_BASE}/i686-w64-mingw32")
		set(SDL2_EXEC_PREFIX "${SDL2_BASE}/x86_64-w64-mingw32")
	endif ()

	set(SDL2_LIBDIR "${SDL2_EXEC_PREFIX}/lib")
	set(SDL2_INCLUDE_DIRS "${SDL2_PREFIX}/include/SDL2")
	set(SDL2_LIBRARIES "-L${SDL2_LIBDIR} -lmingw32 -lSDL2main -lSDL2 -mwindows")

	string(STRIP "${SDL2_LIBRARIES}" SDL2_LIBRARIES)
	
elseif ( MSVC )
	set(SDL2_BASE "${CMAKE_CURRENT_LIST_DIR}/SDL2-${SDL2_VERSION}-VC")
	set(SDL2_PREFIX "${SDL2_BASE}")
	set(SDL2_EXEC_PREFIX "${SDL2_BASE}/lib")

	# Support both 32 and 64 bit builds
	if (${CMAKE_SIZEOF_VOID_P} MATCHES 8)
		set(SDL2_LIBDIR "${SDL2_EXEC_PREFIX}/x64")
	else ()
		set(SDL2_LIBDIR "${SDL2_EXEC_PREFIX}/x86")
	endif ()

	set(SDL2_INCLUDE_DIRS "${SDL2_PREFIX}/include")
	set(SDL2_LIBRARIES "${SDL2_LIBDIR}/SDL2.lib;${SDL2_LIBDIR}/SDL2main.lib")

	string(STRIP "${SDL2_LIBRARIES}" SDL2_LIBRARIES)
endif ()

if (${CMAKE_SIZEOF_VOID_P} MATCHES 8)
	set(SDL2_RUNTIME_LIBRARIES
		"${CMAKE_CURRENT_LIST_DIR}/SDL2-${SDL2_VERSION}-win32-x64/SDL2.dll"
		"${CMAKE_CURRENT_LIST_DIR}/SDL2-${SDL2_VERSION}-win32-x64/README-SDL.txt"
	)
else()
	set(SDL2_RUNTIME_LIBRARIES
		"${CMAKE_CURRENT_LIST_DIR}/SDL2-${SDL2_VERSION}-win32-x86/SDL2.dll"
		"${CMAKE_CURRENT_LIST_DIR}/SDL2-${SDL2_VERSION}-win32-x86/README-SDL.txt"
	)
endif()
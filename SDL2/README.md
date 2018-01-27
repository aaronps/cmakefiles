# SDL2 CMake config file for Windows

For the full support of SDL2 using mingw64 and visual studio, you have to
prepare a folder structure, download these files from
http://libsdl.org/download-2.0.php (skip the ones you don't need, replace
${VERSION} with the SDL2 version, for example 2.0.7):

* SDL2-devel-${VERSION}-mingw.tar.gz
* SDL2-devel-${VERSION}-VC.zip
* SDL2-${VERSION}-win32-x86.zip
* SDL2-${VERSION}-win32-x64.zip

Create a folder named **SDL2-${VERSION}** and uncompress the downloaded files with the following names:

* SDL2-devel-${VERSION}-mingw.tar.gz -> uncompress and rename to SDL2-${VERSION}-mingw
* SDL2-devel-${VERSION}-VC.zip -> uncompress and rename to SDL2-${VERSION}-VC
* SDL2-${VERSION}-win32-x86.zip -> uncompress to a folder with same name as the zip file
* SDL2-${VERSION}-win32-x64.zip -> uncompress to a folder with same name as the zip file

Copy `sdl2-config.cmake` to the base folder `SDL2-${VERSION}`.

Done.

## Example usage in CMake files

In your `CMakeLists.txt`:

```cmake
find_package(SDL2 REQUIRED)
target_include_directories(your-target-name ${SDL2_INCLUDE_DIRS})
target_link_libraries(your-target-name ${SDL2_LIBRARIES})
```

## Letting CMake find the package

There are actually 3 ways to let CMake know where is SDL2:

1. Using `cmake-gui`: after configure fails, set variable **SDL2_DIR** to the
full path to the base folder `SDL2-${VERSION}`.
2. using `cmake` command: `cmake -DSDL2_DIR=path/to/SDL2-${VERSION} path/to/your/projec`
3. Configuring registry for automatic finding: create key
`HKEY_LOCAL_MACHINE\SOFTWARE\Kitware\CMake\Packages\SDL2`, set default value
to the `path/to/SDL2-${VERSION}`.

## Automatic copy of dll files on install

This cmake file has an extra variable `SDL2_RUNTIME_LIBRARIES` with the list of
files needed at run time (SDL2.dll and the readme), you can copy these
automatically adding the following to your `CMakeLists.txt`:

```cmake
install(FILES ${SDL2_RUNTIME_LIBRARIES} DESTINATION ".")
```
# ffmpeg CMake config file for Windows

This works with ffmpeg builds found on: https://ffmpeg.zeranoe.com/builds/.

For complete support to 32 and 64 bits, you need to download some files from the
zeranoe site, and uncompress following a folder structure.

The files should be for the same version of ffmpeg: _shared_ and _dev_ for 32bit
and 64bit (4 files in total).

Uncompress all of them on a folder named `ffmpeg-${VERSION}` you would end with
the following structure:

```
ffmpeg-${VERSION}/
    ffmpeg-${VERSION}-win32-dev/
    ffmpeg-${VERSION}-win32-shared/
    ffmpeg-${VERSION}-win64-dev/
    ffmpeg-${VERSION}-win64-shared/
````

Copy `ffmpeg-config.cmake` to `ffmpeg-${VERSION}`.

Done.

## Example usage in CMake files

In your `CMakeLists.txt`:

```cmake
find_package(ffmpeg REQUIRED)
target_include_directories(your-target-name ${FFMPEG_INCLUDE_DIRS})
target_link_libraries(your-target-name ${FFMPEG_LIBRARIES})
```

## Letting CMake find the package

There are actually 3 ways to let CMake know where is ffmpeg:

1. Using `cmake-gui`: after configure fails, set variable **ffmpeg_DIR** to the
full path to the base folder `ffmpeg-${VERSION}`.
2. using `cmake` command: `cmake -Dffmpeg_DIR=path/to/ffmpeg-${VERSION} path/to/your/projec`
3. Configuring registry for automatic finding: create key
`HKEY_LOCAL_MACHINE\SOFTWARE\Kitware\CMake\Packages\ffmpeg`, set default value
to the `path/to/ffmpeg-${VERSION}`.

## Automatic copy of dll files on install

This cmake file has an extra variable `FFMPEG_RUNTIME_LIBRARIES` with the list
of files needed at run time, which currently is all the dll files found on the
**ffmpeg-${VERSION}-win${32 or 64}-shared.zip** file, you can copy these
automatically adding the following to your `CMakeLists.txt`:

```cmake
install(FILES ${FFMPEG_RUNTIME_LIBRARIES} DESTINATION ".")
```
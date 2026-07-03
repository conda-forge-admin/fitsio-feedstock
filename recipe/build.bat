mkdir cfitsio-prefix

tar -xzvf cfitsio-4.6.4.tar.gz
if errorlevel 1 exit 1

cd cfitsio-4.6.4

mkdir build
cd build

cmake -G "NMake Makefiles" ^
  %CMAKE_ARGS% ^
  -D CMAKE_PREFIX_PATH="%SRC_DIR%\cfitsio-prefix" ^
  -D CMAKE_INSTALL_PREFIX="%SRC_DIR%\cfitsio-prefix" ^
  -D TESTS=On ^
  -D UTILS=On ^
  -D BUILD_SHARED_LIBS=Off ^
  ..
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

:: test-ish programs (speed doesn't seem to get built)
cookbook
if errorlevel 1 exit 1
testprog
if errorlevel 1 exit 1
  
nmake install
if errorlevel 1 exit 1

cd ..
cd ..

set FITSIO_USE_SYSTEM_FITSIO="True"
set FITSIO_SYSTEM_FITSIO_INCLUDEDIR="%SRC_DIR%\cfitsio-prefix\include;%LIBRARY_PREFIX%\include"
set FITSIO_SYSTEM_FITSIO_LIBDIR="%SRC_DIR%\cfitsio-prefix\lib;%LIBRARY_PREFIX%\lib"

%PYTHON% -m pip install . --no-deps --ignore-installed --no-cache-dir -vvv
if errorlevel 1 exit 1

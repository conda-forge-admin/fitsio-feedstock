for %%f in (cfitsio-*.tar.gz) do (
    set "tarball=%%f"
    goto :break
)
:break
set "cfitsio_dir=%tarball:.tar.gz=%"
echo found cfitsio tarball: %tarball%
echo cfitsio dir: %cfitsio_dir%
if errorlevel 1 exit 1

tar -xzvf %tarball%
if errorlevel 1 exit 1

mkdir cfitsio-prefix
cd %cfitsio_dir%

mkdir build
cd build

cmake -G "NMake Makefiles" ^
  %CMAKE_ARGS% ^
  -D CMAKE_PREFIX_PATH=%SRC_DIR%\cfitsio-prefix ^
  -D CMAKE_INSTALL_PREFIX=%SRC_DIR%\cfitsio-prefix ^
  -D USE_CURL=On ^
  -D BUILD_SHARED_LIBS=Off ^
  ..
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1
  
nmake install
if errorlevel 1 exit 1

cd ..
cd ..

set FITSIO_USE_SYSTEM_FITSIO=True
set FITSIO_SYSTEM_FITSIO_INCLUDEDIR=%SRC_DIR%\cfitsio-prefix\include;%LIBRARY_PREFIX%\include
set FITSIO_SYSTEM_FITSIO_LIBDIR=%SRC_DIR%\cfitsio-prefix\lib;%LIBRARY_PREFIX%\lib
set FITSIO_SYSTEM_FITSIO_HAS_CURL=True

%PYTHON% -m pip install . --no-deps --ignore-installed --no-cache-dir -vvv
if errorlevel 1 exit 1

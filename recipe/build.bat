set FITSIO_USE_SYSTEM_FITSIO="True"
set FITSIO_SYSTEM_FITSIO_INCLUDEDIR="%LIBRARY_PREFIX%\include"
set FITSIO_SYSTEM_FITSIO_LIBDIR="%LIBRARY_PREFIX%\lib"

%PYTHON% -m pip install . --no-deps --ignore-installed --no-cache-dir -vvv
if errorlevel 1 exit 1

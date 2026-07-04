set CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% -DUSE_PTHREADS=On

%PYTHON% -m pip install . --no-deps --ignore-installed --no-cache-dir -vvv
if errorlevel 1 exit 1

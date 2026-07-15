# configure has a weird choice the ignores LDFLAGS
export CFLAGS="${CFLAGS} ${LDFLAGS}"


$PYTHON -m pip install . --no-deps --ignore-installed --no-cache-dir -vvv

# configure has a weird choice the ignores LDFLAGS
export CFLAGS="${CFLAGS} ${LDFLAGS}"

# Get an updated config.sub and config.guess

$PYTHON -m pip install . --no-deps --ignore-installed --no-cache-dir -vvv

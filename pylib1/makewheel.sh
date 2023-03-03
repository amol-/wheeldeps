#!/bin/bash
rm -rf build dist wheelhouse
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    python3 setup.py bdist_wheel
    LD_LIBRARY_PATH="$PWD/../libfoo" auditwheel repair dist/libone*.whl
elif [[ "$OSTYPE" == "darwin"* ]]; then
    py_platform=$(python -c "import sysconfig; print('%s' % sysconfig.get_platform());")
    export MACOSX_DEPLOYMENT_TARGET="11.0"
    export _PYTHON_HOST_PLATFORM="${py_platform/universal2/arm64}"
    export ARCHFLAGS="-arch arm64"
    python3 setup.py bdist_wheel
    DYLD_LIBRARY_PATH="$PWD/../libfoo" delocate-wheel -v dist/libone*.whl -w wheelhouse --require-archs arm64
fi


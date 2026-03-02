#!/bin/bash
rm -rf build dist wheelhouse
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    python3 setup.py bdist_wheel
    if [[ "$LINUX_NO_EXCLUDE" == "1" ]]; then
        # for testing only...
        LD_LIBRARY_PATH="$PWD/../libbar:$PWD/../libfoo" auditwheel repair dist/libtwo*.whl
    else
        LD_LIBRARY_PATH="$PWD/../libbar" auditwheel repair dist/libtwo*.whl --exclude libfoo.so
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    python3 setup.py bdist_wheel
    DYLD_LIBRARY_PATH="$PWD/../libbar:$PWD/../libfoo" delocate-wheel -v dist/libtwo*.whl -w wheelhouse
fi

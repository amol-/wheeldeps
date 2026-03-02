#!/bin/bash
rm -rf build dist wheelhouse
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    python3 setup.py bdist_wheel
    LD_LIBRARY_PATH="$PWD/../libfoo" auditwheel repair dist/libone*.whl
elif [[ "$OSTYPE" == "darwin"* ]]; then
    python3 setup.py bdist_wheel
    DYLD_LIBRARY_PATH="$PWD/../libfoo" delocate-wheel -v dist/libone*.whl -w wheelhouse
fi

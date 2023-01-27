#!/bin/bash
rm -rf build dist wheelhouse
python3 setup.py bdist_wheel
LD_LIBRARY_PATH="$PWD/../libfoo" auditwheel repair dist/libone*.whl

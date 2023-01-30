#!/bin/bash
rm -rf build dist wheelhouse
python3 setup.py bdist_wheel
LD_LIBRARY_PATH="$PWD/../libbar" auditwheel repair dist/libtwo*.whl --exclude libfoo.so

# Patch shared object to remove mangling,
# This is a huge hack, there should be a better way
# See https://github.com/pypa/auditwheel/issues/410
cd wheelhouse
wheel unpack libtwo*.whl
wheel unpack ../../pylib1/wheelhouse/libone-0.0.0*.whl
rm libtwo*.whl
for d in libtwo*; do
    newlibname=`basename libone-0.0.0/libone.libs/libfoo-*.so`
    echo "Replacing libfoo.so with $newlibname in $d"
    patchelf --replace-needed libfoo.so $newlibname $d/libtwo/*.so
done
rm -rf libone*
wheel pack libtwo*
#!/bin/bash
set -e
find ./ -iname "*.so" -delete
rm -f ./patchedwheels/*.whl
source venv/bin/activate
pip install cython wheel auditwheel delocate consolidatewheels
(cd libfoo; make)
(cd libbar; make)
(cd pylib1; ./makewheel.sh)
(cd pylib2; ./makewheel.sh)
echo -e "\n\nCONSOLIDATING..."
consolidatewheels pylib1/wheelhouse/*.whl pylib2/wheelhouse/*.whl --dest=./patchedwheels
pip install patchedwheels/*.whl --force-reinstall
python pyparent/test.py

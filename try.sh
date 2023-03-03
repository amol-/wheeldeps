#!/bin/bash
find ./ -iname "*.so" -delete
source venv/bin/activate
pip install cython wheel auditwheel consolidatewheels delocate
(cd libfoo; make)
(cd libbar; make)
(cd pylib1; ./makewheel.sh)
(cd pylib2; ./makewheel.sh)
consolidatewheels pylib1/wheelhouse/*.whl pylib2/wheelhouse/*.whl --dest=./patchedwheels
pip install patchedwheels/*.whl --force-reinstall
python pyparent/test.py

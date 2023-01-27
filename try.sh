#!/bin/bash
find ./ -iname "*.so" -delete
source venv/bin/activate
pip install cython wheel auditwheel
(cd libfoo; make)
(cd libbar; make)
(cd pylib1; ./makewheel.sh)
(cd pylib2; ./makewheel.sh)
pip install pylib1/wheelhouse/*.whl --force-reinstall
pip install pylib2/wheelhouse/*.whl --force-reinstall
python pyparent/test.py

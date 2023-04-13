call venv\Scripts\activate.bat
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\VsDevCmd.bat" -arch=amd64 -host_arch=amd64
pip install cython wheel delvewheel consolidatewheels
cd libfoo
make
cd ..
cd libbar
make
cd ..
cd pylib1
call makewheel.bat
cd ..
cd pylib2
call makewheel.bat
cd ..
consolidatewheels pylib1/wheelhouse/*.whl pylib2/wheelhouse/*.whl --dest=./patchedwheels
pip install patchedwheels/*.whl --force-reinstall
python pyparent/test.py

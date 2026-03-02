Setlocal EnableDelayedExpansion
call venv\Scripts\activate.bat
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\VsDevCmd.bat" -arch=amd64 -host_arch=amd64
pip install cython wheel setuptools delvewheel consolidatewheels
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

set wheel_files=
for %%f in (pylib1\wheelhouse\*.whl) do set wheel_files=!wheel_files! "%%f"
for %%f in (pylib2\wheelhouse\*.whl) do set wheel_files=!wheel_files! "%%f"
echo CONSOLIDATING %wheel_files%
consolidatewheels %wheel_files% --dest=./patchedwheels

set wheel_files=
for %%f in (patchedwheels\*.whl) do set wheel_files=!wheel_files! "%%f"
pip install %wheel_files% --force-reinstall
python pyparent/test.py

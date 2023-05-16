RMDIR /S /Q build dist wheelhouse
python setup.py bdist_wheel
FOR %%w in (dist/*.whl) DO delvewheel repair --add-path ..\libfoo;..\libbar dist/%%w

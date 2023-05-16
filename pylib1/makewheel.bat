RMDIR /S /Q build dist wheelhouse
SET LIB=%LIB%:../libfoo
python setup.py bdist_wheel
FOR %%w in (dist/*.whl) DO delvewheel repair --add-path ..\libfoo dist/%%w

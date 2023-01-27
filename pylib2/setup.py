from setuptools import setup, Extension
from Cython.Build import cythonize

setup(
    name="libtwo",
    packages=["libtwo"],
    ext_modules=cythonize(
        Extension("libtwo._libtwo", ["libtwo/_libtwo.pyx"], 
                  library_dirs=["../libbar", "../libfoo"],
                  libraries=["bar", "foo"])
    )
)
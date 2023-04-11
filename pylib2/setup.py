from setuptools import setup, Extension
from Cython.Build import cythonize

setup(
    name="libtwo",
    packages=["libtwo"],
    install_requires=["libone"],
    ext_modules=cythonize(
        Extension("libtwo._libtwo", ["libtwo/_libtwo.pyx"], 
                  library_dirs=["../libbar", "../libfoo"],
                  libraries=["bar", "foo"])
    )
)
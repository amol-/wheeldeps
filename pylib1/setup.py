from setuptools import setup, Extension
from Cython.Build import cythonize

setup(
    name="libone",
    packages=["libone"],
    ext_modules=cythonize(
        Extension("libone._libone", ["libone/_libone.pyx"], 
                  library_dirs=["../libfoo"],
                  libraries=["foo"])
    )
)
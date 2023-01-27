Experiment on complex shared objects dependencies
=================================================

This tries to simulate a complex dependency of native code with wheels depending on other wheels
that contain cython libraries depending on shared objects.

The purpose of this experiment is to verify how shared objects from multiple different libraries
can be made available to other weels without copying them into every wheel.

Hierarchy of dependencies
-------------------------

```
parent
  |
  | ---- libtwo.whl
  |        |
  |        | --- libbar.so
  |        |        |
  |        |         ---- libfoo.so
  |        | ---- libone.whl
  |                |
  |                 ---- libfoo.so
  | ---- libone.whl     
             |
              ---- libfoo.so    
```

Usage
-----

1. Run ``cd libfoo; make``
2. Run ``cd libbar; make``
3. Run ``cd pylib1; ./makewheel.sh``
4. Run ``cd pylib2; ./makewheel.sh``
5. Create a virtual environment and activate it (``python -mvenv venv; source ./venv/bin/activate``)
6. Run ``pip install pylib1/wheelhouse/*.whl``
7. Run ``pip install pylib2/wheelhouse/*.whl``
8. Run ``cd pyparent; python test.py``
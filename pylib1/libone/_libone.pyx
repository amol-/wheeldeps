from _libfoo cimport foo

def hello(who):
    foo()
    print(f"LIB1: Hello from {who}")
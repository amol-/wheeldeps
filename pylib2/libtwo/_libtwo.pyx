from _libbar cimport bar

def hello(who):
    bar()
    print(f"LIB2: Hello from {who}")
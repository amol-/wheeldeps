ifeq ($(OS),Windows_NT)
foo.dll: foo.c
	echo %CD%
	cl.exe /LD foo.c 

all: foo.dll
else
libfoo.so: foo.c
	gcc -shared -fPIC -o libfoo.so foo.c

all: libfoo.so
endif


ifeq ($(OS),Windows_NT)
bar.dll: bar.c
	echo %CD%
	cl.exe /LD bar.c /link ..\libfoo\foo.lib

all: bar.dll
else
libbar.so: bar.c
	gcc -shared -fPIC -L../libfoo/ -lfoo -o libbar.so bar.c

all: libbar.so
endif


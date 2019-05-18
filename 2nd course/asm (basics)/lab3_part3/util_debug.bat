:: Translation source code(asm) in the object files(obj)
TASM.EXE proc1.asm
TASM.EXE proc2.asm
TASM.EXE proc3.asm
TASM.EXE main.asm

:: Linking object files(obj) in executable file (exe)
:: [and formation of the map is loaded(map)]
TLINK.EXE main.obj proc1.obj proc2.obj proc3.obj
pause

:: Running debug executable file (Borland Turbo debugger 3.1)
TD.EXE main.exe

:: Translation source code(asm) in the object files(obj)
TASM.EXE proc1.asm
TASM.EXE proc2.asm
TASM.EXE proc3.asm
TASM.EXE show.asm
TASM.EXE input.asm
TASM.EXE main.asm

:: Linking object files(obj) in executable file (exe)
:: [and formation of the map is loaded(map)]
TLINK.EXE main.obj show.obj input.obj proc1.obj proc2.obj proc3.obj
pause

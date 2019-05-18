:: Translation source code(asm) in the object file(obj)
TASM.EXE main.asm

:: Linking object file(obj) in executable file (exe)
:: [and formation of the map is loaded(map)]
TLINK.EXE main.obj
pause

:: Running debug executable file (Borland Turbo debugger 3.1)
TD.EXE main.exe

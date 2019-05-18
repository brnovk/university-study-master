;     (Var 5, POIT-21, Baranov V.)
;   Calculate the value of an expression:
;   y=(2a+b-5)/(b+2).
;   ====Version 2(Working with 'words')====
;-------------------------------------------------

Dseg segment para public 'data'
     a dw 5
     b dw 1
     y dw ?
mes db 'End of program$'
Dseg ends
Sseg segment para stack 'stack'
     db 30 dup (0)
Sseg ends

;-------------------------------------------------

Cseg segment para public 'code'
  osn proc near
  Assume cs:cseg,ds:dseg,ss:sseg
  mov ax,dseg
  mov ds,ax
  mov bx,2     ; bl=2
  add bx,b     ; bl=2+b
  mov ax,2     ; al=2
  imul a       ; al=2*a
  add ax,b     ; al=2*a+b
  sub ax,5     ; al=2*a+b-5
  cwd          ; Extension 'byte' to 'word'
  idiv bx      ; al=(2*a+b-5)/(2+b)  Balance in 'dx'
  mov y,ax     ; y=al
  lea dx,mes   ; Output of message 'End of program'
;--------------------------------------------------
  mov ax,0900H
  int 21H
  mov ax,4C00H ; end of program
  int 21H
  osn endp
  Cseg ends
  end osn
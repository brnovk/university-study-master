;     (Var 5, POIT-21, Baranov V.)

;   Calculate the value of 'y' when:
;        xy>12:   (y+3)/((x*x)+(y*y)+1);
;        xy<-4:   x/((x*x)+(y*y)+1);
;   -4<=xy<=12:   (x*x)+(y*y);

;   ====Version 3(With using external procedures)====
;------------------------------------------------------------------------------

Dseg segment para public 'data'
     x db 3
     y db 2
     f db ?
mes db 'End of program$'
Dseg ends
Sseg segment para stack 'stack'
     db 30 dup (0)
Sseg ends
     public x,y
     extrn proc1:near, proc2:near, proc3:near

;------------------------------------------------------------------------------

Cseg segment para public 'code'
  osn proc near
  Assume cs:cseg,ds:dseg,ss:sseg
  mov ax,dseg
  mov ds,ax
  mov al,x     ;al=x
  imul y       ;al=x*y
;-------------------------------------------------
  cmp al,12    ;Compare contents 'al' with 12;
  jg m1        ;if al>12 go to label m1
;-------------------------------------------------
  cmp al,-4    ;Compare contents 'al' with -4;
  jl m2        ;if al<-4 go to label m2
;-------------------------------------------------
  call proc3      ;Call procedure proc3 (When -4<=xy<=12)
  jmp m3       ;Move to end and display result

  m1: call proc1  ;Call procedure proc1 (When xy>12)
  jmp m3       ;Move to end and display result

  m2: call proc2  ;Call procedure proc2 (When xy<-4)

;--------------Ending program---------------------
  m3: mov f,al ; f=al
  lea dx,mes  
  mov ah,9
  int 21h
  mov ax,4c00h
  int 21h
 osn endp
 Cseg ends
 end osn
;     (Var 5, POIT-21, Baranov V.)

;   Calculate the value of 'y' when:
;        xy>12:   (y+3)/((x*x)+(y*y)+1);
;        xy<-4:   x/((x*x)+(y*y)+1);
;   -4<=xy<=12:   (x*x)+(y*y);

;   ====Version 4(With using external procedures,
;                 console data input and console results output)====
;------------------------------------------------------------------------------

Dseg segment para public 'data'
     x db 3
     y db 2
     f db ?
  mes1 db 10,13,'$'
   mes db 'End of program$'
  mes2 db 'Enter X-->$'
  mes3 db 'Enter Y-->$'
  mes4 db 'F=$'
Dseg ends
Sseg segment para stack 'stack'
     db 30 dup (0)
Sseg ends
     public x,y
     extrn proc1:near, proc2:near, proc3:near, show:near, input:near

;------------------------------------------------------------------------------

Cseg segment para public 'code'
  osn proc near
  Assume cs:cseg,ds:dseg,ss:sseg
  mov ax,dseg
  mov ds,ax
;--------------------------------------------------------
  lea dx,mes2  ; Show message "Enter X-->"
  mov ah,9
  int 21h
  call input   ; Enter value X
  mov x,bl     ; Entered value from register 'bl' assign to variable
;--------------------------------------------------------
  lea dx,mes3  ; Show message "Enter Y-->"
  mov ah,9
  int 21h
  call input   ; Enter value Y
  mov y,bl     ; Entered value from register 'bl' assign to variable
;--------------------------------------------------------
  mov al,x     ;al=x
  imul y       ;al=x*y
;--------------------------------------------------------
  cmp al,12    ;Compare contents al with 12;
  jg m1        ;if al>12 go to label m1
;--------------------------------------------------------
  cmp al,-4    ;Compare contents al with -4;
  jl m2        ;if al<-4 go to label m2
;--------------------------------------------------------
  call proc3     ;Call procedure proc3 (When -4<=xy<=12)
  jmp m3         ;Move to end and display result

  m1: call proc1 ;Call procedure proc1 (When xy>12)
  jmp m3         ;Move to end and display result

  m2: call proc2 ;Call procedure proc2 (When xy<-4)

;---------------------Output of results and ending program-----------------
  m3: mov f,al ; f=al
  lea dx,mes4  ; Show message "F="
  mov ah,9
  int 21h
  mov al,f     ; Output values "F"
  cbw
  call show
  lea dx,mes1  ; new line
  mov ah,9
  int 21h
;--------------------------------------------------------
  lea dx,mes  
  mov ah,9
  int 21h
  mov ax,4c00h
  int 21h
 osn endp
 Cseg ends
 end osn
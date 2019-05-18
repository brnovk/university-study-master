;     (Var 5, POIT-21, Baranov V.)

;   Calculate the value of 'y' when:
;        xy>12:   (y+3)/((x*x)+(y*y)+1);
;        xy<-4:   x/((x*x)+(y*y)+1);
;   -4<=xy<=12:   (x*x)+(y*y);

;   ====Version 2(With using internal procedures)====
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
  call p3      ;Call procedure p3 (When -4<=xy<=12)
  jmp m3       ; Move to end and display result

  m1: call p1  ;Call procedure p1 (When xy>12)
  jmp m3       ; Move to end and display result

  m2: call p2  ;Call procedure p2 (When xy<-4)

;---------------Ending program--------------------
  m3: mov f,al ; f=al
  lea dx,mes  
  mov ah,9
  int 21h
  mov ax,4c00h
  int 21h
 osn endp
;-----------------------------Procedure P1-------------------------------------
  p1 proc near   ;        // when xy>12
    mov al,y  ; al=y
    imul y       ; al=y*y
    mov bl,al    ; bl=al
    mov al,x     ; al=x
    imul x       ; al=x*x
    add bl,al    ; bl=(x*x)+(y*y)
    add bl,1     ; bl=(x*x)+(y*y)+1
    mov al,y     ; al=y
    add al,3     ; al=y+3
    cbw
    idiv bl      ; al=(y+3)/((x*x)+(y*y)+1)
    ret 
  p1 endp
;-----------------------------Procedure P2-------------------------------------
  p2 proc near   ;        // when xy<-4
    mov al,y  ; al=y
    imul y       ; al=y*y
    mov bl,al    ; bl=al
    mov al,x     ; al=x
    imul x       ; al=x*x
    add bl,al    ; bl=(x*x)+(y*y)
    add bl,1     ; bl=(x*x)+(y*y)+1
    mov al,x     ; al=x
    cbw
    idiv bl      ; al=x/((x*x)+(y*y)+1)
    ret 
  p2 endp
;-----------------------------Procedure P3-------------------------------------
  p3 proc near   ;        // when -4<=xy<=12
    mov al,y     ; al=y
    imul y       ; al=y*y
    mov bl,al    ; bl=al
    mov al,x     ; al=x
    imul x       ; al=x*x
    add al,bl    ; al=(x*x)+(y*y)
    ret 
  p3 endp
;------------------------------------------------------------------------------
 Cseg ends
 end osn
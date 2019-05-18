;     (Var 5, POIT-21, Baranov V.)

;      External procedure proc1 (when xy>12)
;------------------------------------------------------------------------------
extrn x:byte, y:byte
public proc1

;------------------------------------------------------------------------------

 Cseg segment para public 'code'
  proc1 proc near   ;   
    Assume cs:cseg
    mov al,y     ; al=y
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
  proc1 endp
 Cseg ends
 end

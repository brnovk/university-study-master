;     (Var 5, POIT-21, Baranov V.)

;      External procedure proc2 (when xy<-4)
;------------------------------------------------------------------------------
extrn x:byte, y:byte
public proc2

;------------------------------------------------------------------------------

 Cseg segment para public 'code'
  proc2 proc near   ;    
    Assume cs:cseg
    mov al,y     ; al=y
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
  proc2 endp
 Cseg ends
 end
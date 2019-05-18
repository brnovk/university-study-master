;     (Var 5, POIT-21, Baranov V.)

;      External procedure proc3 (when -4<=xy<=12)
;------------------------------------------------------------------------------
extrn x:byte, y:byte
public proc3

;------------------------------------------------------------------------------

 Cseg segment para public 'code'
  proc3 proc near   ;   
    Assume cs:cseg
    mov al,y     ; al=y
    imul y       ; al=y*y
    mov bl,al    ; bl=al
    mov al,x     ; al=x
    imul x       ; al=x*x
    add al,bl    ; al=(x*x)+(y*y)
    ret 
  proc3 endp
 Cseg ends
 end
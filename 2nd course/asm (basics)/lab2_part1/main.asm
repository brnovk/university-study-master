;     (Var 5, POIT-21, Baranov V.)
;   Calculate the value of an expression:
;   y=(2a+b-5)/(b+2).
;   ====Version 1(Working with 'bytes')====
;------------------------------------------------------------------------------

Dseg segment para public 'data' ; Dseg - just name of a segment (can be any)
                                ; para - type segment alignment (first byte
                                ;        segment starts with the address, fold
                                ;        16. 1st byte segment located with 
                                ;        zero offset, relatively segment
                                ;        register)
                                ; public - Invokes merge all segments with the
                                ;          same name in one
                                ; data - category segment (This segment - data)

     a db 5                     ; Declares variable 'a' with the length - bytes
                                ; and value '5';
     b db 1                    
     y db ?                     
mes db 'End of program$'
Dseg ends

Sseg segment para stack 'stack'
     db 30 dup (0)
Sseg ends

;------------------------------------------------------------------------------

Cseg segment para public 'code'
  osn proc near                   ; osn - Name of procedure
                                  ; near - Call model (near)
  
  Assume cs:cseg,ds:dseg,ss:sseg  ; assume - Tells Assembler, what kind of
                                  ;          segment loaded. Associates each 
                                  ;          segment register with the current.
  
  mov ax,dseg                     ; mov - command to forwarding: 
                                  ;   ax   (receiver) - register battery
                                  ;   dseg (source) - name of the data segment

  mov ds,ax                       ; ds - data segment, stores the address of 
                                  ;      the data segment current programs.
  mov bl,2     ; bl=2
  add bl,b     ; bl=2+b          
  mov al,2     ; al=2
  imul a       ; al=2*a
  add al,b     ; al=2*a+b
  sub al,5     ; al=2*a+b-5
  cbw          ; Extension 'byte' to 'word'
  idiv bl      ; al=(2*a+b-5)/(2+b)  Balance in 'ah'
  mov y,al     ; y=al
  lea dx,mes   ; Output of message 'End of program'

;------------------------------------------------------------------------------
  mov ax,0900H
  int 21H
  mov ax,4C00H ; end of program
  int 21H
  osn endp           ; End of procedure 'osn'
  Cseg ends          ; End of code segment 'Cseg'
  end osn            ; End of program, 'osn' - label entry point

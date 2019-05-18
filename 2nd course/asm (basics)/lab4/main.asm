;     (Var 5, POIT-21, Baranov V.)
;  Compile and debug a program in Assembler language to work with 
;  one-dimensional arrays. To organize input array dimensions and the array 
;  elements with keyboard and output the results to the screen.


;   (* Find the sum of negative elements in the array *)

;------------------------------------------------------------------------------

extrn input:near,show:near 
Dseg segment para public 'data' 
   mas db 10 dup (?) 
   sum db ? 
   mes1 db 'Enter N = $' 
   mes2 db 'mas[$' 
   mes3 db ']=$' 
   mes4 db 'Source vector: $' 
   mes5 db 10,13,'$' ; newline
   mes6 db ' $' ; space
   mes7 db 'Sum negative elements = $' 
   n dw ? 
Dseg ends 
;------------------------------ 
Sseg segment para stack 'stack' 
   db 30 dup(0) 
Sseg ends 
;----------------------------- 
Cseg segment para public 'code' 
  osn proc near 
    assume cs:cseg,ds:dseg,ss:sseg 
    mov ax,dseg 
    mov ds,ax 
;---------------------------- 
; Input vector
; Input n 
    lea dx,mes1 
    mov ax,0900h 
    int 21h 
    call input 
    mov n,bx 
; Input elements vector
    mov cx,n 
    mov si,0 
    zikl1: 
      lea dx,mes2 ;mas[ 
      mov ax,0900h 
      int 21h 
      mov ax,si 
      call show 
      lea dx,mes3 ;]= 
      mov ax,0900h 
      int 21h 
      call input 
      mov mas[si],bl 
      inc si 
    loop zikl1 
;---------------------------- 
; Output vector
    lea dx,mes4 ;Source vector
    mov ax,0900h 
    int 21h 
    lea dx,mes5 ;Newline
    mov ax,0900h 
    int 21h 
    mov cx,n 
    mov si,0 
    zikl2: 
      mov al, mas[si] 
      cbw 
      call show 
      lea dx,mes6     ;Space
      mov ax,0900h 
      int 21h 
      inc si 
    loop zikl2 
;---------------------------- 
; Sum negative elements vector
    mov cx,n    ; cx=n
    mov si,0    ; si=0
    mov al,0  
    zikl3: 
      cmp mas[si],0  ; compare array element with zero
      jge m1         ; if greater than or equal to zero, skip
      add al, mas[si] 
     m1: inc si 
    loop zikl3 
    mov sum, al 
;---------------------------- 
; Show sum negative elements vector
    lea dx,mes5 ;newline
    mov ax,0900h 
    int 21h 
    lea dx,mes7 ;sum negative elements vector
    mov ax,0900h 
    int 21h 
    mov al,sum
    cbw 
    call show 
;--------------------- 
; ending program
    mov ax,4c00h 
    int 21h 
  osn endp 
Cseg ends 
end osn 
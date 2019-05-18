;external procedure output binary number, 
;which is in register AX, to the screen
public show
Dseg segment para public 'data'
tab db 6 dup(?)
Dseg ends
Code segment para public 'code'
        assume cs:code,ds:dseg
show    proc near
        push bx
        push si
        push cx
        push ax
mask1 equ 00110000B
        mov si,0
        mov bx,10
        mov cx,0
        cmp ax,0
        jge label1
        mov tab[si],'-'
        inc si
        neg ax
label1:  cwd
        div bx
        or dl,mask1
        mov tab[si],dl
        inc cx
        inc si
        cmp ax,0
        jne label1
        dec si
        pop ax
        cmp ax,0
        jge label2
        mov dl,tab
        mov ax,200h
        int 21h
label2: mov dl,tab[si]
        mov ax,200h
        int 21h
        dec si
        loop label2
        pop cx
        pop si
        pop bx
        ret
show endp
Code ends
end

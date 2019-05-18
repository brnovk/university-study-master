      public input
dseg  segment para public 'data'
mes   db 'Overflow'
mes1  db '',10,13,'$'
mes2  db 'Input error',10,13,'$'
dseg  ends
cseg  segment para public 'code'
      assume cs:cseg,ds:dseg
input proc near
        mov ax,dseg
        mov ds,ax
        push ax
        push cx
        push dx
        push si
        push di
        push bp
        mask1=00001111b
        mov bx,0
        mov cx,10
        mov si,0
        mov di,1
        mov bp,1
label4: mov ax,0800h
        int 21h
        cmp al,0dh
        je label1
        cmp si,0
        jne label2
        cmp al,2dh
        jne label3
        mov dl,2dh
        mov di,0
label6: mov ax,0200h
        int 21h
        mov si,1
        mov bp,0
        jmp label4
label3: cmp al,2bh
        jne label2
        mov dl,2bh
        jmp label6
label2: cmp al,30h
        jae label5
label7: mov dl,07h
        mov ax,0200h
        int 21h
        jmp label4
label5: cmp al,39h
        ja label7
        mov dl,al
        mov ax,0200h
        int 21h
        mov bp,1
        mov si,1
        and al,mask1
        cbw
        push ax
        mov ax,bx
        cwd
        imul cx
        jo label11
        mov bx,ax
        pop ax
        cmp di,1
        je label9
        neg ax
label9: add bx,ax
        jno label4
label11:lea dx,mes1
        mov ax,0900h
        int 21h
        lea dx,mes
        mov ax,0900h
        int 21h
        jmp stop
label1: cmp bp,1
        je label10
        lea dx,mes1
        mov ax,0900h
        int 21h
        lea dx,mes2
        mov ax,0900h
        int 21h
        jmp stop
label10:lea dx,mes1
        mov ax,0900h
        int 21h
  stop: pop bp
        pop di
        pop si
        pop dx
        pop cx
        pop ax
        ret
input endp
cseg  ends
      end

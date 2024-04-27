org 0x0100

jmp start


clr:
    push dx
    push di
    push ax
    push es

    mov di , 0
    mov ax ,0xb800
    mov es , ax
    mov dx , 0x0720

    loop3:
        mov [es:di] , dx
        add di , 2
        cmp di , 4000
        jne loop3
    
    pop es
    pop ax
    pop di
    pop dx
    ret



display:
    push bp 
    mov bp , sp
    push ax 
    push bx
    push cx
    push dx
    push es 
    push di
    push si

    
    mov si , 0
    mov di , 0
    mov ax , 0xb800
    mov es , ax
   

    loop10:
         mov cx , 12
         mov dx , 0x0740
        loop1:
            mov [es:di] , dx
            add di , 2
            loop loop1
        mov  cx , 24
        mov dx , 0x0720
        loop2:
            mov [es:di] , dx
            add di , 2
            loop loop2
        mov  cx , 34
        mov dx , 0x0740
        loop4:
            mov [es:di] , dx
            add di , 2
            loop loop4
        mov  cx , 100
        mov dx , 0x0720
        loop5:
            mov [es:di] , dx
            add di , 2
            loop loop5

        mov  cx , 5
        mov dx , 0x0740
        loop6:
            mov [es:di] , dx
            add di , 2
            loop loop6


        mov  cx , 10
        mov dx , 0x0720
        loop7:
            mov [es:di] , dx
            add di , 2
            loop loop7
        mov  cx , 20
        mov dx , 0x0720
        loop8:
            mov [es:di] , dx
            add di , 2
            loop loop8
        mov  cx , 25
        mov dx , 0x0740
        loop9:
            mov [es:di] , dx
            add di , 2
            loop loop9
        mov  cx , 20
        mov dx , 0x0720
        loop11:
            mov [es:di] , dx
            add di , 2
            loop loop11

        mov  cx , 20
        mov dx , 0x0740
        loop12:
            mov [es:di] , dx
            add di , 2
            loop loop12
    inc si 
    cmp si , 10
    jne loop10

    

    pop si
    pop di
    pop es
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 



object:
    push bp
    mov bp , sp
    push ax 
    push di
    push es
    push dx

    mov di , [bp+4]
    mov ax , 0xb800
    mov es , ax
    mov dx , 0x0440
    mov [es:di] , dx

    pop dx
    pop es
    pop di
    pop ax
    pop bp
    ret 2

final:

    push ax 
    push di
    push es
    push dx

    mov di , 3830
    mov ax , 0xb800
    mov es , ax
    mov dx , 0x0240
    mov [es:di] , dx

    pop dx
    pop es
    pop di
    pop ax
    ret 

walls:
    push ax 
    push es
    push di
    push cx
    push dx

    mov dx , 0x0740
    mov ax , 0xb800
    mov es , ax
    mov di , 0
    mov cx , 80
    wloop1;
        mov [es:di] , dx
        add di , 2
        loop wloop1
    
    mov di , 0
    mov cx , 25
    wloop3;
        mov [es:di] , dx
        add di , 160
        loop wloop3

    mov di , 3840
    mov cx , 80
    wloop2;
        mov [es:di] , dx
        add di , 2
        loop wloop2


    mov di , 158
    mov cx , 25
    wloop4:
        mov [es:di] , dx
        add di , 160
        loop wloop4

    pop dx
    pop cx
    pop di
    pop es
    pop ax
    ret
showRem:
    push bp
    mov bp , sp
    push ax
    push bx
    push cx
    push dx
    push di
    push es
    mov di , 100
    mov ax , [bp+4]
    mov bx , 10
    
    mov cx , 0
    dloop1:
        div bx
        mov dh , 0x07
        push dx
        inc cx 
        cmp ax , 0
        ja dloop1
    mov ax , 0xb800
    mov es , ax
    dloop2:
        pop dx
        mov al , 20
        add dl , al
        mov [es:di] , dx
        add di ,2
        loop dloop2
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 2



start:
mov ax , 0xb800
mov es , ax
mov cx ,100
mov ax , 100
mov dx , 440
mov al , 0
mov si , 100
loop20:

    cmp al , 'a'
    je a
    cmp al , 'w'
    je w
    cmp al , 's'
    je s
    cmp al , 'd'
    je d

    w:sub dx , 160
    mov di , dx
    cmp word[es:di] , 0x0740
    je wyes
    jne end
    wyes:
        add dx , 160
    jmp end

    a:sub dx , 2
    mov di , dx
    cmp word[es:di] , 0x0740
    je ayes
    jne end
    ayes:
        add dx , 2
    jmp end

    s:add dx , 160
    mov di , dx
    cmp word[es:di] , 0x0740
    je syes
    jne end
    syes:
        sub dx , 160
    jmp end

    d:add dx , 2
    mov di , dx
    cmp word[es:di] , 0x0740
    je dyes
    jne end
    dyes:
        sub dx , 2
    end:

    call clr
    
    

    call display
    call walls

    push dx
    call object

    call final

    
    mov ah , 1
    int 21h
    

    loop loop20

    


 mov ax, 0x4c00 
 int 0x21

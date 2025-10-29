section .text
    global int_to_str


int_to_str:
; Converti un int en str
; rdi - le int
; rsi - le buffer qui va accueillir la str
; return - la str (car le buffer contient des espaces vides au début qui empechent le print)
    push rbp
    mov rbp, rsp

    push rcx
    push rdi
    push rsi
    push rdx

    xor rax, rax

    mov rax, rdi
    add rsi, 9
    mov [rsi], byte 0
    mov rcx, 10
    .int_to_str_loop:
        cmp rax, byte 0
        je .int_to_str_end

        xor rdx, rdx
        div rcx
        add dl, 48

        dec rsi
        mov [rsi], dl
        jmp .int_to_str_loop
    
    .int_to_str_end:
        mov rax, rsi

        pop rdx
        pop rsi
        pop rdi
        pop rcx

        mov rsp, rbp
        pop rbp
        ret
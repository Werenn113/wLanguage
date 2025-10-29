section .text
    global str_to_int


str_to_int:
; Converti une str en int
; rdi - la str
; return - le int
    push rbp
    mov rbp, rsp

    push rcx
    push rdi
    push rsi
    push rdx

    xor rax, rax
    xor rsi, rsi
    mov rcx, 10
    .str_to_int_loop:
        cmp [rdi], byte 0
        je .str_to_int_end

        mov sil, [rdi]
        sub sil, 48
        mul rcx
        add rax, rsi

        inc rdi
        jmp .str_to_int_loop

    .str_to_int_end:
        pop rdx
        pop rsi
        pop rdi
        pop rcx

        mov rsp, rbp
        pop rbp
        ret


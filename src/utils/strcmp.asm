section .text
    global strcmp
    extern strlen


strcmp:
; Compare deux str
; rdi - la 1ere
; rsi - la 2eme
; return - 1 si egales, 0 sinon
    push rbp
    mov rbp, rsp

    push rcx
    push rdi
    push rsi
    push rdx
    push r8
    push r9
    
    call strlen
    mov rdx, rax

    push rdi
    mov rdi, rsi
    call strlen
    pop rdi

    cmp rdx, rax
    jne .strcmp_not_equal

    xor rcx, rcx
    .strcmp_loop:
        cmp rcx, rdx
        je .strcmp_equal

        mov r8b, [rdi+rcx]
        mov r9b, [rsi+rcx]
        cmp r8b, r9b
        jne .strcmp_not_equal

        inc rcx
        jmp .strcmp_loop

    .strcmp_not_equal:
        mov rax, 0
        jmp .strcmp_loop_end

    .strcmp_equal:
        mov rax, 1
        jmp .strcmp_loop_end

    .strcmp_loop_end:
        pop r9
        pop r8
        pop rdx
        pop rsi
        pop rdi
        pop rcx

        mov rsp, rbp
        pop rbp
        ret
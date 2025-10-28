section .text
    global split


split:
; Split une str en fonction du séparateur rsi
; rdi - la str
; rsi - le supérateur
; rdx - le tableau
; return - le nombre d'éléments après séparation
    push rbp
    mov rbp, rsp

    push rcx
    push rdi
    push rsi
    push r8
    push r9
    push r10

    xor rcx, rcx
    xor r8, r8
    mov r9b, [rsi]
    xor rax, rax
    .split_loop:
        cmp [rdi], byte 0
        je .split_loop_end

        cmp [rdi], r9b
        je .split_sep_find

        inc rdi
        inc rcx
        jmp .split_loop

    .split_sep_find:
        mov [rdi], byte 0
        neg rcx
        lea r8, [rdi+rcx]
        mov [rdx+rax*8], r8

        xor rcx, rcx
        inc rdi
        inc rax
        jmp .split_loop

    .split_loop_end:
        mov [rdi], byte 0
        neg rcx
        lea r8, [rdi+rcx]
        mov [rdx+rax*8], r8

        xor rcx, rcx
        inc rdi
        inc rax
   
        pop r10
        pop r9
        pop r8
        pop rsi
        pop rdi
        pop rcx

        mov rsp, rbp
        pop rbp
        ret
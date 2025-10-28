section .data
    var_undifined_msg db "Variable undifined", 0

section .text
    global get_value
    extern error


get_value:
; Renvoie la valeur que contient une variable
; rdi - le nom de la variable
; rsi - les variables
; rdx - le nombre de variables
; r8 - varsize
; return - void
    push rbp
    mov rbp, rsp

    push rcx
    push rdi
    push rsi
    push rdx
    push r8

    mov rdx, [rdx]
    xor rcx, rcx
    .get_value_loop:
        cmp cl, dl
        je .get_value_error
        
        push rcx
        imul rcx, r8
        lea rcx, [rsi + rcx]
        mov rcx, [rcx]

        cmp cl, [rdi]
        pop rcx
        je .get_value_find

        inc rcx
        jmp .get_value_loop

    .get_value_find:
        imul rcx, r8
        lea rax, [rsi + rcx + 32]
        jmp .get_value_end

    .get_value_error:
        mov rdi, var_undifined_msg
        call error

    .get_value_end:
        pop r8
        pop rdx
        pop rsi
        pop rdi
        pop rcx

        mov rsp, rbp
        pop rbp
        ret
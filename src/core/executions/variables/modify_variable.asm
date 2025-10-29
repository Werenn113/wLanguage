section .data
    var_undifined_msg db "Variable undifined", 0

section .text
    global modify_variable
    extern error


modify_variable:
; Modifie la valeur d'une variable
; rdi - le nom de la variable
; rsi - la valeur à placer
; rdx - les variables
; r8 - le nombre de variables
; r9 - varsize
; return - void
    push rbp
    mov rbp, rsp

    push rcx
    push rdi
    push rsi
    push rdx
    push r8
    push r9

    mov r8, [r8]
    xor rcx, rcx
    .modify_variable_loop:
        cmp cl, r8b
        je .modify_variable_error

        push rcx
        imul rcx, r9
        lea rcx, [rdx + rcx]
        mov rcx, [rcx]

        cmp cl, [rdi]
        pop rcx
        je .modify_variable_find

        inc rcx
        jmp .modify_variable_loop

    .modify_variable_find:
        imul rcx, r9
        lea rax, [rdx + rcx + 32]
        mov rsi, [rsi]
        mov [rax], rsi
        jmp .modify_variable_end

    .modify_variable_error:
        mov rdi, var_undifined_msg
        call error
    
    .modify_variable_end
        pop r9
        pop r8
        pop rdx
        pop rsi
        pop rdi
        pop rcx

        mov rsp, rbp
        pop rbp
        ret
section .data
    too_much_var_msg db "Trop de variables, seulement 100 variables sont acceptées", 0


section .text
    global add_variable
    extern add_variable_name
    extern error


add_variable:
; Ajoute une variable
; rdi - le nom
; rsi - la valeur
; rdx - la table des variables
; r8  - le compteur de variables
; r9  - la taille des variables
; return - void
    push rbp
    mov rbp, rsp

    push rcx
    push rdi
    push rsi
    push rdx
    push r8
    push r9
    push r10

    xor rax, rax

    mov al, [r8]
    cmp al, 100
    jge .add_variable_error

    mov rcx, r9
    imul rcx, rax
    lea r10, [rdx + rcx]

    ; mov rdi, rdi
    push rax
    push rsi
    mov rsi, r10
    call add_variable_name

    pop rsi
    mov rcx, r9
    sub rcx, 8
    mov rax, [rsi]
    mov [r10+rcx], rax

    pop rax
    inc al
    mov [r8], al


    pop r10
    pop r9
    pop r8
    pop rdx
    pop rsi
    pop rdi
    pop rcx

    mov rsp, rbp
    pop rbp
    ret

    .add_variable_error:
        mov rdi, too_much_var_msg
        call error
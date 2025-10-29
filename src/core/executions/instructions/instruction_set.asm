section .text
    global instruction_set

    extern add_variable


instruction_set:
; Fait appel à la fonction pour ajouter une variables
; rdi - la ligne de code
; rsi - les variables
; rdx - le nombre de variables
; r8 - varsize
; return - void
    push rbp
    mov rbp, rsp

    push rdi
    push rsi
    push rdx
    push r8
    push r9

    xor rax, rax
    mov al, [rdx]
    cmp al, 0
    jne .already_initialized
    mov [rdx], al

    .already_initialized:

    mov r9, r8
    mov r8, rdx
    mov rdx, rsi
    mov rsi, [rdi + 16]
    mov rdi, [rdi + 8]
    call add_variable

    pop r9
    pop r8
    pop rdx
    pop rsi
    pop rdi

    mov rsp, rbp
    pop rbp
    ret
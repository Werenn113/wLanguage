section .data
    separator db " : ", 0
    return db 10, 0

section .text
    global print_a_variable
    extern print
    extern get_value


print_a_variable:
; Affiche une variable
; rdi - le nom de la variable
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

    ; mov rdi, rdi
    ; mov rsi, rsi
    ; mov rdx, rdx
    ; mov r8, r8
    call get_value

    push rax
    ; mov rdi, rdi
    call print

    mov rdi, separator
    call print

    pop rdi
    call print

    mov rdi, return
    call print

    pop r8
    pop rdx
    pop rsi
    pop rdi

    mov rsp, rbp
    pop rbp
    ret


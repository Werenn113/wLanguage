section .text
    global instruction_print

    extern print_a_variable
    

instruction_print:
; Fait appel à la fonction qui permet d'afficher une variable
; rdi - la ligne de code
; rsi - variables
; rdx - variables_count
; r8 - varsize
; return - void
    push rbp
    mov rbp, rsp

    push rdi
    push rsi
    push rdx
    push r8

    mov rdi, [rdi+8]
    ; mov rsi, rsi
    ; mov rdx, rdx
    ; mov r8, r8
    call print_a_variable

    pop r8
    pop rdx
    pop rsi
    pop rdi

    mov rsp, rbp
    pop rbp
    ret
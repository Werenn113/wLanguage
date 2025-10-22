bits 64

section .text
    global print
    extern strlen

print:
; Affiche une str
; rdi - la str
; return - void
    push rdi
    call strlen
    mov rdx, rax

    pop rdi
    mov rax, 1
    mov rsi, rdi
    mov rdi, 1
    syscall

    ret
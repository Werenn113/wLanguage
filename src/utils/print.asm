bits 64

section .text
    global print
    extern strlen

print:
; Affiche une str
; rdi - la str
; return - void
    push rbp
    mov rbp, rsp

    push rdi
    push rsi
    push rdx

    push rdi
    call strlen
    mov rdx, rax

    pop rdi
    mov rax, 1
    mov rsi, rdi
    mov rdi, 1
    syscall

    pop rdx
    pop rsi
    pop rsi

    mov rsp, rbp
    pop rbp
    ret
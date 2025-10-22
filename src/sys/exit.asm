bits 64

section .text
    global exit

exit:
; Déclenche la fin du prog
; rdi - error code (1 = error)
; return - void
    mov rax, 60
    syscall
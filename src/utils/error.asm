section .text
    global error
    extern print
    extern exit

error:
; Affiche un message d'erreur et quitte le prog
; rdi - le message
; return - void
    ;mov rdi, rdi inutile
    call print

    mov rdi, 1
    call exit
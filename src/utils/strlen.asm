bits 64

section .text
    global strlen

strlen:
; Calcule la longueur d'un str terminé par un nullbyte
; rdi - la str
; return - la longueur
    push rbp
    mov rbp, rsp

    push rdi

    xor rax, rax
    .strlen_loop:
        cmp byte [rdi], 0
        je .strlen_end

        inc rax
        inc rdi
        jmp .strlen_loop

    .strlen_end:
        pop rdi

        mov rsp, rbp
        pop rbp
        ret
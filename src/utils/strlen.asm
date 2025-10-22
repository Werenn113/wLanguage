bits 64

section .text
    global strlen

strlen:
; Calcule la longueur d'un str terminé par un nullbyte
; rdi - la str
; return - la longueur
    xor rax, rax
    .strlen_loop:
        cmp [rdi], byte 0
        je .strlen_end

        inc rax
        inc rdi
        jmp .strlen_loop

    .strlen_end:
        ret
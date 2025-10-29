section .data
    add_str db "add", 0
    sub_str db "sub", 0
    mul_str db "mul", 0
    div_str db "div", 0
    rem_str db "rem", 0
    operations:
        dq add_str, addition
        dq sub_str, subtraction
        dq mul_str, multiplication
        dq div_str, division
        dq rem_str, remainder


section .bss
    buffer resb 10


section .text
    global instruction_operation

    extern get_value
    extern str_to_int
    extern int_to_str
    extern modify_variable
    extern strcmp


instruction_operation:
; Fait appel à la fonction pour faire une addition
; rdi - la ligne de code
; rsi - les variables
; rdx - le nombre de variables
; r8 - varsize
; return - void
    push rbp
    mov rbp, rsp

    mov r9, rdi
    mov r10, rsi

    mov rdi, [r9 + 8]
    mov rsi, r10
    ; mov rdx, rdx
    ; mov r8, r8
    call get_value

    mov rdi, rax
    call str_to_int
    mov r11, rax

    mov rdi, [r9 + 16]
    call get_value

    mov rdi, rax
    call str_to_int
    mov r12, rax

    lea rcx, [operations]
    .instruction_operation_loop:
        mov rdi, [rcx]

        mov rsi, rdi
        mov rdi, [r9]
        call strcmp
        cmp rax, 1
        je .call_operation

        add rcx, 16
        jmp .instruction_operation_loop

    .call_operation:
        mov rax, [rcx + 8]
        mov rdi, r11
        mov rsi, r12
        call rax

        mov rdi, rax
        mov rsi, buffer
        call int_to_str

        mov rdi, [r9 + 8]
        mov r9, r8
        mov r8, rdx
        mov rdx, r10
        mov rsi, rax
        call modify_variable
        mov rsp, rbp
        pop rbp
        ret


addition:
; Additionne 2 nombres
; rdi - premier nombre
; rsi - deuxième nombre
; return - le résultat
    mov rax, rdi
    add rax, rsi
    ret


subtraction:
; Soustrait 2 nombres
; rdi - premier nombre
; rsi - deuxième nombre
; return - le résultat
    mov rax, rdi
    sub rax, rsi
    ret


multiplication:
; Multiplie 2 nombres
; rdi - premier nombre
; rsi - deuxième nombre
; return - le résultat
    push rdx
    mov rax, rdi
    mul rsi
    pop rdx
    ret


division:
; Divise 2 nombres
; rdi - premier nombre
; rsi - deuxième nombre
; return - le résultat
    push rdx
    xor rdx, rdx
    mov rax, rdi
    div rsi
    pop rdx
    ret


remainder:
; Renvoie le reste de la division de 2 nombres
; rdi - premier nombre
; rsi - deuxième nombre
; return - le résultat
    push rdx
    xor rdx, rdx
    mov rax, rdi
    div rsi
    mov rax, rdx
    pop rdx
    ret
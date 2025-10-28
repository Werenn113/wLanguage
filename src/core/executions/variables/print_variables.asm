section .data
    separator db " : ", 0
    return db 10, 0


section .text
    global print_variables
    extern print


print_variables:
; Affiche les variables sauvegardées
; rdi - les variables
; rsi - le nombre de variables
; rdx - varsize
; return void
    push rbp
    mov rbp, rsp

    push rcx
    push rdi
    push rsi
    push rdx
    push r8
    push r9
    push r10

    xor rcx, rcx
    mov r8, rdi
    mov r9b, [rsi]
    mov r10, rdx
    .print_variables_loop:
        cmp rcx, r9
        je .print_variables_end
        push rcx

        imul rcx, r10
        lea rsi, [r8 + rcx]

        mov rax, 1
        mov rdi, 1
        ; mov rsi, rsi
        mov rdx, 32
        syscall

        mov rdi, separator
        call print

        lea rdi, [r8 + 32]
        call print

        mov rdi, return
        call print

        pop rcx
        inc rcx
        jmp .print_variables_loop

    .print_variables_end:
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rsi
        pop rdi
        pop rcx

        mov rsp, rbp
        pop rbp
        ret
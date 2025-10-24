default rel

VAR_SIZE equ 40 ; [0..31] nom et [32..39] valeur

section .data
    set_str db "set", 0
    cmds:
        dq set_str, set
        dq 0, 0 


section .bss
    variables resb VAR_SIZE * 100 ; 100 variables
    variables_count resb 1


section .text
    global execute
    extern add_variable
    extern print_variables
    extern strcmp

    extern print

    extern exit


execute:
; Execute 1 ligne de code
; rdi - la ligne de code
; return - void
    push rcx
    push rdi
    push rsi
    push rdx

    mov rcx, rdi
    lea rcx, [cmds]
    .execute_loop:
        mov rax, [rcx]
        test rax, rax
        je .execute_loop_end

        mov rdi, [rdx]
        mov rsi, rax
        call strcmp
        cmp rax, 1
        je .call_func

        add rcx, 16
        jmp .execute_loop
    
    .call_func:
        mov rdi, rdx ; on récupère la ligne de code
        mov rax, [rcx + 8]
        call rax
        jmp .execute_loop_end
    
    .execute_loop_end:
        pop rdx
        pop rsi
        pop rdi
        pop rcx
        ret


set:
; Définie une variable
; rdi - la ligne de code
; return - void
    push rdi
    push rsi
    push rdx
    push r8
    push r9

    xor rax, rax
    mov al, [variables_count]
    cmp al, 0
    jne .already_initialized
    mov [variables_count], al

    .already_initialized:

    mov rdx, variables
    mov r8, variables_count
    mov r9, VAR_SIZE
    mov rsi, [rdi + 16]
    mov rdi, [rdi + 8]
    call add_variable

    mov rdi, variables
    mov rsi, variables_count
    mov rdx, VAR_SIZE
    call print_variables

    pop r9
    pop r8
    pop rdx
    pop rsi
    pop rdi
    ret
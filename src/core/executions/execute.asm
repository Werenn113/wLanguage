default rel

VAR_SIZE equ 40 ; [0..31] nom et [32..39] valeur

section .data
    set_str db "set", 0
    print_str db "print", 0
    add_str db "add", 0
    sub_str db "sub", 0
    mul_str db "mul", 0
    div_str db "div", 0
    rem_str db "rem", 0
    cmds:
        dq set_str, instruction_set
        dq print_str, instruction_print
        dq add_str, instruction_operation
        dq sub_str, instruction_operation
        dq mul_str, instruction_operation
        dq div_str, instruction_operation
        dq rem_str, instruction_operation
        dq 0, 0 


section .bss
    variables resb VAR_SIZE * 100 ; 100 variables
    variables_count resb 1


section .text
    global execute

    extern strcmp

    extern instruction_set
    extern instruction_print
    extern instruction_operation


execute:
; Execute 1 ligne de code
; rdi - la ligne de code
; return - void
    push rbp
    mov rbp, rsp
    
    push rcx
    push rdi
    push rsi
    push rdx

    mov rdx, rdi
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
        mov rax, [rcx + 8]
        mov rdi, rdx ; on récupère la ligne de code
        mov rsi, variables
        mov rdx, variables_count
        mov r8, VAR_SIZE
        call rax
        jmp .execute_loop_end
    
    .execute_loop_end:
        pop rdx
        pop rsi
        pop rdi
        pop rcx

        mov rsp, rbp
        pop rbp
        ret
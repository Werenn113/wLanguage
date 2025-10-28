default rel

VAR_SIZE equ 40 ; [0..31] nom et [32..39] valeur

section .data
    set_str db "set", 0
    print_str db "print", 0
    add_str db "add", 0
    cmds:
        dq set_str, set
        dq print_str, print
        dq add_str, addition
        dq 0, 0 


section .bss
    variables resb VAR_SIZE * 100 ; 100 variables
    variables_count resb 1


section .text
    global execute
    
    extern add_variable
    extern print_variables
    extern strcmp
    extern print_a_variable
    extern get_value


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

        mov rsp, rbp
        pop rbp
        ret


set:
; Fait appel à la fonction pour ajouter une variables
; rdi - la ligne de code
; return - void
    push rbp
    mov rbp, rsp

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

    pop r9
    pop r8
    pop rdx
    pop rsi
    pop rdi

    mov rsp, rbp
    pop rbp
    ret


print:
; Fait appel à la fonction qui permet d'afficher une variable
; rdi - la ligne de code
; return - void
    push rbp
    mov rbp, rsp

    push rdi
    push rsi
    push rdx
    push r8

    mov rdi, [rdi+8]
    mov rsi, variables
    mov rdx, variables_count
    mov r8, VAR_SIZE
    call print_a_variable

    pop r8
    pop rdx
    pop rsi
    pop rdi

    mov rsp, rbp
    pop rbp
    ret


addition:
; Fait appel à la fonction pour faire une addition
; rdi - la ligne de code
; return - void
    push rbp
    mov rbp, rsp

    push rdi

    mov rdi, [rdi + 8]
    mov rsi, variables
    mov rdx, variables_count
    mov r8, VAR_SIZE
    call get_value

    pop rdi
    
    mov dl, [rax]

    mov rdi, [rdi + 16]
    call get_value


    add rax, r8

    mov rsp, rbp
    pop rbp
    ret

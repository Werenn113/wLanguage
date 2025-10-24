section .text
    global add_variable_name


add_variable_name:
; Ajoute le nom de la variable dans la table de variables
; rdi - le nom
; rsi - l'adresse ou placer le nom
; return - void
    push rdi
    push rsi

    .add_name_loop:
        cmp byte [rdi], 0
        je .add_name_end
        mov al, [rdi]
        mov [rsi], al
        inc rdi
        inc rsi
        jmp .add_name_loop
    
    .add_name_end:
        pop rsi
        pop rdi
        ret
section .data
    open_file_error_msg db "Erreur, Le fichier est introuvable", 10, 0
    read_file_error_msg db "Erreur, le fichier est illisible", 10, 0


section .text
    global read_part_of_file
    global open_file
    global close_file
    extern print
    extern exit
    extern error


open_file:
; Ouvre le fichier
; rdi - pathname
; return - le filedescriptor
    push rbp
    mov rbp, rsp

    push rdi
    push rsi

    mov rax, 2
    ; mov rdi, rdi inutile car rdi déjà bien défini
    mov rsi, 0 ; read-only
    syscall ; return le file descriptor

    cmp rax, 0
    jl .open_file_error

    pop rsi
    pop rdi

    mov rsp, rbp
    pop rbp
    ret

    .open_file_error:
        mov rdi, open_file_error_msg
        call error


read_part_of_file:
; Lis 512 octets du fichier
; rdi - file descriptor qui contient le fichier (0 = stdin, 1 = stdout, 2 = stderr, 3... nos fichiers)
; rsi - le buffer
; return - le nombre d'octet lu
    push rbp
    mov rbp, rsp

    push rdi
    push rsi
    push rdx

    mov rax, 0
    ;mov rdi, rdi inutile
    ;mov rsi, rsi
    mov rdx, 512
    syscall ; return le nombre de bits lu

    cmp rax, 0
    jl .read_octets_error

    pop rdx
    pop rsi
    pop rdi

    mov rsp, rbp
    pop rbp
    ret

    .read_octets_error:
        mov rdi, read_file_error_msg
        call error


close_file:
; Ferme le fichier
; rdi - le fd du fichier
; return - void
    push rbp
    mov rbp, rsp

    push rdi

    mov rax, 3
    mov rdi, 3
    ;mov rdi, rdi
    syscall

    pop rdi

    mov rsp, rbp
    pop rbp
    ret
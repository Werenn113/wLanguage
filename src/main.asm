bits 64

section .data
    pathname db "/home/werenn/code/assembleur/wLanguage/script.txt", 0
    space db ' '
    return db 10


section .bss
    buffer resb 512
    lignes_array resq 256 ; on stocke 256 pointeurs (les pointeurs sont sur 64 bits donc un quadword), 256 car dans le pire des cas on a 1 caratères par ligne, comme il y a le "\n", on divise par deux
    words_array resq 256 ; pareil mais avec les espaces


section .text
    global _start
    extern print
    extern open_file
    extern read_part_of_file
    extern split
    extern execute
    extern close_file
    extern exit


_start:
    ; Ouverture du fichier
    mov rdi, pathname
    call open_file
    mov rdi, rax

    ; On va lire le fichier 512 octets par 512 octets donc on fait une loop pour parcourir tout le fichier (ATTENTION : PROBLEME SI UNE LIGNE N'EST PAS TERMINEE AU 512ieme OCTET)
    .main_loop:
        ; c'est ici qu'on lit
        mov rdi, rdi
        mov rsi, buffer
        call read_part_of_file

        cmp rax, 0 ; si rax = 0, c'est qu'on a lu moins de 512 octets
        je .main_loop_end

        ; On sépare les lignes dans un tableau
        mov rdi, buffer
        mov rsi, return
        mov rdx, lignes_array
        call split
        mov r12, rax

        xor r13, r13
        .lignes_loop:
            cmp r13, r12
            je .main_loop_end
            mov rdi, [lignes_array + 8 * r13]
            mov rsi, space
            mov rdx, words_array
            call split

            mov rdi, rdx
            call execute

            inc r13
            jmp .lignes_loop

            


        ;jmp .main_loop

    .main_loop_end:
        call close_file

        mov rdi, 0
        call exit
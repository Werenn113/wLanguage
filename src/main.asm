bits 64

section .data
    msg db "hello", 10, 0
    pathname db "/home/werenn/Documents/Code/wLanguage/script.txt"


section .bss
    buffer resb 512


section .text
    global _start
    extern print
    extern open_file
    extern read_part_of_file
    extern close_file
    extern exit


_start:
    mov rdi, msg
    call print

    mov rdi, pathname
    call open_file

    .main_loop:
        mov rsi, buffer
        call read_part_of_file

        cmp rax, 0
        je .main_loop_end

        mov rdi, buffer
        call print

        jmp .main_loop

    .main_loop_end:
        call close_file

        mov rdi, 0
        call exit
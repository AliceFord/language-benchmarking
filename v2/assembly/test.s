.globl main

main:
    push %rbp
    mov %rsp, %rbp

    mov $4, %eax
    movb $4, buffer(%rax)
    xor %rsi, %rsi
    movb  buffer(%rax), %sil
    movl  $fmt, %edi 
    movl  $0, %eax 
    call  printf 

    pop %rbp
    movq    $60, %rax      # System call 60 is exit()
    movq    $0, %rdi       # Return code 0
    syscall

.bss

buffer: .space 100

.section .rodata
start: .ascii "s\n"
end: .ascii "f\n"
fmt: .ascii "%x\n"

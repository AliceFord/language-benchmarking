.globl main

main:
    push %rbp
    movq %rsp, %rbp
    movq    $1, %rax
    movq    $1, %rdi 
    mov     $start, %rsi 
    mov     $2, %rdx
    syscall

    sub $16, %rsp

    mov $25, %rax
    movl $0b1, -16(%rbp, %rax, 4)
    movl $0b1, -15(%rbp, %rax, 4)
    movl $0b1, -14(%rbp, %rax, 4)
    movl $0b1, -13(%rbp, %rax, 4)
    mov $14, %rcx
    sub %rcx, %rbp
    mov (%rbp, %rax, 4), %al

    mov $14, %rcx
    add %rcx, %rbp

    nop

    movl  %eax, %esi 
    movl  $fmt, %edi 
    movl  $0, %eax 
    call  printf 


    pop %rbp
    movq    $60, %rax      # System call 60 is exit()
    movq    $0, %rdi       # Return code 0
    syscall

.data
start: .ascii "s\n"
end: .ascii "f\n"
fmt: .ascii "%x\n"

.globl main

main:
    push %rbp
    mov %rsp, %rbp

    mov $arr, %ebx
    movl  %ebx, %esi 
    movl  $fmt, %edi 
    movl  $0, %eax 
    call  printf 

    mov $8000000, %rdx
writeDataLoop:
    sub %rdx, %rbp
    movb $0b1, (%rbp)

    add %rdx, %rbp

    sub $1, %rdx
    cmp $0, %rdx
    jg writeDataLoop

    movl  $1, %esi 
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
fmt: .ascii "%s\n"

arr: .space 100,0x61

.bss

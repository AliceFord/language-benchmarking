.globl main

main:
    movq    $1, %rax
    movq    $1, %rdi 
    mov     $start, %rsi 
    mov     $2, %rdx
    syscall

    mov $64, %eax
    call primeSieve

    mov %eax, %r15d  # output stored in r15d
    # mov %r15d, %esi
    # call printint
    cmp $6, %r15
    je success

    movq    $1, %rax
    movq    $1, %rdi 
    mov     $fail, %rsi 
    mov     $20, %rdx
    jmp endofprog

success:
    movq    $1, %rax
    movq    $1, %rdi 
    mov     $end, %rsi 
    mov     $2, %rdx
    syscall

endofprog:
    movq    $60, %rax      # System call 60 is exit()
    movq    $0, %rdi       # Return code 0
    syscall

primeSieve:
    pushq %rbp
    mov %eax, %r15d  # r15 contains n
    mov %r15d, %edx  # edx contains temp loop

writeDataLoop:
    pushw $0xffff
    sub $16, %rdx
    cmp $0, %rdx
    jnle writeDataLoop

    xor %rdx, %rdx
    mov $2, %r13d  # r13 is p
whileMain:
    # do stuff

    # if prime[p]
    mov %r13d, %eax
    mov $8, %ebx
    div %ebx
    mov %edx, %esi # esi contains offset mod 8
    mov $1, %ebx
    mul %ebx
    mov %eax, %r12d  # r12 contains offset div 8
    add %r12, %rsp  # Add on offset to stack pointer

    # mov (%rsp), %esi
    # call printint
    mov (%rsp), %r11d # c contains current 8-bit section

    nop

    mov $0x1, %eax  # const
    # mov %esi, %ebx  # copy to b
    mov %sil, %cl
    sal %cl, %eax  # bit
    and %r11d, %eax  # a contains prime[p]

    cmp $0, %eax
    sub %r12, %rsp
    je notprime

    mov %r13d, %eax
    mov $2, %r14d
    mul %r14d
    mov %eax, %r11d  # r11 is i

forloopstart:
    mov %r11d, %eax
    mov $8, %ebx
    div %ebx
    mov %edx, %esi # esi contains offset mod 8
    mov $1, %ebx
    mul %ebx
    mov %eax, %r12d  # r12 contains offset div 8
    add %r12, %rsp  # Add on offset to stack pointer

    # mov (%rsp), %esi
    # call printint
    mov (%rsp), %r8d # c contains current 8-bit section
    movl $0xefffffff, (%rsp)

    # mov $0x1, %eax  # const
    # mov %esi, %ebx  # copy to b
    # mov %sil, %cl
    # sal %cl, %eax  # bit
    # and %r8d, %eax  # a contains prime[p]

    nop
    # !!!
    # mov %r11d, %eax
    # mov $8, %eax
    # mul %r11d
    # mov %eax, %r12d  # r12 contains offset
    # add %r12, %rsp  # Add on offset to stack pointer

    # movq $0, (%rsp)  # prime[i] = 0

    nop

    sub %r12, %rsp

    add %r13, %r11 # i += p

    cmp %r15, %r11
    jle forloopstart

    nop

notprime:  # End of if statement

    # test if p * p <= n
    inc %r13d
    mov %r13d, %eax
    mul %eax
    cmp %r15d, %eax
    jle whileMain  # While loop over

    # add $8, %rsp
    # mov (%rsp), %esi
    # call printint

    # sub $8, %rsp


    xor %r13d, %r13d  # r13 now used for final count

    mov %r15d, %edx
readDataLoop:
    pop %r14
    cmp $0, %r14
    je skipincrement
    inc %r13

skipincrement:

    sub $1, %edx
    cmp $0, %edx
    jne readDataLoop

    sub $2, %r13

    mov %r13d, %eax  # return num with eax

    popq %rbp
    ret

printint:  # Push int to esi
    push %rdi
    push %rax
    # push %rdx
    pushq %rbp

    pushq   %rbp

    movl    $fmt, %edi
    movl    $0, %eax
    call    printf
    popq    %rbp

    popq	%rbp
    # pop %rdx
    pop %rax
    pop %rdi
    ret

.data
start: .ascii "s\n"
end: .ascii "f\n"
fmt: .ascii "%x\n"
fail: .ascii "Prime sieve failed!\n"

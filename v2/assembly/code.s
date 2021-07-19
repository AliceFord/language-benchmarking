.globl main

main:
    movq    $1, %rax
    movq    $1, %rdi 
    mov     $start, %rsi 
    mov     $2, %rdx
    syscall

    mov $100000000, %eax
    call primeSieve

    mov %eax, %r15d  # output stored in r15d
    nop
    # mov %r15d, %esi
    # call printint

    cmp $5761455, %r15
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
    mov %rsp, %rbp
    mov %eax, %r15d  # r15 contains n
    mov %r15d, %edx  # edx contains temp loop

writeDataLoop:
    movb $0b1, prime(%rdx)

    dec %rdx
    cmp $0, %rdx
    jg writeDataLoop

    mov $2, %r13d  # r13 is p
whileMain:
    # do stuff

#     xor %eax, %eax
    mov prime(%r13), %al

    cmp $0, %eax

    add %r13, %rbp

    je notprime

    mov %r13d, %eax
    mov $2, %ebx
    mul %ebx
    mov %eax, %r11d  # r11 is i

forloopstart:
    movb $0b0, prime(%r11) # prime[i] = 0

    add %r13, %r11 # i += p

    cmp %r15, %r11 # if i <= n
    jle forloopstart  # jump to forloopstart

notprime:  # End of if statement

    inc %r13d
    mov %r13d, %eax
    mul %eax
    cmp %r15d, %eax
    jle whileMain  # While loop over

    xor %r13d, %r13d  # r13 now used for final count
readDataLoop:
    mov prime(%r15), %al

    test %al, %al
    jz skipincrement
    inc %r13

skipincrement:
    sub $1, %r15d
    cmp $0, %r15d
    jne readDataLoop

    sub $1, %r13

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
fmt: .ascii "%d\n"
fail: .ascii "Prime sieve failed!\n"

.bss
prime: .space 100000000

	.file	"main.c"
	.text
	.p2align 4
	.globl	timeDelta
	.type	timeDelta, @function
timeDelta:
.LFB50:
	.cfi_startproc
	imulq	$1000000000, %rdi, %rdi
	imulq	$1000000000, %rdx, %rdx
	addq	%rsi, %rdi
	addq	%rcx, %rdx
	movq	%rdi, %rax
	subq	%rdx, %rax
	ret
	.cfi_endproc
.LFE50:
	.size	timeDelta, .-timeDelta
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Incorrect input"
.LC1:
	.string	"r"
.LC2:
	.string	"w"
.LC3:
	.string	"input"
.LC4:
	.string	"output"
.LC5:
	.string	"Time delta: %ld ns\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB51:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	movl	%edi, %r14d
	pushq	%r13
	.cfi_offset 13, -40
	movq	%rsi, %r13
	pushq	%r12
	pushq	%rbx
	subq	$104, %rsp
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	leaq	-999424(%rsp), %rax
	cmpq	%rax, %rsp
	je	.L5
.L32:
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	cmpq	%rax, %rsp
	jne	.L32
.L5:
	subq	$592, %rsp
	orq	$0, 584(%rsp)
	movq	%rsp, %r12
	cmpl	$3, %r14d
	jle	.L11
	movq	8(%r13), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	call	strtol@PLT
	movq	16(%r13), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	movq	%rax, -136(%rbp)
	call	strtol@PLT
	movq	24(%r13), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	movq	%rax, -128(%rbp)
	call	strtol@PLT
	testl	%eax, %eax
	jne	.L9
	cmpl	$4, %r14d
	je	.L11
	movq	32(%r13), %rdi
	xorl	%esi, %esi
	call	access@PLT
	testl	%eax, %eax
	je	.L33
.L11:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
.L8:
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	jne	.L34
	leaq	-40(%rbp), %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L9:
	.cfi_restore_state
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	call	fopen@PLT
	leaq	.LC2(%rip), %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, -112(%rbp)
	call	fopen@PLT
	movq	32(%r13), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movq	%rax, %r15
	call	strtol@PLT
	movl	%eax, %r13d
	cmpl	$1000000, %eax
	jg	.L11
	testl	%eax, %eax
	jle	.L15
	leaq	1(%rsp), %rbx
	subl	$1, %eax
	movq	%rsp, %r14
	addq	%rbx, %rax
	movq	%rax, -120(%rbp)
	jmp	.L16
	.p2align 4,,10
	.p2align 3
.L35:
	addq	$1, %rbx
.L16:
	call	rand@PLT
	movq	-112(%rbp), %rsi
	movl	%eax, %ecx
	sarl	$31, %ecx
	shrl	$25, %ecx
	leal	(%rax,%rcx), %edi
	andl	$127, %edi
	subl	%ecx, %edi
	movb	%dil, (%r14)
	movq	%rbx, %r14
	call	fputc@PLT
	cmpq	-120(%rbp), %rbx
	jne	.L35
.L15:
	movq	-136(%rbp), %rbx
	leaq	-96(%rbp), %rsi
	movl	$1, %edi
	movl	-128(%rbp), %r14d
	movl	%ebx, -112(%rbp)
	call	clock_gettime@PLT
	testl	%ebx, %ebx
	jle	.L17
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L18:
	movq	%r12, %rdx
	movl	%r13d, %esi
	movl	%r14d, %edi
	addl	$1, %ebx
	call	find@PLT
	movl	%eax, -100(%rbp)
	cmpl	-112(%rbp), %ebx
	jne	.L18
.L17:
	leaq	-80(%rbp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	imulq	$1000000000, -96(%rbp), %rax
	addq	-88(%rbp), %rax
	leaq	.LC5(%rip), %rsi
	imulq	$1000000000, -80(%rbp), %rdx
	addq	-72(%rbp), %rdx
	movl	$1, %edi
	subq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movl	-100(%rbp), %eax
	cmpl	$-1, %eax
	je	.L8
	movq	-128(%rbp), %rdx
	testl	%edx, %edx
	jle	.L8
	movslq	%eax, %rbx
	leal	-1(%rdx), %eax
	leaq	1(%r12,%rax), %rax
	leaq	(%r12,%rbx), %r13
	addq	%rax, %rbx
	.p2align 4,,10
	.p2align 3
.L20:
	movsbl	0(%r13), %edi
	movq	%r15, %rsi
	addq	$1, %r13
	call	fputc@PLT
	cmpq	%rbx, %r13
	jne	.L20
	jmp	.L8
.L33:
	movq	32(%r13), %rdi
	leaq	.LC1(%rip), %rsi
	xorl	%ebx, %ebx
	call	fopen@PLT
	movq	40(%r13), %rdi
	leaq	.LC2(%rip), %rsi
	movq	%rax, %r14
	call	fopen@PLT
	movq	%rax, %r15
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L14:
	addq	$1, %rbx
	cmpq	$1000001, %rbx
	je	.L11
.L13:
	movq	%r14, %rdi
	movl	%ebx, %r13d
	call	fgetc@PLT
	movb	%al, (%r12,%rbx)
	cmpb	$-1, %al
	jne	.L14
	movslq	%ebx, %rax
	movb	$0, (%r12,%rax)
	jmp	.L15
.L34:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE51:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits

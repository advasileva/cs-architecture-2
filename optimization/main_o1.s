	.file	"main.c"
	.text
	.globl	timeDelta
	.type	timeDelta, @function
timeDelta:
.LFB22:
	.cfi_startproc
	imulq	$1000000000, %rdx, %rdx
	imulq	$1000000000, %rdi, %rdi
	addq	%rsi, %rdi
	addq	%rcx, %rdx
	movq	%rdi, %rax
	subq	%rdx, %rax
	ret
	.cfi_endproc
.LFE22:
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
	.text
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$88, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movl	%edi, %r13d
	movq	%rsi, %rbx
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	leaq	-999424(%rsp), %rax
.L3:
	cmpq	%rax, %rsp
	je	.L4
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L3
.L4:
	subq	$592, %rsp
	orq	$0, 584(%rsp)
	movq	%rsp, %r12
	cmpl	$3, %r13d
	jle	.L26
	movq	8(%rbx), %rdi
	movl	$10, %edx
	movl	$0, %esi
	call	strtol@PLT
	movq	%rax, -128(%rbp)
	movq	16(%rbx), %rdi
	movl	$10, %edx
	movl	$0, %esi
	call	strtol@PLT
	movq	%rax, -120(%rbp)
	movq	24(%rbx), %rdi
	movl	$10, %edx
	movl	$0, %esi
	call	strtol@PLT
	testl	%eax, %eax
	jne	.L8
	cmpl	$4, %r13d
	jle	.L9
	movq	32(%rbx), %rdi
	movl	$0, %esi
	call	access@PLT
	testl	%eax, %eax
	je	.L10
.L9:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	jmp	.L7
.L26:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
.L7:
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	jne	.L27
	movl	$0, %eax
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L10:
	.cfi_restore_state
	movq	32(%rbx), %rdi
	leaq	.LC1(%rip), %rsi
	call	fopen@PLT
	movq	%rax, %r14
	movq	40(%rbx), %rdi
	leaq	.LC2(%rip), %rsi
	call	fopen@PLT
	movq	%rax, -112(%rbp)
	movl	$0, %ebx
.L11:
	movl	%ebx, %r13d
	movq	%r14, %rdi
	call	fgetc@PLT
	movb	%al, (%r12,%rbx)
	cmpb	$-1, %al
	je	.L28
	addq	$1, %rbx
	cmpq	$1000001, %rbx
	jne	.L11
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	jmp	.L7
.L28:
	movslq	%ebx, %rax
	movb	$0, (%r12,%rax)
	jmp	.L13
.L8:
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	call	fopen@PLT
	movq	%rax, %r15
	leaq	.LC2(%rip), %rsi
	leaq	.LC4(%rip), %rdi
	call	fopen@PLT
	movq	%rax, -112(%rbp)
	movq	32(%rbx), %rdi
	movl	$10, %edx
	movl	$0, %esi
	call	strtol@PLT
	movl	%eax, %r13d
	cmpl	$1000000, %eax
	jg	.L14
	testl	%eax, %eax
	jle	.L13
	movq	%r12, %rbx
	leal	-1(%rax), %eax
	leaq	1(%r12,%rax), %r14
.L16:
	call	rand@PLT
	cltd
	shrl	$25, %edx
	leal	(%rax,%rdx), %edi
	andl	$127, %edi
	subl	%edx, %edi
	movb	%dil, (%rbx)
	movsbl	%dil, %edi
	movq	%r15, %rsi
	call	fputc@PLT
	addq	$1, %rbx
	cmpq	%r14, %rbx
	jne	.L16
.L13:
	movq	-128(%rbp), %rbx
	movl	%ebx, %r15d
	movl	-120(%rbp), %r14d
	leaq	-96(%rbp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	testl	%ebx, %ebx
	jle	.L17
	movl	$0, %ebx
.L18:
	movq	%r12, %rdx
	movl	%r13d, %esi
	movl	%r14d, %edi
	call	find@PLT
	movl	%eax, -100(%rbp)
	addl	$1, %ebx
	cmpl	%r15d, %ebx
	jne	.L18
.L17:
	leaq	-80(%rbp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	-96(%rbp), %rdx
	movq	-88(%rbp), %rcx
	movq	-80(%rbp), %rdi
	movq	-72(%rbp), %rsi
	call	timeDelta
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-100(%rbp), %eax
	cmpl	$-1, %eax
	je	.L7
	movq	-120(%rbp), %rcx
	testl	%ecx, %ecx
	jle	.L7
	cltq
	leaq	(%r12,%rax), %rbx
	leal	-1(%rcx), %edx
	leaq	1(%r12,%rdx), %r12
	addq	%rax, %r12
.L19:
	movsbl	(%rbx), %edi
	movq	-112(%rbp), %rsi
	call	fputc@PLT
	addq	$1, %rbx
	cmpq	%r12, %rbx
	jne	.L19
	jmp	.L7
.L14:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	jmp	.L7
.L27:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits

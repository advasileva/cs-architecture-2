	.file	"main.c"
	.text
	.globl	timeDelta
	.type	timeDelta, @function
timeDelta:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rsi, %rax
	movq	%rdi, %r8
	movq	%r8, %rsi
	movq	%r9, %rdi
	movq	%rax, %rdi
	movq	%rsi, -32(%rbp)
	movq	%rdi, -24(%rbp)
	movq	%rdx, -48(%rbp)
	movq	%rcx, -40(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	imulq	$1000000000, %rax, %rax
	movq	%rax, -16(%rbp)
	movq	-40(%rbp), %rax
	addq	%rax, -16(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	imulq	$1000000000, %rax, %rax
	movq	%rax, -8(%rbp)
	movq	-24(%rbp), %rax
	addq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	subq	-16(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	timeDelta, .-timeDelta
	.section	.rodata
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
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$152, %rsp
	.cfi_offset 3, -24
	movl	%edi, -148(%rbp)
	movq	%rsi, -160(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movq	%rsp, %rax
	movq	%rax, %rbx
	movl	$1000000, -116(%rbp)
	movl	-116(%rbp), %eax
	addl	$1, %eax
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -96(%rbp)
	movslq	%eax, %rdx
	movq	%rdx, %r10
	movl	$0, %r11d
	movslq	%eax, %rdx
	movq	%rdx, %r8
	movl	$0, %r9d
	cltq
	movl	$16, %edx
	subq	$1, %rdx
	addq	%rdx, %rax
	movl	$16, %ecx
	movl	$0, %edx
	divq	%rcx
	imulq	$16, %rax, %rax
	movq	%rax, %rcx
	andq	$-4096, %rcx
	movq	%rsp, %rdx
	subq	%rcx, %rdx
.L4:
	cmpq	%rdx, %rsp
	je	.L5
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L4
.L5:
	movq	%rax, %rdx
	andl	$4095, %edx
	subq	%rdx, %rsp
	movq	%rax, %rdx
	andl	$4095, %edx
	testq	%rdx, %rdx
	je	.L6
	andl	$4095, %eax
	subq	$8, %rax
	addq	%rsp, %rax
	orq	$0, (%rax)
.L6:
	movq	%rsp, %rax
	addq	$0, %rax
	movq	%rax, -88(%rbp)
	cmpl	$3, -148(%rbp)
	jg	.L7
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L8
.L7:
	movq	-160(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, -112(%rbp)
	movq	-160(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, -108(%rbp)
	movq	-160(%rbp), %rax
	addq	$24, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	testl	%eax, %eax
	jne	.L9
	cmpl	$4, -148(%rbp)
	jle	.L10
	movq	-160(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	access@PLT
	testl	%eax, %eax
	je	.L11
.L10:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L8
.L11:
	movq	-160(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	leaq	.LC1(%rip), %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -80(%rbp)
	movq	-160(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rax
	leaq	.LC2(%rip), %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -104(%rbp)
	movl	$0, -120(%rbp)
.L13:
	movl	-120(%rbp), %eax
	cmpl	-116(%rbp), %eax
	jle	.L12
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L8
.L12:
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	fgetc@PLT
	movb	%al, -129(%rbp)
	movl	-120(%rbp), %eax
	leal	1(%rax), %edx
	movl	%edx, -120(%rbp)
	movq	-88(%rbp), %rdx
	cltq
	movzbl	-129(%rbp), %ecx
	movb	%cl, (%rdx,%rax)
	cmpb	$-1, -129(%rbp)
	jne	.L13
	subl	$1, -120(%rbp)
	movq	-88(%rbp), %rdx
	movl	-120(%rbp), %eax
	cltq
	movb	$0, (%rdx,%rax)
	jmp	.L14
.L9:
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	call	fopen@PLT
	movq	%rax, -80(%rbp)
	leaq	.LC2(%rip), %rsi
	leaq	.LC4(%rip), %rdi
	call	fopen@PLT
	movq	%rax, -104(%rbp)
	movq	-160(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, -120(%rbp)
	movl	-120(%rbp), %eax
	cmpl	-116(%rbp), %eax
	jle	.L15
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L8
.L15:
	movl	$0, -128(%rbp)
	jmp	.L16
.L17:
	call	rand@PLT
	cltd
	shrl	$25, %edx
	addl	%edx, %eax
	andl	$127, %eax
	subl	%edx, %eax
	movl	%eax, %ecx
	movq	-88(%rbp), %rdx
	movl	-128(%rbp), %eax
	cltq
	movb	%cl, (%rdx,%rax)
	movq	-88(%rbp), %rdx
	movl	-128(%rbp), %eax
	cltq
	movzbl	(%rdx,%rax), %eax
	movsbl	%al, %eax
	movq	-80(%rbp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc@PLT
	addl	$1, -128(%rbp)
.L16:
	movl	-128(%rbp), %eax
	cmpl	-120(%rbp), %eax
	jl	.L17
.L14:
	leaq	-64(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movl	$0, -128(%rbp)
	jmp	.L18
.L19:
	movq	-88(%rbp), %rdx
	movl	-120(%rbp), %ecx
	movl	-108(%rbp), %eax
	movl	%ecx, %esi
	movl	%eax, %edi
	call	find@PLT
	movl	%eax, -124(%rbp)
	addl	$1, -128(%rbp)
.L18:
	movl	-128(%rbp), %eax
	cmpl	-112(%rbp), %eax
	jl	.L19
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	-64(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	call	timeDelta
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$-1, -124(%rbp)
	je	.L20
	movl	$0, -128(%rbp)
	jmp	.L21
.L22:
	movl	-124(%rbp), %edx
	movl	-128(%rbp), %eax
	addl	%edx, %eax
	movq	-88(%rbp), %rdx
	cltq
	movzbl	(%rdx,%rax), %eax
	movsbl	%al, %eax
	movq	-104(%rbp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc@PLT
	addl	$1, -128(%rbp)
.L21:
	movl	-128(%rbp), %eax
	cmpl	-108(%rbp), %eax
	jl	.L22
.L20:
	movl	$0, %eax
.L8:
	movq	%rbx, %rsp
	movq	-24(%rbp), %rbx
	subq	%fs:40, %rbx
	je	.L24
	call	__stack_chk_fail@PLT
.L24:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits

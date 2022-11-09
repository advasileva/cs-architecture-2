	.file	"main.c"
	.text
	.globl	timeDelta
	.type	timeDelta, @function
timeDelta:
.LFB35:
	.cfi_startproc
	imulq	$1000000000, %rdi, %rdi
	imulq	$1000000000, %rdx, %rdx
	addq	%rsi, %rdi
	addq	%rcx, %rdx
	movq	%rdi, %rax
	subq	%rdx, %rax
	ret
	.cfi_endproc
.LFE35:
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
	.globl	main
	.type	main, @function
main:
.LFB36:
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
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	movl	%edi, %r12d
	pushq	%rbx
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$72, %rsp
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
	movq	%rsp, %r13
	cmpl	$3, %r12d
	jg	.L6
.L10:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	jmp	.L7
.L6:
	movq	8(%rbx), %rdi
	call	atoi@PLT
	movq	16(%rbx), %rdi
	movl	%eax, -104(%rbp)
	call	atoi@PLT
	movq	24(%rbx), %rdi
	movl	%eax, %r14d
	call	atoi@PLT
	testl	%eax, %eax
	jne	.L8
	cmpl	$4, %r12d
	je	.L10
	movq	32(%rbx), %rdi
	xorl	%esi, %esi
	call	access@PLT
	testl	%eax, %eax
	jne	.L10
	movq	32(%rbx), %rdi
	leaq	.LC1(%rip), %rsi
	call	fopen@PLT
	movq	40(%rbx), %rdi
	leaq	.LC2(%rip), %rsi
	movq	%rax, %r15
	call	fopen@PLT
	xorl	%edx, %edx
	movq	%rax, %r12
.L12:
	movq	%r15, %rdi
	movq	%rdx, -112(%rbp)
	movl	%edx, %ebx
	call	fgetc@PLT
	movq	-112(%rbp), %rdx
	movb	%al, 0(%r13,%rdx)
	incb	%al
	je	.L30
	incq	%rdx
	cmpq	$1000001, %rdx
	jne	.L12
	jmp	.L10
.L30:
	movslq	%ebx, %rax
	movb	$0, 0(%r13,%rax)
	jmp	.L14
.L8:
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	xorl	%r15d, %r15d
	call	fopen@PLT
	leaq	.LC2(%rip), %rsi
	leaq	.LC4(%rip), %rdi
	movq	%rax, -112(%rbp)
	call	fopen@PLT
	movq	32(%rbx), %rdi
	movq	%rax, %r12
	call	atoi@PLT
	movl	%eax, %ebx
	cmpl	$1000000, %eax
	jg	.L10
.L15:
	cmpl	%r15d, %ebx
	jle	.L14
	call	rand@PLT
	movl	$128, %ecx
	movq	-112(%rbp), %rsi
	cltd
	idivl	%ecx
	movl	%edx, %edi
	movb	%dl, 0(%r13,%r15)
	incq	%r15
	call	fputc@PLT
	jmp	.L15
.L14:
	leaq	-88(%rbp), %rsi
	movl	$1, %edi
	xorl	%r15d, %r15d
	call	clock_gettime@PLT
.L17:
	cmpl	-104(%rbp), %r15d
	jge	.L31
	movq	%r13, %rdx
	movl	%ebx, %esi
	movl	%r14d, %edi
	incl	%r15d
	call	find@PLT
	movl	%eax, -100(%rbp)
	jmp	.L17
.L31:
	leaq	-72(%rbp), %rsi
	movl	$1, %edi
	xorl	%ebx, %ebx
	call	clock_gettime@PLT
	movq	-88(%rbp), %rdx
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rsi
	movq	-80(%rbp), %rcx
	call	timeDelta
	leaq	.LC5(%rip), %rsi
	movl	$1, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	cmpl	$-1, -100(%rbp)
	movslq	-100(%rbp), %r15
	je	.L7
.L19:
	cmpl	%ebx, %r14d
	jle	.L7
	leaq	0(%r13,%r15), %rax
	movq	%r12, %rsi
	movsbl	(%rax,%rbx), %edi
	incq	%rbx
	call	fputc@PLT
	jmp	.L19
.L7:
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	je	.L22
	call	__stack_chk_fail@PLT
.L22:
	leaq	-40(%rbp), %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE36:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits

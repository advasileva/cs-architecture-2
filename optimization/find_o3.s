	.file	"find.c"
	.text
	.p2align 4
	.globl	find
	.type	find, @function
find:
.LFB0:
	.cfi_startproc
	subl	%edi, %esi
	movl	%edi, %r9d
	movl	%esi, %r8d
	js	.L11
	movslq	%esi, %rax
	leaq	2(%rdx,%rax), %rsi
	leaq	1(%rdx,%rax), %rdi
	leal	-2(%r9), %eax
	addq	%rax, %rsi
	.p2align 4,,10
	.p2align 3
.L7:
	cmpl	$1, %r9d
	jle	.L1
	movzbl	-1(%rdi), %edx
	movq	%rdi, %rax
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L12:
	addq	$1, %rax
	cmpq	%rsi, %rax
	je	.L1
.L5:
	movl	%edx, %ecx
	movzbl	(%rax), %edx
	cmpb	%cl, %dl
	jl	.L12
	subl	$1, %r8d
	subq	$1, %rdi
	subq	$1, %rsi
	cmpl	$-1, %r8d
	jne	.L7
.L1:
	movl	%r8d, %eax
	ret
.L11:
	movl	$-1, %r8d
	jmp	.L1
	.cfi_endproc
.LFE0:
	.size	find, .-find
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits

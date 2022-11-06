	.file	"find.c"
	.text
	.globl	find
	.type	find, @function
find:
.LFB0:
	.cfi_startproc
	subl	%edi, %esi
	js	.L10
	leal	-2(%rdi), %ecx
	movslq	%esi, %rax
	leaq	1(%rdx,%rax), %rdx
	addq	%rcx, %rdx
	notq	%rcx
	jmp	.L7
.L10:
	movl	$-1, %esi
	jmp	.L1
.L4:
	subl	$1, %esi
	subq	$1, %rdx
	cmpl	$-1, %esi
	je	.L1
.L7:
	cmpl	$1, %edi
	jle	.L1
	leaq	(%rcx,%rdx), %rax
.L5:
	movzbl	1(%rax), %r8d
	cmpb	%r8b, (%rax)
	jle	.L4
	addq	$1, %rax
	cmpq	%rdx, %rax
	jne	.L5
.L1:
	movl	%esi, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	find, .-find
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits

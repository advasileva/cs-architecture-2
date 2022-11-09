	.file	"find.c"
	.text
	.p2align 4
	.globl	find
	.type	find, @function
find:
.LFB0:
	.cfi_startproc
	subl	%edi, %esi
	movl	%esi, %r8d
	js	.L11
	movslq	%esi, %rax
	leal	-2(%rdi), %ecx
	leaq	1(%rdx,%rax), %rdx
	addq	%rcx, %rdx
	notq	%rcx
	.p2align 4,,10
	.p2align 3
.L7:
	cmpl	$1, %edi
	jle	.L1
	leaq	(%rcx,%rdx), %rax
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L12:
	addq	$1, %rax
	cmpq	%rdx, %rax
	je	.L1
.L5:
	movzbl	1(%rax), %esi
	cmpb	%sil, (%rax)
	jg	.L12
	subl	$1, %r8d
	subq	$1, %rdx
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

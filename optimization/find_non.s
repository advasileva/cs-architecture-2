	.file	"find.c"
	.text
	.globl	find
	.type	find, @function
find:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movl	-24(%rbp), %eax
	subl	-20(%rbp), %eax
	movl	%eax, -8(%rbp)
	jmp	.L2
.L9:
	movl	$1, -12(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L3
.L6:
	movl	-8(%rbp), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %edx
	movl	-8(%rbp), %ecx
	movl	-4(%rbp), %eax
	addl	%ecx, %eax
	cltq
	leaq	1(%rax), %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	cmpb	%al, %dl
	jg	.L4
	movl	$0, -12(%rbp)
	jmp	.L5
.L4:
	addl	$1, -4(%rbp)
.L3:
	movl	-20(%rbp), %eax
	subl	$1, %eax
	cmpl	%eax, -4(%rbp)
	jl	.L6
.L5:
	cmpl	$1, -12(%rbp)
	jne	.L7
	movl	-8(%rbp), %eax
	jmp	.L8
.L7:
	subl	$1, -8(%rbp)
.L2:
	cmpl	$0, -8(%rbp)
	jns	.L9
	movl	$-1, %eax
.L8:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	find, .-find
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits

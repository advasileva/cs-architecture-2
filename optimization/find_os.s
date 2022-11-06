	.file	"find.c"
	.text
	.globl	find
	.type	find, @function
find:
.LFB0:
	.cfi_startproc
	movl	%esi, %eax
	movq	%rdx, %r8
	subl	%edi, %eax
	decl	%edi
	movslq	%eax, %rcx
.L2:
	testl	%eax, %eax
	js	.L9
	movq	%rcx, %rdx
.L6:
	movl	%edx, %esi
	subl	%ecx, %esi
	cmpl	%esi, %edi
	jle	.L10
	movb	(%r8,%rdx), %sil
	incq	%rdx
	cmpb	(%r8,%rdx), %sil
	jg	.L6
	decl	%eax
	decq	%rcx
	jmp	.L2
.L10:
	ret
.L9:
	orl	$-1, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	find, .-find
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits

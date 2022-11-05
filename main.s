	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	timeDelta
	.type	timeDelta, @function
timeDelta:
	push	rbp
	mov	rbp, rsp
	mov	rax, rsi
	mov	r8, rdi
	mov	rsi, r8
	mov	rdi, r9
	mov	rdi, rax
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -48[rbp], rdx
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	add	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	add	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	sub	rax, QWORD PTR -8[rbp]
	pop	rbp
	ret
	.size	timeDelta, .-timeDelta
	.section	.rodata
.LC0:
	.string	"r"
.LC1:
	.string	"w"
.LC2:
	.string	"input"
.LC3:
	.string	"output"
.LC4:
	.string	"Time delta: %ld ns\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	lea	r11, -98304[rsp]
.LPSRL0:
	sub	rsp, 4096
	or	DWORD PTR [rsp], 0
	cmp	rsp, r11
	jne	.LPSRL0
	sub	rsp, 1808
	mov	DWORD PTR -100100[rbp], edi
	mov	QWORD PTR -100112[rbp], rsi
	mov	rax, QWORD PTR -100112[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -28[rbp], eax
	mov	rax, QWORD PTR -100112[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -32[rbp], eax
	mov	rax, QWORD PTR -100112[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	test	eax, eax
	jne	.L4
	mov	rax, QWORD PTR -100112[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC0[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -100112[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	DWORD PTR -4[rbp], 0
.L5:
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	DWORD PTR -44[rbp], eax
	mov	eax, DWORD PTR -4[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -4[rbp], edx
	mov	edx, DWORD PTR -44[rbp]
	cdqe
	mov	BYTE PTR -100064[rbp+rax], dl
	cmp	DWORD PTR -44[rbp], -1
	jne	.L5
	sub	DWORD PTR -4[rbp], 1
	mov	eax, DWORD PTR -12[rbp]
	sub	eax, 1
	cdqe
	mov	BYTE PTR -100064[rbp+rax], 0
	jmp	.L6
.L4:
	lea	rsi, .LC1[rip]
	lea	rdi, .LC2[rip]
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	lea	rsi, .LC1[rip]
	lea	rdi, .LC3[rip]
	call	fopen@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -100112[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -4[rbp], eax
	mov	DWORD PTR -12[rbp], 0
	jmp	.L7
.L8:
	call	rand@PLT
	cdq
	shr	edx, 25
	add	eax, edx
	and	eax, 127
	sub	eax, edx
	mov	edx, eax
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	mov	BYTE PTR -100064[rbp+rax], dl
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	movzx	eax, BYTE PTR -100064[rbp+rax]
	movsx	eax, al
	mov	rdx, QWORD PTR -40[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	fputc@PLT
	add	DWORD PTR -12[rbp], 1
.L7:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -4[rbp]
	jl	.L8
.L6:
	lea	rax, -100080[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	DWORD PTR -12[rbp], 0
	jmp	.L9
.L10:
	lea	rdx, -100064[rbp]
	mov	ecx, DWORD PTR -4[rbp]
	mov	eax, DWORD PTR -32[rbp]
	mov	esi, ecx
	mov	edi, eax
	call	find@PLT
	mov	DWORD PTR -8[rbp], eax
	add	DWORD PTR -12[rbp], 1
.L9:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L10
	lea	rax, -100096[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -100080[rbp]
	mov	rdx, QWORD PTR -100072[rbp]
	mov	rdi, QWORD PTR -100096[rbp]
	mov	rsi, QWORD PTR -100088[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	timeDelta
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	mov	rsi, rax
	lea	rdi, .LC4[rip]
	mov	eax, 0
	call	printf@PLT
	cmp	DWORD PTR -8[rbp], -1
	je	.L11
	mov	DWORD PTR -12[rbp], 0
	jmp	.L12
.L13:
	mov	edx, DWORD PTR -8[rbp]
	mov	eax, DWORD PTR -12[rbp]
	add	eax, edx
	cdqe
	movzx	eax, BYTE PTR -100064[rbp+rax]
	movsx	eax, al
	mov	rdx, QWORD PTR -24[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	fputc@PLT
	add	DWORD PTR -12[rbp], 1
.L12:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -32[rbp]
	jl	.L13
.L11:
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits

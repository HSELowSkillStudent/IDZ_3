	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	get_normal_degree
	.type	get_normal_degree, @function
get_normal_degree:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC0[rip]
	mov	rax, QWORD PTR -8[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	fmod@PLT
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	ret
	.size	get_normal_degree, .-get_normal_degree
	.globl	random_input
	.type	random_input, @function
random_input:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, -1240768329
	shr	rdx, 32
	add	edx, eax
	sar	edx, 8
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 360
	sub	eax, ecx
	mov	edx, eax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, edx
	movsd	QWORD PTR -8[rbp], xmm0
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	call	get_normal_degree
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	ret
	.size	random_input, .-random_input
	.section	.rodata
.LC1:
	.string	"test %d\n"
	.align 8
.LC2:
	.string	"\tunoptimized function time:\t%lld\n"
	.align 8
.LC3:
	.string	"\toptimized function time:  \t%lld\n\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	DWORD PTR -52[rbp], edi
	mov	QWORD PTR -64[rbp], rsi
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	mov	DWORD PTR -36[rbp], 0
	jmp	.L6
.L11:
	mov	eax, DWORD PTR -36[rbp]
	mov	esi, eax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	call	random_input
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	mov	edi, 0
	call	time@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	DWORD PTR -32[rbp], 0
	jmp	.L7
.L8:
	mov	rax, QWORD PTR -24[rbp]
	mov	esi, 0
	mov	edi, 1
	movq	xmm0, rax
	call	func@PLT
	add	DWORD PTR -32[rbp], 1
.L7:
	cmp	DWORD PTR -32[rbp], 499999999
	jle	.L8
	mov	edi, 0
	call	time@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	movabs	rdx, 2361183241434822607
	mov	rax, rcx
	imul	rdx
	mov	rax, rdx
	sar	rax, 7
	mov	rdx, rcx
	sar	rdx, 63
	sub	rax, rdx
	imul	rdx, rax, 1000
	mov	rax, rcx
	sub	rax, rdx
	mov	rsi, rax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	edi, 0
	call	time@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	DWORD PTR -28[rbp], 0
	jmp	.L9
.L10:
	mov	rax, QWORD PTR -24[rbp]
	mov	esi, 0
	mov	edi, 1
	movq	xmm0, rax
	call	func@PLT
	add	DWORD PTR -28[rbp], 1
.L9:
	cmp	DWORD PTR -28[rbp], 499999999
	jle	.L10
	mov	edi, 0
	call	time@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	movabs	rdx, 2361183241434822607
	mov	rax, rcx
	imul	rdx
	mov	rax, rdx
	sar	rax, 7
	mov	rdx, rcx
	sar	rdx, 63
	sub	rax, rdx
	imul	rdx, rax, 1000
	mov	rax, rcx
	sub	rax, rdx
	mov	rsi, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -36[rbp], 1
.L6:
	cmp	DWORD PTR -36[rbp], 9
	jle	.L11
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	1413754136
	.long	1075388923
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits

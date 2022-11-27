	.file	"func.c"
	.intel_syntax noprefix
	.text
	.globl	func
	.type	func, @function
func:
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -40[rbp], xmm0                    # double x
	movsd	QWORD PTR -48[rbp], xmm1                    # double a
	movsd	QWORD PTR -56[rbp], xmm2                    # double sign
	movsd	xmm0, QWORD PTR -40[rbp]                    # x
	movsd	QWORD PTR -24[rbp], xmm0                    # double result = x
	movsd	xmm0, QWORD PTR -40[rbp]                    # x
	movsd	QWORD PTR -16[rbp], xmm0                    # double x_i = x
	pxor	xmm0, xmm0
	movsd	QWORD PTR -8[rbp], xmm0                     # double i = 0
	jmp	.L2
.L3:
	movsd	xmm0, QWORD PTR -40[rbp]                    # x
	movq	xmm1, QWORD PTR .LC1[rip]                   # -1
	xorpd	xmm0, xmm1                                  # -1 * x
	movapd	xmm1, xmm0                                  # xmm1 = -1 * x
	mulsd	xmm1, QWORD PTR -40[rbp]                    # xmm1 = -1 * x * x
	
	movsd	xmm0, QWORD PTR -8[rbp]                     # i
	movapd	xmm2, xmm0                                  # xmm2 = i
	addsd	xmm2, xmm0                                  # xmm2 = 2 * i
	movsd	xmm0, QWORD PTR .LC2[rip]                   # 2
	addsd	xmm2, xmm0                                  # xmm2 = 2 * i + 2
	
	movsd	xmm0, QWORD PTR -8[rbp]                     # i
	movapd	xmm3, xmm0                                  # xmm3 = i
	addsd	xmm3, xmm0                                  # xmm3 = 2 * i
	movsd	xmm0, QWORD PTR .LC3[rip]                   # xmm0 = 3
	addsd	xmm0, xmm3                                  # xmm0 = 2 * i + 3
	mulsd	xmm2, xmm0                                  # xmm2 = (2 * i + 2) * (2 * i + 3)
	divsd	xmm1, xmm2                                  # xmm1 = (-1) * x * x / ((2 * i + 2) * (2 * i + 3))
	movapd	xmm0, xmm1                                  # xmm0 = xmm1
	movsd	xmm1, QWORD PTR -16[rbp]                    # x_i
	mulsd	xmm0, xmm1                                  # x_i * (-1) * x * x / ((2 * i + 2) * (2 * i + 3))
	movsd	QWORD PTR -16[rbp], xmm0                    # x_i *= (-1) * x * x / ((2 * i + 2) * (2 * i + 3))
	movsd	xmm0, QWORD PTR -24[rbp]                    # result
	addsd	xmm0, QWORD PTR -16[rbp]                    # result + x_i
	movsd	QWORD PTR -24[rbp], xmm0                    # result = result + x_i
	movsd	xmm1, QWORD PTR -8[rbp]                     # i
	movsd	xmm0, QWORD PTR .LC4[rip]                   # 1
	addsd	xmm0, xmm1                                  # i + 1
	movsd	QWORD PTR -8[rbp], xmm0                     # i = i + 1
.L2:
	movsd	xmm0, QWORD PTR -16[rbp]                    # x_i
	comisd	xmm0, QWORD PTR .LC5[rip]                   # x_i ? ACCURACY
	ja	.L3                                             # if (!(x > ACCURACY)
	movsd	xmm0, QWORD PTR .LC6[rip]                   # -ACCURACY
	comisd	xmm0, QWORD PTR -16[rbp]                    # x_i ? -ACCURACY
	ja	.L3                                             # || !(x < -ACCURACY)
	movsd	xmm0, QWORD PTR -24[rbp]                    # result
	movq	rax, xmm0
	movq	xmm0, rax
	pop	rbp
	ret
	.size	func, .-func
	.section	.rodata
	.align 16
.LC1:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC2:
	.long	0
	.long	1073741824
	.align 8
.LC3:
	.long	0
	.long	1074266112
	.align 8
.LC4:
	.long	0
	.long	1072693248
	.align 8
.LC5:
	.long	-755914244
	.long	1061184077
	.align 8
.LC6:
	.long	-755914244
	.long	-1086299571
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits

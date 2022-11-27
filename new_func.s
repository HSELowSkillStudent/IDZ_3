	.file	"func.c"
	.intel_syntax noprefix
	.text
	.globl	func
	.type	func, @function
func:
	push	rbp
	mov	rbp, rsp
	
	movapd	xmm4, xmm0                                  # double x
	# movapd	xmm5, xmm1                              # double a (не используются => не нужен)
	# movapd	xmm6, xmm2                              # double sign (не используются => не нужен)
	movapd	xmm5, xmm0                                  # double result = x
	movapd	xmm6, xmm0                                  # double x_i = x
	pxor	xmm0, xmm0
	movapd	xmm7, xmm0                                  # double i = 0
	jmp	.L2
.L3:
	movapd	xmm0, xmm4                                  # x
	movq	xmm1, QWORD PTR .LC1[rip]                   # -1
	xorpd	xmm0, xmm1                                  # -1 * x
	movapd	xmm1, xmm0                                  # xmm1 = -1 * x
	mulsd	xmm1, xmm4                                  # xmm1 = -1 * x * x
	
	# movapd	xmm0, xmm7                                  # i
	movapd	xmm2, xmm7                                  # xmm2 = i
	addsd	xmm2, xmm7                                  # xmm2 = 2 * i
	movsd	xmm0, QWORD PTR .LC2[rip]                   # 2
	addsd	xmm2, xmm0                                  # xmm2 = 2 * i + 2
	
	# movapd	xmm0, xmm7                                  # i
	movapd	xmm3, xmm7                                  # xmm3 = i
	addsd	xmm3, xmm7                                  # xmm3 = 2 * i
	movsd	xmm0, QWORD PTR .LC3[rip]                   # xmm0 = 3
	addsd	xmm0, xmm3                                  # xmm0 = 2 * i + 3
	mulsd	xmm2, xmm0                                  # xmm2 = (2 * i + 2) * (2 * i + 3)
	divsd	xmm1, xmm2                                  # xmm1 = (-1) * x * x / ((2 * i + 2) * (2 * i + 3))
	movapd	xmm0, xmm1                                  # xmm0 = xmm1
	movapd	xmm1, xmm6                                  # x_i
	mulsd	xmm0, xmm1                                  # x_i * (-1) * x * x / ((2 * i + 2) * (2 * i + 3))
	movapd	xmm6, xmm0                                  # x_i *= (-1) * x * x / ((2 * i + 2) * (2 * i + 3))
	
	# TODO
	# movapd	xmm0, xmm5                              # result
	# addsd	xmm0, xmm6                                  # result + x_i
	# movapd	xmm5, xmm0                                  # result = result + x_i
	addsd   xmm5, xmm6
	
	
	# TODO
	# movapd	xmm1, xmm7                              # i
	movsd	xmm0, QWORD PTR .LC4[rip]                   # 1
	# addsd	xmm0, xmm1                                  # i + 1
	# movapd	xmm7, xmm0                              # i = i + 1
	addsd   xmm7, xmm0
	
.L2:
	# movapd	xmm0, xmm6                              # x_i
	# comisd	xmm0, QWORD PTR .LC5[rip]               # x_i ? ACCURACY
	comisd	xmm6, QWORD PTR .LC5[rip]                   # x_i ? ACCURACY
	
	ja	.L3                                             # if (!(x > ACCURACY)
	movsd	xmm0, QWORD PTR .LC6[rip]                   # -ACCURACY
	comisd	xmm0, xmm6                                  # x_i ? -ACCURACY
	# comisd	xmm7, xmm6                              # x_i ? -ACCURACY
	ja	.L3                                             # || !(x < -ACCURACY)
	movsd	xmm0, xmm5                                  # result
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

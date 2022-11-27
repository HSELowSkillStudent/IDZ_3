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
	movq	xmm0, rax
	leave
	ret
	.size	get_normal_degree, .-get_normal_degree
	.section	.rodata
	.align 8
.LC1:
	.string	"\320\241\320\263\320\265\320\275\320\265\321\200\320\270\321\200\320\276\320\262\320\260\320\275\320\275\320\276\320\265 \321\207\320\270\321\201\320\273\320\276: %f \321\200\320\260\320\264\320\270\320\260\320\275\nSin(%f) = %f\n"
	.text
	.globl	random_input
	.type	random_input, @function
random_input:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	call	rand@PLT                                    # rand()
	movsx	rdx, eax
	imul	rdx, rdx, -1240768329
	shr	rdx, 32
	add	edx, eax
	sar	edx, 8
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 360                               # rand() % 360
	sub	eax, ecx
	mov	edx, eax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, edx
	movsd	QWORD PTR -8[rbp], xmm0                     # double a = rand() % 360;
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	call	get_normal_degree                           # get_normal_degree(a);
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax                          # a = get_normal_degree(a);
	mov	rax, QWORD PTR -8[rbp]
	mov	esi, 0                                          # 0
	mov	edi, 1                                          # 1
	movq	xmm0, rax                                   # a
	call	func@PLT                                    # func(a, 1, 0);
	movq	rdx, xmm0
	movsd	xmm0, QWORD PTR -8[rbp]
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm2, rdx                                   # func(a, 1, 0)
	movapd	xmm1, xmm0                                  # a
	movq	xmm0, rax                                   # a
	lea	rax, .LC1[rip]
	mov	rdi, rax                                        # "Сгенерированное..."
	mov	eax, 3
	call	printf@PLT                                  # printf("Сгенерированное...);
	nop
	leave
	ret
	.size	random_input, .-random_input
	.section	.rodata
.LC2:
	.string	"r"
.LC3:
	.string	"%lf"
.LC4:
	.string	"w"
.LC5:
	.string	"Sin(%f) = Sin(%f) = %f\n"
	.text
	.globl	file_input
	.type	file_input, @function
file_input:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR -56[rbp], rdi                         # char input_name[]
	mov	QWORD PTR -64[rbp], rsi                         # char output_name[]
	mov	rax, QWORD PTR fs:40                            # канарейка
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	mov	rax, QWORD PTR -56[rbp]                         # input_name[]
	lea	rdx, .LC2[rip]                                  # "r"
	mov	rsi, rdx                                        # "r"
	mov	rdi, rax                                        # input_name[]
	call	fopen@PLT                                   # fopen(input_name, "r");
	mov	QWORD PTR -40[rbp], rax                         # input_file = fopen(input_name, "r");
	lea	rdx, -48[rbp]                                   # &x
	mov	rax, QWORD PTR -40[rbp]                         # input_file
	lea	rcx, .LC3[rip]                                  # "%lf"
	mov	rsi, rcx                                        # "%lf"
	mov	rdi, rax                                        # input_file
	mov	eax, 0 
	call	__isoc99_fscanf@PLT                         # fscanf(input_file, "%lf", &x);
	mov	rax, QWORD PTR -40[rbp]                         # input_file    
	mov	rdi, rax                                        # input_file
	call	fclose@PLT                                  # fclose(input_file);
	mov	rax, QWORD PTR -48[rbp]                         # x
	movq	xmm0, rax                                   # x
	call	get_normal_degree                           # get_normal_degree(x);
	movq	rax, xmm0                                   # a = get_normal_degree(x);
	mov	QWORD PTR -32[rbp], rax                         # a = get_normal_degree(x);
	mov	rax, QWORD PTR -32[rbp]                         # a
	mov	esi, 0                                          # 0
	mov	edi, 1                                          # 1
	movq	xmm0, rax                                   # a
	call	func@PLT                                    # func(a, 1, 0);
	movq	rax, xmm0                                   # result = func(a, 1, 0);
	mov	QWORD PTR -24[rbp], rax                         # result = func(a, 1, 0);
	mov	rax, QWORD PTR -64[rbp]                         # output_name
	lea	rdx, .LC4[rip]                                  # "w"
	mov	rsi, rdx                                        # "w"
	mov	rdi, rax                                        # output_name
	call	fopen@PLT                                   # fopen(output_name, "w");
	mov	QWORD PTR -16[rbp], rax                         # output_file = fopen(output_name, "w");
	mov	rdx, QWORD PTR -48[rbp]                         # x
	movsd	xmm1, QWORD PTR -24[rbp]                    # result
	movsd	xmm0, QWORD PTR -32[rbp]                    # a
	mov	rax, QWORD PTR -16[rbp]                         # output_file
	movapd	xmm2, xmm1                                  # result
	movapd	xmm1, xmm0                                  # a
	movq	xmm0, rdx                                   # x
	lea	rdx, .LC5[rip]                                  # "Sin(%f) = Sin
	mov	rsi, rdx                                        # "Sin(%f) = Sin
	mov	rdi, rax                                        # output_file
	mov	eax, 3
	call	fprintf@PLT                                 # fprintf(output_file, "Sin(%f)...)
	nop
	mov	rax, QWORD PTR -8[rbp]                          # канарейка
	sub	rax, QWORD PTR fs:40
	je	.L5
	call	__stack_chk_fail@PLT
.L5:
	leave
	ret
	.size	file_input, .-file_input
	.globl	arg_input
	.type	arg_input, @function
arg_input:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR -40[rbp], rdi
	mov	rax, QWORD PTR -40[rbp]                         # *argv[0]
	add	rax, 8                                          # *argv[1] - указатель на значение
	mov	rax, QWORD PTR [rax]                            # argv[1] - значение
	mov	rdi, rax                                        # argv[1]
	call	atof@PLT                                    # atof(argv[1]);
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax                         # x = atof(argv[1]);
	mov	rax, QWORD PTR -24[rbp]                         # x
	movq	xmm0, rax                                   # x
	call	get_normal_degree                           # get_normal_degree(x);
	movq	rax, xmm0
	mov	QWORD PTR -16[rbp], rax                         # a = get_normal_degree(x);
	mov	rax, QWORD PTR -16[rbp]                         # a
	mov	esi, 0                                          # 0
	mov	edi, 1                                          # 1
	movq	xmm0, rax                                   # a
	call	func@PLT                                    # func(a, 1, 0);
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax                          # result = func(a, 1, 0);
	movsd	xmm1, QWORD PTR -8[rbp]                     # result
	movsd	xmm0, QWORD PTR -16[rbp]                    # a
	mov	rax, QWORD PTR -24[rbp]                         # x
	movapd	xmm2, xmm1                                  # result
	movapd	xmm1, xmm0                                  # a
	movq	xmm0, rax                                   # x
	lea	rax, .LC5[rip]
	mov	rdi, rax                                        # "Sin(%f) ...
	mov	eax, 3
	call	printf@PLT                                  # printf("Sin(%f) = Sin...);
	nop
	leave
	ret
	.size	arg_input, .-arg_input
	.section	.rodata
	.align 8
.LC6:
	.string	"\320\222\320\262\320\265\320\264\320\270\321\202\320\265 \320\263\321\200\320\260\320\264\321\203\321\201 \321\203\320\263\320\273\320\260(\320\262 \321\200\320\260\320\264\320\270\320\260\320\275\320\260\321\205):"
	.text
	.globl	def_input
	.type	def_input, @function
def_input:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rax, QWORD PTR fs:40                            # канарейка
	mov	QWORD PTR -8[rbp], rax                          # канарейка
	xor	eax, eax
	lea	rax, .LC6[rip]                                  # "Введите градус...
	mov	rdi, rax
	call	puts@PLT                                    # printf("Введите градус...
	lea	rax, -32[rbp]
	mov	rsi, rax
	lea	rax, .LC3[rip]                                  # "%lf"
	mov	rdi, rax                                        # &x
	mov	eax, 0
	call	__isoc99_scanf@PLT                          # scanf("%lf", &x);
	mov	rax, QWORD PTR -32[rbp]                         # x
	movq	xmm0, rax                                   # x
	call	get_normal_degree                           # get_normal_degree(x);
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax                         # a = get_normal_degree(x);
	mov	rax, QWORD PTR -24[rbp]                         # a
	mov	esi, 0                                          # 0
	mov	edi, 1                                          # 1
	movq	xmm0, rax                                   # a
	call	func@PLT                                    # func(a, 1, 0);
	movq	rax, xmm0                                   # result = func(a, 1, 0);
	mov	QWORD PTR -16[rbp], rax                         # result = func(a, 1, 0);
	mov	rax, QWORD PTR -32[rbp]                         # x
	movsd	xmm1, QWORD PTR -16[rbp]                    # result
	movsd	xmm0, QWORD PTR -24[rbp]                    # a
	movapd	xmm2, xmm1                                  # result
	movapd	xmm1, xmm0                                  # a
	movq	xmm0, rax                                   # x
	lea	rax, .LC5[rip]                                  # "Sin(%f) = Sin(%f) = %f\n"
	mov	rdi, rax                                        # "Sin(%f) = Sin(%f) = %f\n"
	mov	eax, 3
	call	printf@PLT                                  # printf("Sin(%f)...
	nop
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR fs:40
	je	.L8
	call	__stack_chk_fail@PLT
.L8:
	leave
	ret
	.size	def_input, .-def_input
	.section	.rodata
.LC7:
	.string	"-h"
.LC8:
	.string	"--help"
	.align 8
.LC9:
	.string	"keys:\n-h (--help)  - displays a list of keys\n-r [int] (--random [int])  - sets a random data set. \n-f [string] [string] (--file [string] [string])  - the program works with files entered by the following two arguments"
.LC10:
	.string	"-r"
.LC11:
	.string	"--random"
.LC12:
	.string	"-f"
.LC13:
	.string	"--file"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	DWORD PTR -4[rbp], edi                          # int argc
	mov	QWORD PTR -16[rbp], rsi                         # char *argv[]
	mov	edi, 0                                          # NULL
	call	time@PLT                                    # time(NULL)
	mov	edi, eax
	call	srand@PLT                                   # srand(time(NULL));
	cmp	DWORD PTR -4[rbp], 1                            # argc ? 1
	jne	.L10
	mov	eax, 0                                          # if (argc == 1)
	call	def_input                                   # def_input();
	jmp	.L11
.L10:
	mov	rax, QWORD PTR -16[rbp]                         # *argv[0]
	add	rax, 8                                          # *argv[1]
	mov	rax, QWORD PTR [rax]                            # argv[1]
	lea	rdx, .LC7[rip]                                  # "-h"
	mov	rsi, rdx                                        # "-h"
	mov	rdi, rax                                        # argv[1]
	call	strcmp@PLT                                  # strcmp(argv[1], "-h")
	test	eax, eax                                    # !strcmp(argv[1], "-h")
	je	.L12
	mov	rax, QWORD PTR -16[rbp]                         # *argv[0]
	add	rax, 8                                          # *argv[1]
	mov	rax, QWORD PTR [rax]                            # argv[1]
	lea	rdx, .LC8[rip]                                  # "--help"
	mov	rsi, rdx                                        # "--help"
	mov	rdi, rax                                        # argv[1]
	call	strcmp@PLT                                  # strcmp(argv[1], "--help")
	test	eax, eax
	jne	.L13                                            # if (!strcmp(argv[1], "-h") || !...
.L12:
	lea	rax, .LC9[rip]
	mov	rdi, rax
	call	puts@PLT                                    # printf("keys:\n-h (--help)...
	jmp	.L11
.L13:
	mov	rax, QWORD PTR -16[rbp]                         # *argv[0]
	add	rax, 8                                          # *argv[1]
	mov	rax, QWORD PTR [rax]                            # argv[1]
	lea	rdx, .LC10[rip]                                 # "-r"
	mov	rsi, rdx                                        # "-r"
	mov	rdi, rax                                        # argv[1]
	call	strcmp@PLT                                  # strcmp(argv[1], "-r")
	test	eax, eax
	je	.L14
	mov	rax, QWORD PTR -16[rbp]                         # *argv[0]
	add	rax, 8                                          # *argv[1]
	mov	rax, QWORD PTR [rax]                            # argv[1]
	lea	rdx, .LC11[rip]                                 # "--random"
	mov	rsi, rdx                                        # "--random"
	mov	rdi, rax                                        # argv[1]
	call	strcmp@PLT                                  # strcmp(argv[1], "--random")
	test	eax, eax
	jne	.L15
.L14:                                                   # if (!strcmp(argv[1], "-r") || !...
	mov	eax, 0
	call	random_input                                # random_input();
	jmp	.L11
.L15:
	mov	rax, QWORD PTR -16[rbp]                         # *argv[0]
	add	rax, 8                                          # *argv[1]
	mov	rax, QWORD PTR [rax]                            # argv[1]
	lea	rdx, .LC12[rip]                                 # "-f"
	mov	rsi, rdx                                        # "-f"
	mov	rdi, rax                                        # argv[1]
	call	strcmp@PLT                                  # strcmp(argv[1], "-f")
	test	eax, eax
	je	.L16
	mov	rax, QWORD PTR -16[rbp]                         # *argv[0]
	add	rax, 8                                          # *argv[1]
	mov	rax, QWORD PTR [rax]                            # argv[1]
	lea	rdx, .LC13[rip]                                 # "--file"
	mov	rsi, rdx                                        # "--file"
	mov	rdi, rax                                        # argv[1]
	call	strcmp@PLT                                  # strcmp(argv[1], "--file")
	test	eax, eax
	jne	.L17
.L16:                                                   # if (!strcmp(argv[1], "-f") || !...
	mov	rax, QWORD PTR -16[rbp]                         # *argv[0]
	add	rax, 24                                         # *argv[3]
	mov	rdx, QWORD PTR [rax]                            # argv[3]
	mov	rax, QWORD PTR -16[rbp]                         # *argv[0]
	add	rax, 16                                         # *argv[2]
	mov	rax, QWORD PTR [rax]                            # argv[2]
	mov	rsi, rdx                                        # argv[3]
	mov	rdi, rax                                        # argv[2]
	call	file_input                                  # file_input(argv[2], argv[3]);
	jmp	.L11
.L17:                                                   # else
	mov	rax, QWORD PTR -16[rbp]                         # argv
	mov	rdi, rax                                        # argv
	call	arg_input                                   # arg_input(argv);
.L11:
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

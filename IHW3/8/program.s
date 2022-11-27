	.file	"program.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"Incorrect number of parameters."
.LC1:
	.string	"-s"
.LC2:
	.string	"-g"
.LC4:
	.string	"Elapsed time: %f\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	# Передача параметра int argc в регистр r12d
	mov	r12d, edi
	# Передача параметра char **argv в регистр r13
	mov	r13, rsi
	# argc == 1
	cmp	r12d, 1
	# Если argc равен 1, то переходим к метке .L2
	je	.L2
	# argc == 3
	cmp	r12d, 3
	# Если argc равен 3 то переходим к метке .L2
	je	.L2
	lea	rax, .LC0[rip]
	mov	rdi, rax
	call	puts@PLT
	# return 1;
	mov	eax, 1
	jmp	.L3
.L2:
	# argc == 1
	cmp	r12d, 1
	# Если argc не равен 1, то переходим к метке .L4
	jne	.L4
	mov	eax, 0
	call	readValue@PLT
	# number = readValue();
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
.L4:
	# argc == 3
	cmp	r12d, 3
	# Если argc не равен 3, то переходим к метке .L5
	jne	.L5
	# argv[1] используется в strcmp()
	mov	rax, QWORD PTR [r13+8]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	je	.L6
	# argv[1] используется в strcmp()
	mov	rax, QWORD PTR [r13+8]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L5
.L6:
	mov	eax, 0
	call	generateValue@PLT
	# number = generateValue();
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	jmp	.L7
.L5:
	# argc == 3
	cmp	r12d, 3
	# Если argc не равен 3, то переходим к метке .L7
	jne	.L7
	mov	rdi, r13
	call	readValueFromFile@PLT
	# number = readValueFromFile();
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
.L7:
	call	clock@PLT
	# Кладем переменную clock_t start в -24 по стеку
	mov	QWORD PTR -24[rbp], rax
	cmp	r12d, 3
	jne	.L8
	# argv[1] используется в strcmp()
	mov	rax, QWORD PTR [r13+8]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L8
	# i = 0
	mov	r14d, 0
	jmp	.L9
.L10:
	# Подготавливаем передачу number в computeResult(double number)
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	call	computeResult@PLT
	# result = computeResult(number);
	mov	QWORD PTR -32[rbp], rax
	# ++i;
	add	r14d, 1
.L9:
	# i < 3000000
	cmp	r14d, 2999999
	# Если i меньше или равно 2999999, то переходим к метке .L10
	jle	.L10
.L8:
        # Подготавливаем передачу number в computeResult(double number)
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	call	computeResult@PLT
        # result = computeResult(number);
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	call	clock@PLT
        # Кладем переменную clock_t stop в -40 по стеку
	mov	QWORD PTR -40[rbp], rax
	# argc == 1
	cmp	r12d, 1
	# Если argc не равно 1, то переходим к метке .L11
	jne	.L11
	# Передаем result для функции printResult(result)
	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rax
	call	printResult@PLT
.L11:
	# argc == 3
	cmp	r12d, 3
	# Если argc не равно 3, то переходим к метке .L12
	jne	.L12
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, r13
	# Передаем result для функции outputResultToFile(result, argv)
	movq	xmm0, rax
	call	outputResultToFile@PLT
.L12:
	# Считаем elapsed_time
	mov	rax, QWORD PTR -40[rbp]
	sub	rax, QWORD PTR -24[rbp]
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	movsd	xmm1, QWORD PTR .LC3[rip]
	divsd	xmm0, xmm1
	# Подготавливаем elapsed_time для функции printf()
	movsd	QWORD PTR -48[rbp], xmm0
	mov	rax, QWORD PTR -48[rbp]
	movq	xmm0, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	# return 0;
	mov	eax, 0
.L3:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC3:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

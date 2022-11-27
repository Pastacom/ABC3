	.file	"functions.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"Enter the x value to compute function: "
.LC1:
	.string	"%lf"
	.align 8
.LC4:
	.string	"Function diverges with x = %lf, available values are (-1, 1).\n"
	.text
	.globl	readValue
	.type	readValue, @function
# Функция readValue(), которая возвращает считанное из консоли число типа double
readValue:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	# Подготавливаем данные к scanf()
	lea	rax, -8[rbp]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	# Перекладываем переменную number со стека в регистр xmm2
	movsd	xmm2, QWORD PTR -8[rbp]
	# Приведение к double и сравнения с 1
	movsd	xmm1, xmm2
	movsd	xmm0, QWORD PTR .LC2[rip]
	comisd	xmm0, xmm1
	# Если одно из условий выполнилось, то переходим по метке .L2
	ja	.L2
	movsd	xmm0, xmm2
	movsd	xmm1, QWORD PTR .LC3[rip]
	comisd	xmm0, xmm1
	# Если не выполнилось ни одно переходим к метке .L6
	jbe	.L6
.L2:
	# Подготавливаем параметры для printf()
	movsd	xmm0, xmm2
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	# exit(0);
	mov	edi, 0
	call	exit@PLT
.L6:
	# return number;
	movsd	xmm0, xmm2
	leave
	ret
	.size	readValue, .-readValue
	.section	.rodata
.LC5:
	.string	"r"
.LC6:
	.string	"End up reading file."
	.text
	.globl	readValueFromFile
	.type	readValueFromFile, @function
# Функция readValueFromFile(char **argv) для считывания числа из файла
readValueFromFile:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	# char **argv
	mov	r15, rdi
	# argv[1] передается в fopen()
	mov	rax, QWORD PTR [r15+8]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	# Подготовка потока для чтения file и number для записи
	mov	r14, rax
	lea	rdx, -16[rbp]
	mov	rax, r14
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	# Считываем значение number
	call	__isoc99_fscanf@PLT
	mov	rax, r14
	mov	rdi, rax
	# Закрываем поток
	call	fclose@PLT
	lea	rax, .LC6[rip]
	mov	rdi, rax
	call	puts@PLT
	# Перекладываем  значение number со стека в регистр xmm2
	movsd	xmm2, QWORD PTR -16[rbp]
        # Приведение к double и сравнения с 1
	movsd	xmm1, xmm2
	movsd	xmm0, QWORD PTR .LC2[rip]
	comisd	xmm0, xmm1
        # Если одно из условий выполнилось, то переходим по метке .L8
	ja	.L8
	movsd	xmm0, xmm2
	movsd	xmm1, QWORD PTR .LC3[rip]
	comisd	xmm0, xmm1
        # Если не выполнилось ни одно переходим к метке .L12
	jbe	.L12
.L8:
        # Подготавливаем параметры для printf()
	movsd	xmm0, xmm2
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	# exit(0);
	mov	edi, 0
	call	exit@PLT
.L12:
	# return number;
	movsd	xmm0, xmm2
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	ret
	.size	readValueFromFile, .-readValueFromFile
	.globl	computeResult
	.type	computeResult, @function
# Функция для подсчета результата для заданного х
computeResult:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	# Принимаем параметр number и кладем его в -40 по стеку
	movsd	QWORD PTR -40[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC3[rip]
	# Записываем значение в result и кладем его в -8 по стеку
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm1, QWORD PTR -40[rbp]
	movsd	xmm0, QWORD PTR .LC7[rip]
	mulsd	xmm0, xmm1
	# Записываем значение в remainder и кладем его в xmm4
	movsd	xmm4, xmm0
	# Записываем значение в k и калдем его в -20 по стеку
	mov	DWORD PTR -20[rbp], 2
	jmp	.L14
.L17:
	# result += remainder
	movsd	xmm0, QWORD PTR -8[rbp]
	addsd	xmm0, xmm4
	movsd	QWORD PTR -8[rbp], xmm0
	pxor	xmm0, xmm0
	# pow(number, k)
	cvtsi2sd	xmm0, DWORD PTR -20[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	movsd	QWORD PTR -48[rbp], xmm0
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, 1
	pxor	xmm0, xmm0
	# pow(-1, k-1)
	cvtsi2sd	xmm0, eax
	mov	rax, QWORD PTR .LC2[rip]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	mulsd	xmm0, QWORD PTR -48[rbp]
	movsd	xmm4, xmm0
	# coef = 1;
	mov	r14d, 1
	# i = 0;
	mov	r15d, 0
	jmp	.L15
.L16:
	#remainder *= coef
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, r14d
	movsd	xmm1, xmm4
	mulsd	xmm0, xmm1
	movsd	xmm4, xmm0
	# ++coef
	add	r14d, 1
	# remainder /= coef
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, r14d
	movsd	xmm0, xmm4
	divsd	xmm0, xmm1
	movsd	xmm4, xmm0
	# ++coef
	add	r14d, 1
	# ++i
	add	r15d, 1
.L15:
	# k-1
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, 1
	# i < k-1
	cmp	r15d, eax
	jl	.L16
	# ++coef
	add	r14d, 1
	# remainder /= coef
	mov	eax, r14d
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, eax
	movsd	xmm0, xmm4
	divsd	xmm0, xmm1
	movsd	xmm4, xmm0
	# ++k
	add	DWORD PTR -20[rbp], 1
.L14:
	# fabs(remainder) >= precision
	movsd	xmm0, xmm4
	movq	xmm1, QWORD PTR .LC8[rip]
	andpd	xmm0, xmm1
	comisd	xmm0, QWORD PTR .LC9[rip]
	jnb	.L17
	# return result;
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	ret
	.size	computeResult, .-computeResult
	.section	.rodata
.LC10:
	.string	"Result: %lf\n"
	.text
	.globl	printResult
	.type	printResult, @function
# Функция printResult(double result) для вывода результата в консоль
printResult:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	# Кладем переданный параметр result в -8 по стеку
	movsd	QWORD PTR -8[rbp], xmm0
	# Подготавливаем result для функции printf()
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	lea	rax, .LC10[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	nop
	leave
	ret
	.size	printResult, .-printResult
	.section	.rodata
.LC11:
	.string	"w+"
.LC12:
	.string	"Result is in output file."
	.text
	.globl	outputResultToFile
	.type	outputResultToFile, @function
# Функция outputResultToFile(double result, char **argv) для вывода ответа в файл
outputResultToFile:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
        # Кладем переданный параметр result в -24 по стеку
	movsd	QWORD PTR -24[rbp], xmm0
        # Кладем переданный параметр argv в регистр r15
	mov	r15, rdi
	# argv[2]
	mov	rax, QWORD PTR [r15+16]
	lea	rdx, .LC11[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	# Кладем выходной поток file на -8 по стеку
	mov	QWORD PTR -8[rbp], rax
	# Подготавливаем данные для функции printf()
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rdx
	lea	rdx, .LC10[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	# Закрываем выходной поток file
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	lea	rax, .LC12[rip]
	mov	rdi, rax
	call	puts@PLT
	nop
	leave
	ret
	.size	outputResultToFile, .-outputResultToFile
	.section	.rodata
.LC16:
	.string	"Generated number: %lf\n"
	.text
	.globl	generateValue
	.type	generateValue, @function
generateValue:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	# srand(time(0));
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	# Генерируем значение в пределах (-1, 1)
	call	rand@PLT
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	movsd	xmm2, QWORD PTR .LC13[rip]
	movapd	xmm1, xmm0
	divsd	xmm1, xmm2
	movsd	xmm0, QWORD PTR .LC14[rip]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC15[rip]
	subsd	xmm0, xmm1
	# Кладем value в -8 по стеку
	movsd	QWORD PTR -8[rbp], xmm0
	# Подготавливаем данные для функции printf()
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	lea	rax, .LC16[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	# return value;
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	ret
	.size	generateValue, .-generateValue
	.section	.rodata
	.align 8
.LC2:
	.long	0
	.long	-1074790400
	.align 8
.LC3:
	.long	0
	.long	1072693248
	.align 8
.LC7:
	.long	0
	.long	1071644672
	.align 16
.LC8:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC9:
	.long	-755914244
	.long	1061184077
	.align 8
.LC13:
	.long	-4194304
	.long	1105199103
	.align 8
.LC14:
	.long	-208632331
	.long	1073741822
	.align 8
.LC15:
	.long	-417264663
	.long	1072693245
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

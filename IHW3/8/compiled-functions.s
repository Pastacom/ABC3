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
readValue:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, -8[rbp]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	movsd	xmm1, QWORD PTR -8[rbp]
	movsd	xmm0, QWORD PTR .LC2[rip]
	comisd	xmm0, xmm1
	ja	.L2
	movsd	xmm0, QWORD PTR -8[rbp]
	movsd	xmm1, QWORD PTR .LC3[rip]
	comisd	xmm0, xmm1
	jbe	.L6
.L2:
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	edi, 0
	call	exit@PLT
.L6:
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
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
readValueFromFile:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	lea	rdx, -16[rbp]
	mov	rax, QWORD PTR -8[rbp]
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	lea	rax, .LC6[rip]
	mov	rdi, rax
	call	puts@PLT
	movsd	xmm1, QWORD PTR -16[rbp]
	movsd	xmm0, QWORD PTR .LC2[rip]
	comisd	xmm0, xmm1
	ja	.L8
	movsd	xmm0, QWORD PTR -16[rbp]
	movsd	xmm1, QWORD PTR .LC3[rip]
	comisd	xmm0, xmm1
	jbe	.L12
.L8:
	mov	rax, QWORD PTR -16[rbp]
	movq	xmm0, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	edi, 0
	call	exit@PLT
.L12:
	movsd	xmm0, QWORD PTR -16[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	ret
	.size	readValueFromFile, .-readValueFromFile
	.globl	computeResult
	.type	computeResult, @function
computeResult:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	movsd	QWORD PTR -40[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC3[rip]
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm1, QWORD PTR -40[rbp]
	movsd	xmm0, QWORD PTR .LC7[rip]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	mov	DWORD PTR -20[rbp], 2
	jmp	.L14
.L17:
	movsd	xmm0, QWORD PTR -8[rbp]
	addsd	xmm0, QWORD PTR -16[rbp]
	movsd	QWORD PTR -8[rbp], xmm0
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -20[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	movsd	QWORD PTR -48[rbp], xmm0
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, 1
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	mov	rax, QWORD PTR .LC2[rip]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	mulsd	xmm0, QWORD PTR -48[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	mov	DWORD PTR -24[rbp], 1
	mov	DWORD PTR -28[rbp], 0
	jmp	.L15
.L16:
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -24[rbp]
	movsd	xmm1, QWORD PTR -16[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	add	DWORD PTR -24[rbp], 1
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, DWORD PTR -24[rbp]
	movsd	xmm0, QWORD PTR -16[rbp]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	add	DWORD PTR -24[rbp], 1
	add	DWORD PTR -28[rbp], 1
.L15:
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, 1
	cmp	DWORD PTR -28[rbp], eax
	jl	.L16
	add	DWORD PTR -24[rbp], 1
	mov	eax, DWORD PTR -24[rbp]
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, eax
	movsd	xmm0, QWORD PTR -16[rbp]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	add	DWORD PTR -20[rbp], 1
.L14:
	movsd	xmm0, QWORD PTR -16[rbp]
	movq	xmm1, QWORD PTR .LC8[rip]
	andpd	xmm0, xmm1
	comisd	xmm0, QWORD PTR .LC9[rip]
	jnb	.L17
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
printResult:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	movsd	QWORD PTR -8[rbp], xmm0
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
outputResultToFile:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	movsd	QWORD PTR -24[rbp], xmm0
	mov	QWORD PTR -32[rbp], rdi
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC11[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rdx
	lea	rdx, .LC10[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
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
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
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
	movsd	QWORD PTR -8[rbp], xmm0
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	lea	rax, .LC16[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
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

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
	mov	DWORD PTR -52[rbp], edi
	mov	QWORD PTR -64[rbp], rsi
	cmp	DWORD PTR -52[rbp], 1
	je	.L2
	cmp	DWORD PTR -52[rbp], 3
	je	.L2
	lea	rax, .LC0[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 1
	jmp	.L3
.L2:
	cmp	DWORD PTR -52[rbp], 1
	jne	.L4
	mov	eax, 0
	call	readValue@PLT
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
.L4:
	cmp	DWORD PTR -52[rbp], 3
	jne	.L5
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	je	.L6
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L5
.L6:
	mov	eax, 0
	call	generateValue@PLT
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	jmp	.L7
.L5:
	cmp	DWORD PTR -52[rbp], 3
	jne	.L7
	mov	rax, QWORD PTR -64[rbp]
	mov	rdi, rax
	call	readValueFromFile@PLT
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
.L7:
	call	clock@PLT
	mov	QWORD PTR -24[rbp], rax
	cmp	DWORD PTR -52[rbp], 3
	jne	.L8
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L8
	mov	DWORD PTR -12[rbp], 0
	jmp	.L9
.L10:
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	call	computeResult@PLT
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	add	DWORD PTR -12[rbp], 1
.L9:
	cmp	DWORD PTR -12[rbp], 2999999
	jle	.L10
.L8:
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	call	computeResult@PLT
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	call	clock@PLT
	mov	QWORD PTR -40[rbp], rax
	cmp	DWORD PTR -52[rbp], 1
	jne	.L11
	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rax
	call	printResult@PLT
.L11:
	cmp	DWORD PTR -52[rbp], 3
	jne	.L12
	mov	rdx, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rdx
	movq	xmm0, rax
	call	outputResultToFile@PLT
.L12:
	mov	rax, QWORD PTR -40[rbp]
	sub	rax, QWORD PTR -24[rbp]
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	movsd	xmm1, QWORD PTR .LC3[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -48[rbp], xmm0
	mov	rax, QWORD PTR -48[rbp]
	movq	xmm0, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
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

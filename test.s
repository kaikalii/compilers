f:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$80, %rsp

	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8, -40(%rbp)
	movq	%r9, -48(%rbp)
	movq	-8(%rbp), %rdi
	call	putchar
	movq	-16(%rbp), %rdi
	call	putchar
	movq	-24(%rbp), %rdi
	call	putchar
	movq	-32(%rbp), %rdi
	call	putchar
	movq	-40(%rbp), %rdi
	call	putchar
	movq	-48(%rbp), %rdi
	call	putchar
	movq	-56(%rbp), %rdi
	call	putchar
	movq	-64(%rbp), %rdi
	call	putchar
	movq	-72(%rbp), %rdi
	call	putchar

	movq	%rbp, %rsp
	popq	%rbp
	ret
	.globl	f

main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp

	movq	$65, %rdi
	movq	$66, %rsi
	movq	$67, %rdx
	movq	$68, %rcx
	movq	$69, %r8
	movq	$70, %r9
	pushq	$10
	pushq	$72
	pushq	$71
	call	f
	addq	$48, %rsp

	movq	%rbp, %rsp
	popq	%rbp
	ret
	.globl	main


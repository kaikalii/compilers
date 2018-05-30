main:
	# main() prologue
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$main.size, %rsp

	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	.set	main.size, 32

	movl	$1, -8(%rbp)
	movl	$2, -16(%rbp)
	movl	$3, -24(%rbp)
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdx
	call	print

	# main() epilogue
	movq	%rbp, %rsp
	popq	%rbp
	ret
	.globl	main


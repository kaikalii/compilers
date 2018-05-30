towers:
	# towers() prologue
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$towers.size, %rsp

	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	.set	towers.size, 32

	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rcx
	call	call_towers
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rsi
	call	print_move
	movq	-8(%rbp), %rdi
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rcx
	call	call_towers

	# towers() epilogue
	movq	%rbp, %rsp
	popq	%rbp
	ret
	.globl	towers

main:
	# main() prologue
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$main.size, %rsp

	movq	%rdi, -8(%rbp)
	.set	main.size, 16

	movl	$3, -8(%rbp)
	movq	-8(%rbp), %rdi
	call	print
	movq	-8(%rbp), %rdi
	movq	$1, %rsi
	movq	$2, %rdx
	movq	$3, %rcx
	call	towers

	# main() epilogue
	movq	%rbp, %rsp
	popq	%rbp
	ret
	.globl	main


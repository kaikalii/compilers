main:
	# main() prologue
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$main.size, %rsp

	.set	main.size, 0

	movq	$83, %rdi
	call	putchar
	movq	$101, %rdi
	call	putchar
	movq	$103, %rdi
	call	putchar
	movq	$109, %rdi
	call	putchar
	movq	$101, %rdi
	call	putchar
	movq	$110, %rdi
	call	putchar
	movq	$116, %rdi
	call	putchar
	movq	$97, %rdi
	call	putchar
	movq	$116, %rdi
	call	putchar
	movq	$105, %rdi
	call	putchar
	movq	$111, %rdi
	call	putchar
	movq	$110, %rdi
	call	putchar
	movq	$32, %rdi
	call	putchar
	movq	$102, %rdi
	call	putchar
	movq	$97, %rdi
	call	putchar
	movq	$117, %rdi
	call	putchar
	movq	$108, %rdi
	call	putchar
	movq	$116, %rdi
	call	putchar
	movq	$10, %rdi
	call	putchar

	# main() epilogue
	movq	%rbp, %rsp
	popq	%rbp
	ret
	.globl	main


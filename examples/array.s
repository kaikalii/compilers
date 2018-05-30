main:
	# main() prologue
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$main.size, %rsp

	movq	%rdi, -8(%rbp)
	.set	main.size, 16

	movl	$10, -8(%rbp)
	movq	-8(%rbp), %rdi
	call	init_array
	movq	-8(%rbp), %rdi
	call	print_array

	# main() epilogue
	movq	%rbp, %rsp
	popq	%rbp
	ret
	.globl	main

# declare globals
.comm	a,40,40

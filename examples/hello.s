main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$main.size, %eax
	subq	%rax, %rsp

	# address
	leaq	string2, %r15
	movq	%r15, -8(%rbp)
	movq	-8(%rbp), %rdi
	movl	$0, %eax
	call	printf

	.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	main.size, 16
	.globl	main

	string2: .asciz	"hello world\n"

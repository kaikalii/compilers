foo:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$foo.size, %eax
	subq	%rax, %rsp

	# add
	movl	x, %r15d
	addl	$1, %r15d
	movl	%r15d, x
	# add
	movl	x, %r15d
	addl	$1, %r15d
	# return
	movl	%r15d, %eax
	jmp	.function_1

	.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	foo.size, 0
	.globl	foo

main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$main.size, %eax
	subq	%rax, %rsp

	movl	$65, %r15d
	movl	%r15d, x
	movl	x, %edi
	movl	$0, %eax
	call	putchar
	call	foo
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %edi
	movl	$0, %eax
	call	putchar
	movl	x, %edi
	movl	$0, %eax
	call	putchar
	movl	$10, %edi
	movl	$0, %eax
	call	putchar

	.function_2:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	main.size, 16
	.globl	main

	.comm	x, 4

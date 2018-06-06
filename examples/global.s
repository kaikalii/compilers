foo:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$0, %rsp

	# add
	movl	x, %edi
	addl	$1, %edi
	movl	%edi, x
	# add
	movl	x, %edi
	addl	$1, %edi
	movl	%edi, %eax
	jmp	.function_1

.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	foo

main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$0, %rsp

	movl	$65, %edi
	movl	%edi, x
	movl	x, %edi
	movl	$0, %eax
	call	putchar
	call	foo
	movl	%eax, %edi
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

	.globl	main

	.comm	x, 4

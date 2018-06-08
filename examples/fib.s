fib:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$fib.size, %eax
	subq	%rax, %rsp

	movl	%edi, -4(%rbp)
	# begin if
	# begin logical or
	# equal
	movl	-4(%rbp), %r15d
	cmpl	$0, %r15d
	sete	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	jne	.L4
	# equal
	movl	-4(%rbp), %r14d
	cmpl	$1, %r14d
	sete	%r14b
	movzbl	%r14b, %r14d
	cmpl	$0, %r14d
	jne	.L4
	movl	$0, %r15d
	jmp	.L5
	.L4:
	movl	$1, %r15d
	.L5:
	# end logical or
	cmpl	$0, %r15d
	je		.skip2
	# return
	movl	$1, %eax
	jmp	.function_1
	.skip2:
	# end if
	# subtract
	movl	-4(%rbp), %r15d
	subl	$1, %r15d
	movl	%r15d, -8(%rbp)
	movl	-8(%rbp), %edi
	call	fib
	# subtract
	movl	-4(%rbp), %r15d
	subl	$2, %r15d
	movl	%r15d, -12(%rbp)
	movl	%eax, -16(%rbp)
	movl	-12(%rbp), %edi
	call	fib
	# add
	movl	-16(%rbp), %r15d
	addl	%eax, %r15d
	# return
	movl	%r15d, %eax
	jmp	.function_1

	.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	fib.size, 16
	.globl	fib

main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$main.size, %eax
	subq	%rax, %rsp

	# address
	leaq	string7, %r15
	# address
	leaq	-4(%rbp), %r14
	movq	%r15, -12(%rbp)
	movq	%r14, -20(%rbp)
	movq	-20(%rbp), %rsi
	movq	-12(%rbp), %rdi
	movl	$0, %eax
	call	scanf
	# address
	leaq	string8, %r15
	movq	%r15, -28(%rbp)
	movl	-4(%rbp), %edi
	call	fib
	movl	%eax, -32(%rbp)
	movl	-32(%rbp), %esi
	movq	-28(%rbp), %rdi
	movl	$0, %eax
	call	printf

	.function_6:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	main.size, 32
	.globl	main

	string7: .asciz	"%d"
	string8: .asciz	"%d\n"

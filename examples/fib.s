fib:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	%edi, -4(%rbp)
	movl	$0, %r15d
	movl	%r15d, -8(%rbp)
	# address
	leaq	string2, %r15
	movq	%r15, -24(%rbp)
	movl	-4(%rbp), %esi
	movq	-24(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# begin if
	# begin logical or
	# equal
	movl	-4(%rbp), %r15d
	cmpl	$0, %r15d
	sete	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	jne	.L5
	# equal
	movl	-4(%rbp), %r14d
	cmpl	$1, %r14d
	sete	%r14b
	movzbl	%r14b, %r14d
	cmpl	$0, %r14d
	jne	.L5
	movl	$0, %r15d
	jmp	.L6
	.L5:
	movl	$1, %r15d
	.L6:
	# end logical or
	cmpl	$0, %r15d
	je		.skip3
	movl	$1, %r14d
	movl	%r14d, -8(%rbp)
	jmp	.exit4
	.skip3:
	# subtract
	movl	-4(%rbp), %r13d
	subl	$1, %r13d
	movl	%r15d, -28(%rbp)
	movl	%r14d, -32(%rbp)
	movl	%r13d, -36(%rbp)
	movl	-36(%rbp), %edi
	call	fib
	# subtract
	movl	-4(%rbp), %r15d
	subl	$2, %r15d
	movl	%r15d, -40(%rbp)
	movl	%eax, -44(%rbp)
	movl	-40(%rbp), %edi
	call	fib
	# add
	movl	-44(%rbp), %r15d
	addl	%eax, %r15d
	movl	%r15d, -8(%rbp)
	.exit4:
	# end if
	# address
	leaq	string7, %r15
	movq	%r15, -52(%rbp)
	movl	-8(%rbp), %esi
	movq	-52(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# return
	movl	-8(%rbp), %eax
	jmp	.function_1

	.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	fib

main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	# address
	leaq	string9, %r15
	# address
	leaq	-4(%rbp), %r14
	movq	%r15, -24(%rbp)
	movq	%r14, -32(%rbp)
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdi
	movl	$0, %eax
	call	scanf
	# address
	leaq	string10, %r15
	movq	%r15, -40(%rbp)
	movl	-4(%rbp), %edi
	call	fib
	movl	%eax, -44(%rbp)
	movl	-44(%rbp), %esi
	movq	-40(%rbp), %rdi
	movl	$0, %eax
	call	printf

	.function_8:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	main

	string2: .asciz	"%d\n"
	string7: .asciz	"-%d\n"
	string9: .asciz	"%d"
	string10: .asciz	"%d\n"

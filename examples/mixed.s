main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$main.size, %eax
	subq	%rax, %rsp

	movl	$100, %r15d
	movl	%r15d, -12(%rbp)
	movl	$30, %r15d
	movb	%r15b, -30(%rbp)
	movl	$2, %r15d
	movb	%r15b, -31(%rbp)
	# cast
	movb	-30(%rbp), %r15b
	movsbl	%r15b, %r15d
	# add
	movl	-12(%rbp), %r14d
	addl	%r15d, %r14d
	# cast
	movb	-31(%rbp), %r15b
	movsbl	%r15b, %r15d
	# add
	addl	%r15d, %r14d
	movl	%r14d, -4(%rbp)
	# cast
	movb	-30(%rbp), %r15b
	movsbl	%r15b, %r15d
	# subtract
	movl	-12(%rbp), %r14d
	subl	%r15d, %r14d
	# cast
	movb	-31(%rbp), %r15b
	movsbl	%r15b, %r15d
	# subtract
	subl	%r15d, %r14d
	# cast
	movslq	%r14d, %r14
	movq	%r14, -20(%rbp)
	# cast
	movb	-30(%rbp), %r15b
	movsbl	%r15b, %r15d
	# multiply
	movl	-12(%rbp), %r14d
	imull	%r15d, %r14d
	# cast
	movb	-31(%rbp), %r15b
	movsbl	%r15b, %r15d
	# multiply
	imull	%r15d, %r14d
	# cast
	movslq	%r14d, %r14
	movq	%r14, -28(%rbp)
	# cast
	movb	-30(%rbp), %r15b
	movsbl	%r15b, %r15d
	# divide
	movl	-12(%rbp), %r14d
	movl	%r14d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%eax, %r14d
	# cast
	movb	-31(%rbp), %r15b
	movsbl	%r15b, %r15d
	# add
	addl	%r15d, %r14d
	movl	%r14d, -8(%rbp)
	# cast
	movb	-30(%rbp), %r15b
	movsbl	%r15b, %r15d
	# remainder
	movl	-12(%rbp), %r14d
	movl	%r14d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, %r14d
	# cast
	movb	-31(%rbp), %r15b
	movsbl	%r15b, %r15d
	# subtract
	subl	%r15d, %r14d
	movb	%r14b, -29(%rbp)
	# address
	leaq	string2, %r15
	movq	%r15, -39(%rbp)
	movl	-4(%rbp), %esi
	movq	-39(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string3, %r15
	movq	%r15, -47(%rbp)
	movq	-20(%rbp), %rsi
	movq	-47(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string4, %r15
	movq	%r15, -55(%rbp)
	movq	-28(%rbp), %rsi
	movq	-55(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string5, %r15
	movq	%r15, -63(%rbp)
	movl	-8(%rbp), %esi
	movq	-63(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string6, %r15
	# cast
	movb	-29(%rbp), %r14b
	movsbl	%r14b, %r14d
	movq	%r15, -71(%rbp)
	movl	%r14d, -75(%rbp)
	movl	-75(%rbp), %esi
	movq	-71(%rbp), %rdi
	movl	$0, %eax
	call	printf

	.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	main.size, 80
	.globl	main

	string2: .asciz	"%d\n"
	string3: .asciz	"%ld\n"
	string4: .asciz	"%ld\n"
	string5: .asciz	"%d\n"
	string6: .asciz	"%d\n"

main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$main.size, %eax
	subq	%rax, %rsp

	movl	$100, %r15d
	movl	%r15d, -4(%rbp)
	movl	$30, %r15d
	movl	%r15d, -8(%rbp)
	movl	$2, %r15d
	movl	%r15d, -12(%rbp)
	# add
	movl	-4(%rbp), %r15d
	addl	-8(%rbp), %r15d
	# add
	addl	-12(%rbp), %r15d
	movl	%r15d, -16(%rbp)
	# subtract
	movl	-4(%rbp), %r15d
	subl	-8(%rbp), %r15d
	# subtract
	subl	-12(%rbp), %r15d
	movl	%r15d, -20(%rbp)
	# multiply
	movl	-4(%rbp), %r15d
	imull	-8(%rbp), %r15d
	# multiply
	imull	-12(%rbp), %r15d
	movl	%r15d, -24(%rbp)
	# divide
	movl	-4(%rbp), %r15d
	movl	%r15d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	-8(%rbp)
	movl	%eax, %r15d
	# add
	addl	-12(%rbp), %r15d
	movl	%r15d, -28(%rbp)
	# remainder
	movl	-4(%rbp), %r15d
	movl	%r15d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	-8(%rbp)
	movl	%edx, %r15d
	# subtract
	subl	-12(%rbp), %r15d
	movl	%r15d, -32(%rbp)
	# address
	leaq	string2, %r15
	movq	%r15, -40(%rbp)
	movl	-16(%rbp), %esi
	movq	-40(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string3, %r15
	movq	%r15, -48(%rbp)
	movl	-20(%rbp), %esi
	movq	-48(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string4, %r15
	movq	%r15, -56(%rbp)
	movl	-24(%rbp), %esi
	movq	-56(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string5, %r15
	movq	%r15, -64(%rbp)
	movl	-28(%rbp), %esi
	movq	-64(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string6, %r15
	movq	%r15, -72(%rbp)
	movl	-32(%rbp), %esi
	movq	-72(%rbp), %rdi
	movl	$0, %eax
	call	printf

	.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	main.size, 80
	.globl	main

	string2: .asciz	"%d\n"
	string3: .asciz	"%d\n"
	string4: .asciz	"%d\n"
	string5: .asciz	"%d\n"
	string6: .asciz	"%d\n"

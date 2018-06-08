main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$main.size, %eax
	subq	%rax, %rsp

	movl	$0, %r15d
	movl	%r15d, -4(%rbp)
	# begin while
	.loop2:
	# less than
	movl	-4(%rbp), %r15d
	cmpl	$10, %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit3
	movl	$0, %r14d
	movl	%r14d, -8(%rbp)
	# begin while
	.loop4:
	# less than
	movl	-8(%rbp), %r15d
	cmpl	-4(%rbp), %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit5
	# address
	leaq	string6, %r14
	# multiply
	movl	-4(%rbp), %r13d
	imull	-8(%rbp), %r13d
	movl	%r15d, -12(%rbp)
	movq	%r14, -20(%rbp)
	movl	%r13d, -24(%rbp)
	movl	-24(%rbp), %ecx
	movl	-8(%rbp), %edx
	movl	-4(%rbp), %esi
	movq	-20(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# add
	movl	-8(%rbp), %r15d
	addl	$1, %r15d
	movl	%r15d, -8(%rbp)
	jmp	.loop4
	.exit5:
	# end while
	# add
	movl	-4(%rbp), %r15d
	addl	$1, %r15d
	movl	%r15d, -4(%rbp)
	jmp	.loop2
	.exit3:
	# end while

	.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	main.size, 32
	.globl	main

	string6: .asciz	"%d * %d = %d\n"

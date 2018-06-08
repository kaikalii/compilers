allocate:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$allocate.size, %eax
	subq	%rax, %rsp

	movl	%edi, -4(%rbp)
	movl	$0, %r15d
	movl	%r15d, -8(%rbp)
	# cast
	movl	-4(%rbp), %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$8, %r15
	movq	%r15, -24(%rbp)
	movq	-24(%rbp), %rdi
	movl	$0, %eax
	call	malloc
	movq	%rax, -16(%rbp)
	# begin while
	.loop2:
	# less than
	movl	-8(%rbp), %r15d
	cmpl	-4(%rbp), %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit3
	# cast
	movl	-8(%rbp), %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$8, %r14
	# add
	movq	-16(%rbp), %r13
	addq	%r14, %r13
	# dereference
	movq	(%r13), %r14
	# cast
	movl	-4(%rbp), %r12d
	movslq	%r12d, %r12
	# multiply
	imulq	$4, %r12
	movl	%r15d, -28(%rbp)
	movq	%r14, -36(%rbp)
	movq	%r13, -44(%rbp)
	movq	%r12, -52(%rbp)
	movq	-52(%rbp), %rdi
	movl	$0, %eax
	call	malloc
	movq	-44(%rbp), %r15
	movq	%rax, (%r15)
	# add
	movl	-8(%rbp), %r15d
	addl	$1, %r15d
	movl	%r15d, -8(%rbp)
	jmp	.loop2
	.exit3:
	# end while
	# return
	movq	-16(%rbp), %rax
	jmp	.function_1

	.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	allocate.size, 64
	.globl	allocate

initialize:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$initialize.size, %eax
	subq	%rax, %rsp

	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	$0, %r15d
	movl	%r15d, -16(%rbp)
	# begin while
	.loop5:
	# less than
	movl	-16(%rbp), %r15d
	cmpl	-12(%rbp), %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit6
	movl	$0, %r14d
	movl	%r14d, -20(%rbp)
	# begin while
	.loop7:
	# less than
	movl	-20(%rbp), %r15d
	cmpl	-12(%rbp), %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit8
	# cast
	movl	-16(%rbp), %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$8, %r14
	# add
	movq	-8(%rbp), %r13
	addq	%r14, %r13
	# dereference
	movq	(%r13), %r14
	# cast
	movl	-20(%rbp), %r12d
	movslq	%r12d, %r12
	# multiply
	imulq	$4, %r12
	# add
	addq	%r12, %r14
	# dereference
	movl	(%r14), %r12d
	# add
	movl	-16(%rbp), %r11d
	addl	-20(%rbp), %r11d
	movl	%r11d, (%r14)
	# add
	movl	-20(%rbp), %r15d
	addl	$1, %r15d
	movl	%r15d, -20(%rbp)
	jmp	.loop7
	.exit8:
	# end while
	# add
	movl	-16(%rbp), %r15d
	addl	$1, %r15d
	movl	%r15d, -16(%rbp)
	jmp	.loop5
	.exit6:
	# end while

	.function_4:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	initialize.size, 32
	.globl	initialize

display:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$display.size, %eax
	subq	%rax, %rsp

	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	$0, %r15d
	movl	%r15d, -16(%rbp)
	# begin while
	.loop10:
	# less than
	movl	-16(%rbp), %r15d
	cmpl	-12(%rbp), %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit11
	movl	$0, %r14d
	movl	%r14d, -20(%rbp)
	# begin while
	.loop12:
	# less than
	movl	-20(%rbp), %r15d
	cmpl	-12(%rbp), %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit13
	# cast
	movl	-16(%rbp), %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$8, %r14
	# add
	movq	-8(%rbp), %r13
	addq	%r14, %r13
	# dereference
	movq	(%r13), %r14
	movq	%r14, -28(%rbp)
	# address
	leaq	string14, %r15
	# cast
	movl	-20(%rbp), %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$4, %r14
	# add
	movq	-28(%rbp), %r13
	addq	%r14, %r13
	# dereference
	movl	(%r13), %r14d
	movq	%r15, -36(%rbp)
	movl	%r14d, -40(%rbp)
	movq	%r13, -48(%rbp)
	movl	-40(%rbp), %esi
	movq	-36(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# add
	movl	-20(%rbp), %r15d
	addl	$1, %r15d
	movl	%r15d, -20(%rbp)
	jmp	.loop12
	.exit13:
	# end while
	# add
	movl	-16(%rbp), %r15d
	addl	$1, %r15d
	movl	%r15d, -16(%rbp)
	# address
	leaq	string15, %r15
	movq	%r15, -56(%rbp)
	movq	-56(%rbp), %rdi
	movl	$0, %eax
	call	printf
	jmp	.loop10
	.exit11:
	# end while

	.function_9:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	display.size, 64
	.globl	display

deallocate:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$deallocate.size, %eax
	subq	%rax, %rsp

	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	$0, %r15d
	movl	%r15d, -16(%rbp)
	# begin while
	.loop17:
	# less than
	movl	-16(%rbp), %r15d
	cmpl	-12(%rbp), %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit18
	# cast
	movl	-16(%rbp), %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$8, %r14
	# add
	movq	-8(%rbp), %r13
	addq	%r14, %r13
	# dereference
	movq	(%r13), %r14
	movl	%r15d, -20(%rbp)
	movq	%r14, -28(%rbp)
	movq	%r13, -36(%rbp)
	movq	-28(%rbp), %rdi
	movl	$0, %eax
	call	free
	# add
	movl	-16(%rbp), %r15d
	addl	$1, %r15d
	movl	%r15d, -16(%rbp)
	jmp	.loop17
	.exit18:
	# end while
	movq	-8(%rbp), %rdi
	movl	$0, %eax
	call	free

	.function_16:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	deallocate.size, 48
	.globl	deallocate

main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$main.size, %eax
	subq	%rax, %rsp

	# address
	leaq	string20, %r15
	# address
	leaq	-12(%rbp), %r14
	movq	%r15, -20(%rbp)
	movq	%r14, -28(%rbp)
	movq	-28(%rbp), %rsi
	movq	-20(%rbp), %rdi
	movl	$0, %eax
	call	scanf
	movl	-12(%rbp), %edi
	call	allocate
	movq	%rax, -8(%rbp)
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	initialize
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	display
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	deallocate

	.function_19:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	main.size, 32
	.globl	main

	string14: .asciz	"%d "
	string15: .asciz	"\n"
	string20: .asciz	"%d"

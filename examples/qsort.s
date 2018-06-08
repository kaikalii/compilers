readarray:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$readarray.size, %eax
	subq	%rax, %rsp

	movl	$0, %r15d
	movl	%r15d, -4(%rbp)
	# begin while
	.loop2:
	# less than
	movl	-4(%rbp), %r15d
	cmpl	n, %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit3
	# address
	leaq	string4, %r14
	# cast
	movl	-4(%rbp), %r13d
	movslq	%r13d, %r13
	# multiply
	imulq	$4, %r13
	# add
	movq	a, %r12
	addq	%r13, %r12
	movl	%r15d, -8(%rbp)
	movq	%r14, -16(%rbp)
	movq	%r12, -24(%rbp)
	movq	-24(%rbp), %rsi
	movq	-16(%rbp), %rdi
	movl	$0, %eax
	call	scanf
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

	.set	readarray.size, 32
	.globl	readarray

writearray:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$writearray.size, %eax
	subq	%rax, %rsp

	movl	$0, %r15d
	movl	%r15d, -4(%rbp)
	# begin while
	.loop6:
	# less than
	movl	-4(%rbp), %r15d
	cmpl	n, %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit7
	# address
	leaq	string8, %r14
	# cast
	movl	-4(%rbp), %r13d
	movslq	%r13d, %r13
	# multiply
	imulq	$4, %r13
	# add
	movq	a, %r12
	addq	%r13, %r12
	# dereference
	movl	(%r12), %r13d
	movl	%r15d, -8(%rbp)
	movq	%r14, -16(%rbp)
	movl	%r13d, -20(%rbp)
	movq	%r12, -28(%rbp)
	movl	-20(%rbp), %esi
	movq	-16(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# add
	movl	-4(%rbp), %r15d
	addl	$1, %r15d
	movl	%r15d, -4(%rbp)
	jmp	.loop6
	.exit7:
	# end while
	# address
	leaq	string9, %r15
	movq	%r15, -36(%rbp)
	movq	-36(%rbp), %rdi
	movl	$0, %eax
	call	printf

	.function_5:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	writearray.size, 48
	.globl	writearray

exchange:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$exchange.size, %eax
	subq	%rax, %rsp

	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	# dereference
	movq	-8(%rbp), %r15
	movl	(%r15), %r14d
	movl	%r14d, -20(%rbp)
	# dereference
	movq	-8(%rbp), %r15
	movl	(%r15), %r14d
	# dereference
	movq	-16(%rbp), %r13
	movl	(%r13), %r12d
	movl	%r12d, (%r15)
	# dereference
	movq	-16(%rbp), %r15
	movl	(%r15), %r14d
	movl	-20(%rbp), %r13d
	movl	%r13d, (%r15)

	.function_10:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	exchange.size, 32
	.globl	exchange

partition:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$partition.size, %eax
	subq	%rax, %rsp

	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	# cast
	movl	-12(%rbp), %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$4, %r15
	# add
	movq	-8(%rbp), %r14
	addq	%r15, %r14
	# dereference
	movl	(%r14), %r15d
	movl	%r15d, -28(%rbp)
	# subtract
	movl	-12(%rbp), %r15d
	subl	$1, %r15d
	movl	%r15d, -20(%rbp)
	# add
	movl	-16(%rbp), %r15d
	addl	$1, %r15d
	movl	%r15d, -24(%rbp)
	# begin while
	.loop12:
	# less than
	movl	-20(%rbp), %r15d
	cmpl	-24(%rbp), %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit13
	# subtract
	movl	-24(%rbp), %r14d
	subl	$1, %r14d
	movl	%r14d, -24(%rbp)
	# begin while
	.loop14:
	# cast
	movl	-24(%rbp), %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$4, %r15
	# add
	movq	-8(%rbp), %r14
	addq	%r15, %r14
	# dereference
	movl	(%r14), %r15d
	# greater than
	cmpl	-28(%rbp), %r15d
	setg	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit15
	# subtract
	movl	-24(%rbp), %r13d
	subl	$1, %r13d
	movl	%r13d, -24(%rbp)
	jmp	.loop14
	.exit15:
	# end while
	# add
	movl	-20(%rbp), %r15d
	addl	$1, %r15d
	movl	%r15d, -20(%rbp)
	# begin while
	.loop16:
	# cast
	movl	-20(%rbp), %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$4, %r15
	# add
	movq	-8(%rbp), %r14
	addq	%r15, %r14
	# dereference
	movl	(%r14), %r15d
	# less than
	cmpl	-28(%rbp), %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit17
	# add
	movl	-20(%rbp), %r13d
	addl	$1, %r13d
	movl	%r13d, -20(%rbp)
	jmp	.loop16
	.exit17:
	# end while
	# begin if
	# less than
	movl	-20(%rbp), %r15d
	cmpl	-24(%rbp), %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.skip18
	# cast
	movl	-20(%rbp), %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$4, %r14
	# add
	movq	-8(%rbp), %r13
	addq	%r14, %r13
	# cast
	movl	-24(%rbp), %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$4, %r14
	# add
	movq	-8(%rbp), %r12
	addq	%r14, %r12
	movl	%r15d, -32(%rbp)
	movq	%r13, -40(%rbp)
	movq	%r12, -48(%rbp)
	movq	-48(%rbp), %rsi
	movq	-40(%rbp), %rdi
	call	exchange
	.skip18:
	# end if
	jmp	.loop12
	.exit13:
	# end while
	# return
	movl	-24(%rbp), %eax
	jmp	.function_11

	.function_11:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	partition.size, 48
	.globl	partition

quicksort:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$quicksort.size, %eax
	subq	%rax, %rsp

	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	# begin if
	# greater than
	movl	-16(%rbp), %r15d
	cmpl	-12(%rbp), %r15d
	setg	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.skip21
	movl	%r15d, -24(%rbp)
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	partition
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %edx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	quicksort
	# add
	movl	-20(%rbp), %r15d
	addl	$1, %r15d
	movl	%r15d, -28(%rbp)
	movl	-16(%rbp), %edx
	movl	-28(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	quicksort
	.skip21:
	# end if

	.function_20:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	quicksort.size, 32
	.globl	quicksort

main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$main.size, %eax
	subq	%rax, %rsp

	movl	$8, %r15d
	movl	%r15d, n
	# cast
	movl	n, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$4, %r15
	movq	%r15, -8(%rbp)
	movq	-8(%rbp), %rdi
	movl	$0, %eax
	call	malloc
	movq	%rax, a
	call	readarray
	# subtract
	movl	n, %r15d
	subl	$1, %r15d
	movl	%r15d, -12(%rbp)
	movl	-12(%rbp), %edx
	movl	$0, %esi
	movq	a, %rdi
	call	quicksort
	call	writearray

	.function_23:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	main.size, 16
	.globl	main

	.comm	n, 4
	.comm	a, 8
	string4: .asciz	"%d"
	string8: .asciz	"%d "
	string9: .asciz	"\n"

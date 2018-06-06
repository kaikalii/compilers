readarray:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	$0, %edi
	movl	%edi, -4(%rbp)
	# begin while
.loop2:
	# less than
	movl	-4(%rbp), %edi
	cmpl	n, %edi
	setl	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit3
	# address
	leaq	string4, %rsi
	# cast
	movl	-4(%rbp), %ecx
	movslq	%ecx, %rcx
	# multiply
	imulq	$4, %rcx
	# add
	movq	a, %r8
	addq	%rcx, %r8
	movl	%edi, -20(%rbp)
	movq	%rsi, -28(%rbp)
	movq	%r8, -36(%rbp)
	movq	-36(%rbp), %rsi
	movq	-28(%rbp), %rdi
	movl	$0, %eax
	call	scanf
	# add
	movl	-4(%rbp), %edi
	addl	$1, %edi
	movl	%edi, -4(%rbp)
	jmp	.loop2
.exit3:
	# end while

.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	readarray

writearray:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	$0, %edi
	movl	%edi, -4(%rbp)
	# begin while
.loop6:
	# less than
	movl	-4(%rbp), %edi
	cmpl	n, %edi
	setl	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit7
	# address
	leaq	string8, %rsi
	# cast
	movl	-4(%rbp), %ecx
	movslq	%ecx, %rcx
	# multiply
	imulq	$4, %rcx
	# add
	movq	a, %r8
	addq	%rcx, %r8
	# dereference
	movl	(%r8), %ecx
	movl	%edi, -20(%rbp)
	movq	%rsi, -28(%rbp)
	movl	%ecx, -32(%rbp)
	movq	%r8, -40(%rbp)
	movl	-32(%rbp), %esi
	movq	-28(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# add
	movl	-4(%rbp), %edi
	addl	$1, %edi
	movl	%edi, -4(%rbp)
	jmp	.loop6
.exit7:
	# end while
	# address
	leaq	string9, %rdi
	movq	%rdi, -48(%rbp)
	movq	-48(%rbp), %rdi
	movl	$0, %eax
	call	printf

.function_5:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	writearray

exchange:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp

	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	# dereference
	movq	-8(%rbp), %rdi
	movl	(%rdi), %esi
	movl	%esi, -20(%rbp)
	# dereference
	movq	-8(%rbp), %rdi
	movl	(%rdi), %esi
	# dereference
	movq	-16(%rbp), %rcx
	movl	(%rcx), %r8d
	movl	%r8d, (%rdi)
	# dereference
	movq	-16(%rbp), %rdi
	movl	(%rdi), %esi
	movl	-20(%rbp), %ecx
	movl	%ecx, (%rdi)

.function_10:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	exchange

partition:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp

	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	# cast
	movl	-12(%rbp), %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$4, %rdi
	# add
	movq	-8(%rbp), %rsi
	addq	%rdi, %rsi
	# dereference
	movl	(%rsi), %edi
	movl	%edi, -28(%rbp)
	# subtract
	movl	-12(%rbp), %edi
	subl	$1, %edi
	movl	%edi, -20(%rbp)
	# add
	movl	-16(%rbp), %edi
	addl	$1, %edi
	movl	%edi, -24(%rbp)
	# begin while
.loop12:
	# less than
	movl	-20(%rbp), %edi
	cmpl	-24(%rbp), %edi
	setl	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit13
	# subtract
	movl	-24(%rbp), %esi
	subl	$1, %esi
	movl	%esi, -24(%rbp)
	# begin while
.loop14:
	# cast
	movl	-24(%rbp), %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$4, %rdi
	# add
	movq	-8(%rbp), %rsi
	addq	%rdi, %rsi
	# dereference
	movl	(%rsi), %edi
	# greater than
	cmpl	-28(%rbp), %edi
	setg	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit15
	# subtract
	movl	-24(%rbp), %ecx
	subl	$1, %ecx
	movl	%ecx, -24(%rbp)
	jmp	.loop14
.exit15:
	# end while
	# add
	movl	-20(%rbp), %edi
	addl	$1, %edi
	movl	%edi, -20(%rbp)
	# begin while
.loop16:
	# cast
	movl	-20(%rbp), %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$4, %rdi
	# add
	movq	-8(%rbp), %rsi
	addq	%rdi, %rsi
	# dereference
	movl	(%rsi), %edi
	# less than
	cmpl	-28(%rbp), %edi
	setl	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit17
	# add
	movl	-20(%rbp), %ecx
	addl	$1, %ecx
	movl	%ecx, -20(%rbp)
	jmp	.loop16
.exit17:
	# end while
	# begin if
	# less than
	movl	-20(%rbp), %edi
	cmpl	-24(%rbp), %edi
	setl	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.skip18
	# cast
	movl	-20(%rbp), %esi
	movslq	%esi, %rsi
	# multiply
	imulq	$4, %rsi
	# add
	movq	-8(%rbp), %rcx
	addq	%rsi, %rcx
	# cast
	movl	-24(%rbp), %esi
	movslq	%esi, %rsi
	# multiply
	imulq	$4, %rsi
	# add
	movq	-8(%rbp), %r8
	addq	%rsi, %r8
	movl	%edi, -36(%rbp)
	movq	%rcx, -44(%rbp)
	movq	%r8, -52(%rbp)
	movq	-52(%rbp), %rsi
	movq	-44(%rbp), %rdi
	call	exchange
.skip18:
	# end if
	jmp	.loop12
.exit13:
	# end while
	# return
	movl	%eax, -56(%rbp)
	movl	-24(%rbp), %eax
	jmp	.function_11

.function_11:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	partition

quicksort:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp

	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	# begin if
	# greater than
	movl	-16(%rbp), %edi
	cmpl	-12(%rbp), %edi
	setg	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.skip21
	movl	%edi, -36(%rbp)
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
	movl	-20(%rbp), %edi
	addl	$1, %edi
	movl	%edi, -40(%rbp)
	movl	-16(%rbp), %edx
	movl	-40(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	quicksort
.skip21:
	# end if

.function_20:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	quicksort

main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$0, %rsp

	movl	$8, %edi
	movl	%edi, n
	# cast
	movl	n, %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$4, %rdi
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rdi
	movl	$0, %eax
	call	malloc
	movq	%rax, a
	call	readarray
	# subtract
	movl	n, %edi
	subl	$1, %edi
	movl	%edi, -12(%rbp)
	movl	-12(%rbp), %edx
	movl	$0, %esi
	movq	a, %rdi
	call	quicksort
	call	writearray

.function_23:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	main

	.comm	n, 4
	.comm	a, 8
	string4: .asciz	"%d"
	string8: .asciz	"%d "
	string9: .asciz	"\n"

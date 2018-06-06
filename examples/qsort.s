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
	movl	%ecx, %r8d
	# multiply
	imulq	$4, %r8
	# add
	movq	a, %rcx
	addq	%r8, %rcx
	movq	%rcx, %r8
	movq	%r8, %rsi
	movq	%rsi, %rdi
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
	movl	%ecx, %r8d
	# multiply
	imulq	$4, %r8
	# add
	movq	a, %rcx
	addq	%r8, %rcx
	# dereference
	movq	%rcx, %r8
	movl	(%r8), %ecx
	movl	%ecx, %esi
	movq	%rsi, %rdi
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
	movq	%rdi, %rdi
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
	movl	%edi, %esi
	# multiply
	imulq	$4, %rsi
	# add
	movq	-8(%rbp), %rdi
	addq	%rsi, %rdi
	# dereference
	movq	%rdi, %rsi
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
	movl	%edi, %esi
	# multiply
	imulq	$4, %rsi
	# add
	movq	-8(%rbp), %rdi
	addq	%rsi, %rdi
	# dereference
	movq	%rdi, %rsi
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
	movl	%edi, %esi
	# multiply
	imulq	$4, %rsi
	# add
	movq	-8(%rbp), %rdi
	addq	%rsi, %rdi
	# dereference
	movq	%rdi, %rsi
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
	movl	%esi, %ecx
	# multiply
	imulq	$4, %rcx
	# add
	movq	-8(%rbp), %rsi
	addq	%rcx, %rsi
	movq	%rsi, %rcx
	# cast
	movl	-24(%rbp), %esi
	movslq	%esi, %rsi
	movl	%esi, %r8d
	# multiply
	imulq	$4, %r8
	# add
	movq	-8(%rbp), %rsi
	addq	%r8, %rsi
	movq	%rsi, %r8
	movq	%r8, %rsi
	movq	%rcx, %rdi
	call	exchange
.skip18:
	# end if
	jmp	.loop12
.exit13:
	# end while
	movl	%eax, -36(%rbp)
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
	movl	-16(%rbp), %edx
	movl	%edi, %esi
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
	movl	%edi, %esi
	# multiply
	imulq	$4, %rsi
	movq	%rsi, %rdi
	movl	$0, %eax
	call	malloc
	movq	%rax, a
	call	readarray
	# subtract
	movl	n, %edi
	subl	$1, %edi
	movl	%edi, %edx
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

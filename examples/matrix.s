allocate:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	%edi, -4(%rbp)
	movl	$0, %edi
	movl	%edi, -8(%rbp)
	# cast
	movl	-4(%rbp), %edi
	movslq	%edi, %rdi
	movl	%edi, %esi
	# multiply
	imulq	$8, %rsi
	movq	%rsi, %rdi
	movl	$0, %eax
	call	malloc
	movq	%rax, %rdi
	movq	%rdi, -16(%rbp)
	# begin while
.loop2:
	# less than
	movl	-8(%rbp), %edi
	cmpl	-4(%rbp), %edi
	setl	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit3
	# cast
	movl	-8(%rbp), %esi
	movslq	%esi, %rsi
	movl	%esi, %ecx
	# multiply
	imulq	$8, %rcx
	# add
	movq	-16(%rbp), %rsi
	addq	%rcx, %rsi
	# dereference
	movq	%rsi, %rcx
	movq	(%rcx), %rsi
	# cast
	movl	-4(%rbp), %r8d
	movslq	%r8d, %r8
	movl	%r8d, %r9d
	# multiply
	imulq	$4, %r9
	movq	%r9, %rdi
	movl	$0, %eax
	call	malloc
	movq	%rax, (%rcx)
	# add
	movl	-8(%rbp), %edi
	addl	$1, %edi
	movl	%edi, -8(%rbp)
	jmp	.loop2
.exit3:
	# end while
	movq	%rax, -24(%rbp)
	movq	-16(%rbp), %rax
	jmp	.function_1

.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	allocate

initialize:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp

	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	$0, %edi
	movl	%edi, -16(%rbp)
	# begin while
.loop5:
	# less than
	movl	-16(%rbp), %edi
	cmpl	-12(%rbp), %edi
	setl	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit6
	movl	$0, %esi
	movl	%esi, -20(%rbp)
	# begin while
.loop7:
	# less than
	movl	-20(%rbp), %edi
	cmpl	-12(%rbp), %edi
	setl	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit8
	# cast
	movl	-16(%rbp), %esi
	movslq	%esi, %rsi
	movl	%esi, %ecx
	# multiply
	imulq	$8, %rcx
	# add
	movq	-8(%rbp), %rsi
	addq	%rcx, %rsi
	# dereference
	movq	%rsi, %rcx
	movq	(%rcx), %rsi
	# cast
	movl	-20(%rbp), %r8d
	movslq	%r8d, %r8
	movl	%r8d, %r9d
	# multiply
	imulq	$4, %r9
	# add
	addq	%r9, %rsi
	# dereference
	movq	%rsi, %r8
	movl	(%r8), %esi
	# add
	movl	-16(%rbp), %r9d
	addl	-20(%rbp), %r9d
	movl	%r9d, (%r8)
	# add
	movl	-20(%rbp), %edi
	addl	$1, %edi
	movl	%edi, -20(%rbp)
	jmp	.loop7
.exit8:
	# end while
	# add
	movl	-16(%rbp), %edi
	addl	$1, %edi
	movl	%edi, -16(%rbp)
	jmp	.loop5
.exit6:
	# end while

.function_4:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	initialize

display:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp

	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	$0, %edi
	movl	%edi, -16(%rbp)
	# begin while
.loop10:
	# less than
	movl	-16(%rbp), %edi
	cmpl	-12(%rbp), %edi
	setl	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit11
	movl	$0, %esi
	movl	%esi, -20(%rbp)
	# begin while
.loop12:
	# less than
	movl	-20(%rbp), %edi
	cmpl	-12(%rbp), %edi
	setl	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit13
	# cast
	movl	-16(%rbp), %esi
	movslq	%esi, %rsi
	movl	%esi, %ecx
	# multiply
	imulq	$8, %rcx
	# add
	movq	-8(%rbp), %rsi
	addq	%rcx, %rsi
	# dereference
	movq	%rsi, %rcx
	movq	(%rcx), %rsi
	movq	%rsi, -28(%rbp)
	# address
	leaq	string14, %rdi
	# cast
	movl	-20(%rbp), %esi
	movslq	%esi, %rsi
	movl	%esi, %ecx
	# multiply
	imulq	$4, %rcx
	# add
	movq	-28(%rbp), %rsi
	addq	%rcx, %rsi
	# dereference
	movq	%rsi, %rcx
	movl	(%rcx), %esi
	movl	%esi, %esi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf
	# add
	movl	-20(%rbp), %edi
	addl	$1, %edi
	movl	%edi, -20(%rbp)
	jmp	.loop12
.exit13:
	# end while
	# add
	movl	-16(%rbp), %edi
	addl	$1, %edi
	movl	%edi, -16(%rbp)
	# address
	leaq	string15, %rdi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf
	jmp	.loop10
.exit11:
	# end while

.function_9:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	display

deallocate:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	$0, %edi
	movl	%edi, -16(%rbp)
	# begin while
.loop17:
	# less than
	movl	-16(%rbp), %edi
	cmpl	-12(%rbp), %edi
	setl	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit18
	# cast
	movl	-16(%rbp), %esi
	movslq	%esi, %rsi
	movl	%esi, %ecx
	# multiply
	imulq	$8, %rcx
	# add
	movq	-8(%rbp), %rsi
	addq	%rcx, %rsi
	# dereference
	movq	%rsi, %rcx
	movq	(%rcx), %rsi
	movq	%rsi, %rdi
	movl	$0, %eax
	call	free
	# add
	movl	-16(%rbp), %edi
	addl	$1, %edi
	movl	%edi, -16(%rbp)
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

	.globl	deallocate

main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	# address
	leaq	string20, %rdi
	# address
	leaq	-12(%rbp), %rsi
	movq	%rsi, %rsi
	movq	%rdi, %rdi
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

	.globl	main

	string14: .asciz	"%d "
	string15: .asciz	"\n"
	string20: .asciz	"%d"

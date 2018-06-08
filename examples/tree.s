insert:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$insert.size, %eax
	subq	%rax, %rsp

	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	# begin if
	# not
	movq	-8(%rbp), %r15
	cmpq	$0, %r15
	sete	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.skip2
	# cast
	movl	$3, %r14d
	movslq	%r14d, %r14
	# multiply
	movq	$8, %r13
	imulq	%r14, %r13
	movl	%r15d, -20(%rbp)
	movq	%r13, -28(%rbp)
	movq	-28(%rbp), %rdi
	movl	$0, %eax
	call	malloc
	movq	%rax, -8(%rbp)
	# cast
	movl	$0, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$8, %r15
	# add
	movq	-8(%rbp), %r14
	addq	%r15, %r14
	# dereference
	movq	(%r14), %r15
	movq	-16(%rbp), %r13
	movq	%r13, (%r14)
	# cast
	movl	$1, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$8, %r15
	# add
	movq	-8(%rbp), %r14
	addq	%r15, %r14
	# dereference
	movq	(%r14), %r15
	movq	null, %r13
	movq	%r13, (%r14)
	# cast
	movl	$2, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$8, %r15
	# add
	movq	-8(%rbp), %r14
	addq	%r15, %r14
	# dereference
	movq	(%r14), %r15
	movq	null, %r13
	movq	%r13, (%r14)
	jmp	.exit3
	.skip2:
	# begin if
	# cast
	movl	$0, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$8, %r15
	# add
	movq	-8(%rbp), %r14
	addq	%r15, %r14
	# dereference
	movq	(%r14), %r15
	# less than
	movq	-16(%rbp), %r13
	cmpq	%r15, %r13
	setl	%r13b
	movzbl	%r13b, %r13d
	cmpl	$0, %r13d
	je		.skip4
	# cast
	movl	$1, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$8, %r15
	# add
	movq	-8(%rbp), %r12
	addq	%r15, %r12
	# dereference
	movq	(%r12), %r15
	# cast
	movl	$1, %r11d
	movslq	%r11d, %r11
	# multiply
	imulq	$8, %r11
	# add
	movq	-8(%rbp), %r10
	addq	%r11, %r10
	# dereference
	movq	(%r10), %r11
	movq	%r15, -36(%rbp)
	movq	%r14, -44(%rbp)
	movl	%r13d, -48(%rbp)
	movq	%r12, -56(%rbp)
	movq	%r11, -64(%rbp)
	movq	%r10, -72(%rbp)
	movq	-16(%rbp), %rsi
	movq	-64(%rbp), %rdi
	call	insert
	movq	-56(%rbp), %r15
	movq	%rax, (%r15)
	jmp	.exit5
	.skip4:
	# begin if
	# cast
	movl	$0, %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$8, %r14
	# add
	movq	-8(%rbp), %r13
	addq	%r14, %r13
	# dereference
	movq	(%r13), %r14
	# greater than
	movq	-16(%rbp), %r12
	cmpq	%r14, %r12
	setg	%r12b
	movzbl	%r12b, %r12d
	cmpl	$0, %r12d
	je		.skip6
	# cast
	movl	$2, %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$8, %r14
	# add
	movq	-8(%rbp), %r11
	addq	%r14, %r11
	# dereference
	movq	(%r11), %r14
	# cast
	movl	$2, %r10d
	movslq	%r10d, %r10
	# multiply
	imulq	$8, %r10
	# add
	movq	-8(%rbp), %rbx
	addq	%r10, %rbx
	# dereference
	movq	(%rbx), %r10
	movq	%r15, -80(%rbp)
	movq	%r14, -88(%rbp)
	movq	%r13, -96(%rbp)
	movl	%r12d, -100(%rbp)
	movq	%r11, -108(%rbp)
	movq	%r10, -116(%rbp)
	movq	%rbx, -124(%rbp)
	movq	%rax, -132(%rbp)
	movq	-16(%rbp), %rsi
	movq	-116(%rbp), %rdi
	call	insert
	movq	-108(%rbp), %r15
	movq	%rax, (%r15)
	.skip6:
	# end if
	.exit5:
	# end if
	.exit3:
	# end if
	# return
	movq	-8(%rbp), %rax
	jmp	.function_1

	.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	insert.size, 144
	.globl	insert

search:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$search.size, %eax
	subq	%rax, %rsp

	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	# begin if
	# not
	movq	-8(%rbp), %r15
	cmpq	$0, %r15
	sete	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.skip9
	# return
	movl	$0, %eax
	jmp	.function_8
	.skip9:
	# end if
	# begin if
	# cast
	movl	$0, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$8, %r15
	# add
	movq	-8(%rbp), %r14
	addq	%r15, %r14
	# dereference
	movq	(%r14), %r15
	# less than
	movq	-16(%rbp), %r13
	cmpq	%r15, %r13
	setl	%r13b
	movzbl	%r13b, %r13d
	cmpl	$0, %r13d
	je		.skip11
	# cast
	movl	$1, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$8, %r15
	# add
	movq	-8(%rbp), %r12
	addq	%r15, %r12
	# dereference
	movq	(%r12), %r15
	movq	%r15, -24(%rbp)
	movq	%r14, -32(%rbp)
	movl	%r13d, -36(%rbp)
	movq	%r12, -44(%rbp)
	movq	-16(%rbp), %rsi
	movq	-24(%rbp), %rdi
	call	search
	# return
	jmp	.function_8
	.skip11:
	# end if
	# begin if
	# cast
	movl	$0, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$8, %r15
	# add
	movq	-8(%rbp), %r14
	addq	%r15, %r14
	# dereference
	movq	(%r14), %r15
	# greater than
	movq	-16(%rbp), %r13
	cmpq	%r15, %r13
	setg	%r13b
	movzbl	%r13b, %r13d
	cmpl	$0, %r13d
	je		.skip13
	# cast
	movl	$2, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$8, %r15
	# add
	movq	-8(%rbp), %r12
	addq	%r15, %r12
	# dereference
	movq	(%r12), %r15
	movq	%r15, -52(%rbp)
	movq	%r14, -60(%rbp)
	movl	%r13d, -64(%rbp)
	movq	%r12, -72(%rbp)
	movq	-16(%rbp), %rsi
	movq	-52(%rbp), %rdi
	call	search
	# return
	jmp	.function_8
	.skip13:
	# end if
	# return
	movl	$1, %eax
	jmp	.function_8

	.function_8:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	search.size, 80
	.globl	search

preorder:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$preorder.size, %eax
	subq	%rax, %rsp

	movq	%rdi, -8(%rbp)
	# begin if
	cmpq	$0, -8(%rbp)
	je		.skip16
	# address
	leaq	string18, %r15
	# cast
	movl	$0, %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$8, %r14
	# add
	movq	-8(%rbp), %r13
	addq	%r14, %r13
	# dereference
	movq	(%r13), %r14
	# dereference
	movl	(%r14), %r12d
	movq	%r15, -16(%rbp)
	movq	%r14, -24(%rbp)
	movq	%r13, -32(%rbp)
	movl	%r12d, -36(%rbp)
	movl	-36(%rbp), %esi
	movq	-16(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# cast
	movl	$1, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$8, %r15
	# add
	movq	-8(%rbp), %r14
	addq	%r15, %r14
	# dereference
	movq	(%r14), %r15
	movq	%r15, -44(%rbp)
	movq	%r14, -52(%rbp)
	movq	-44(%rbp), %rdi
	call	preorder
	# cast
	movl	$2, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$8, %r15
	# add
	movq	-8(%rbp), %r14
	addq	%r15, %r14
	# dereference
	movq	(%r14), %r15
	movq	%r15, -60(%rbp)
	movq	%r14, -68(%rbp)
	movq	-60(%rbp), %rdi
	call	preorder
	.skip16:
	# end if

	.function_15:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	preorder.size, 80
	.globl	preorder

inorder:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$inorder.size, %eax
	subq	%rax, %rsp

	movq	%rdi, -8(%rbp)
	# begin if
	cmpq	$0, -8(%rbp)
	je		.skip20
	# cast
	movl	$1, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$8, %r15
	# add
	movq	-8(%rbp), %r14
	addq	%r15, %r14
	# dereference
	movq	(%r14), %r15
	movq	%r15, -16(%rbp)
	movq	%r14, -24(%rbp)
	movq	-16(%rbp), %rdi
	call	inorder
	# address
	leaq	string22, %r15
	# cast
	movl	$0, %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$8, %r14
	# add
	movq	-8(%rbp), %r13
	addq	%r14, %r13
	# dereference
	movq	(%r13), %r14
	# dereference
	movl	(%r14), %r12d
	movq	%r15, -32(%rbp)
	movq	%r14, -40(%rbp)
	movq	%r13, -48(%rbp)
	movl	%r12d, -52(%rbp)
	movl	-52(%rbp), %esi
	movq	-32(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# cast
	movl	$2, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$8, %r15
	# add
	movq	-8(%rbp), %r14
	addq	%r15, %r14
	# dereference
	movq	(%r14), %r15
	movq	%r15, -60(%rbp)
	movq	%r14, -68(%rbp)
	movq	-60(%rbp), %rdi
	call	inorder
	.skip20:
	# end if

	.function_19:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	inorder.size, 80
	.globl	inorder

main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$main.size, %eax
	subq	%rax, %rsp

	movl	$0, %r15d
	movl	%r15d, -52(%rbp)
	# begin while
	.loop24:
	# less than
	movl	-52(%rbp), %r15d
	cmpl	$8, %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit25
	# address
	leaq	-48(%rbp), %r14
	# cast
	movl	-52(%rbp), %r13d
	movslq	%r13d, %r13
	# multiply
	imulq	$4, %r13
	# add
	addq	%r13, %r14
	# dereference
	movl	(%r14), %r13d
	movl	-52(%rbp), %r12d
	movl	%r12d, (%r14)
	# add
	movl	-52(%rbp), %r15d
	addl	$1, %r15d
	movl	%r15d, -52(%rbp)
	jmp	.loop24
	.exit25:
	# end while
	movq	null, %r15
	movq	%r15, -8(%rbp)
	# address
	leaq	-48(%rbp), %r15
	# cast
	movl	$7, %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$4, %r14
	# add
	addq	%r14, %r15
	movq	%r15, -60(%rbp)
	movq	-60(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	-48(%rbp), %r15
	# cast
	movl	$4, %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$4, %r14
	# add
	addq	%r14, %r15
	movq	%r15, -68(%rbp)
	movq	-68(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	-48(%rbp), %r15
	# cast
	movl	$1, %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$4, %r14
	# add
	addq	%r14, %r15
	movq	%r15, -76(%rbp)
	movq	-76(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	-48(%rbp), %r15
	# cast
	movl	$0, %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$4, %r14
	# add
	addq	%r14, %r15
	movq	%r15, -84(%rbp)
	movq	-84(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	-48(%rbp), %r15
	# cast
	movl	$5, %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$4, %r14
	# add
	addq	%r14, %r15
	movq	%r15, -92(%rbp)
	movq	-92(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	-48(%rbp), %r15
	# cast
	movl	$2, %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$4, %r14
	# add
	addq	%r14, %r15
	movq	%r15, -100(%rbp)
	movq	-100(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	-48(%rbp), %r15
	# cast
	movl	$3, %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$4, %r14
	# add
	addq	%r14, %r15
	movq	%r15, -108(%rbp)
	movq	-108(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	-48(%rbp), %r15
	# cast
	movl	$6, %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$4, %r14
	# add
	addq	%r14, %r15
	movq	%r15, -116(%rbp)
	movq	-116(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	string26, %r15
	movq	%r15, -124(%rbp)
	movq	-124(%rbp), %rdi
	movl	$0, %eax
	call	printf
	movq	-8(%rbp), %rdi
	call	preorder
	# address
	leaq	string27, %r15
	movq	%r15, -132(%rbp)
	movq	-132(%rbp), %rdi
	movl	$0, %eax
	call	printf
	movq	-8(%rbp), %rdi
	call	inorder

	.function_23:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	main.size, 144
	.globl	main

	.comm	null, 8
	string18: .asciz	"%d\n"
	string22: .asciz	"%d\n"
	string26: .asciz	"preorder traversal:\n"
	string27: .asciz	"inorder traversal:\n"

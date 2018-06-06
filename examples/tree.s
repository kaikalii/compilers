insert:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	# begin if
	# not
	movq	-8(%rbp), %rdi
	cmpq	$0, %rdi
	sete	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.skip2
	# cast
	movl	$3, %esi
	movslq	%esi, %rsi
	# multiply
	movq	$8, %rcx
	imulq	%rsi, %rcx
	movl	%edi, -20(%rbp)
	movq	%rcx, -28(%rbp)
	movq	-28(%rbp), %rdi
	movl	$0, %eax
	call	malloc
	movq	%rax, -8(%rbp)
	# cast
	movl	$0, %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$8, %rdi
	# add
	movq	-8(%rbp), %rsi
	addq	%rdi, %rsi
	# dereference
	movq	(%rsi), %rdi
	movq	-16(%rbp), %rcx
	movq	%rcx, (%rsi)
	# cast
	movl	$1, %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$8, %rdi
	# add
	movq	-8(%rbp), %rsi
	addq	%rdi, %rsi
	# dereference
	movq	(%rsi), %rdi
	movq	null, %rcx
	movq	%rcx, (%rsi)
	# cast
	movl	$2, %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$8, %rdi
	# add
	movq	-8(%rbp), %rsi
	addq	%rdi, %rsi
	# dereference
	movq	(%rsi), %rdi
	movq	null, %rcx
	movq	%rcx, (%rsi)
	jmp	.exit3
.skip2:
	# begin if
	# cast
	movl	$0, %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$8, %rdi
	# add
	movq	-8(%rbp), %rsi
	addq	%rdi, %rsi
	# dereference
	movq	(%rsi), %rdi
	# less than
	movq	-16(%rbp), %rcx
	cmpq	%rdi, %rcx
	setl	%cl
	movzbl	%cl, %ecx
	cmpl	$0, %ecx
	je		.skip4
	# cast
	movl	$1, %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$8, %rdi
	# add
	movq	-8(%rbp), %r8
	addq	%rdi, %r8
	# dereference
	movq	(%r8), %rdi
	# cast
	movl	$1, %r9d
	movslq	%r9d, %r9
	# multiply
	imulq	$8, %r9
	# add
	movq	-8(%rbp), %rbx
	addq	%r9, %rbx
	# dereference
	movq	(%rbx), %r9
	movq	%rdi, -36(%rbp)
	movq	%rsi, -44(%rbp)
	movl	%ecx, -48(%rbp)
	movq	%r8, -56(%rbp)
	movq	%r9, -64(%rbp)
	movq	%rbx, -72(%rbp)
	movq	-16(%rbp), %rsi
	movq	-64(%rbp), %rdi
	call	insert
	movq	-56(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	.exit5
.skip4:
	# begin if
	# cast
	movl	$0, %esi
	movslq	%esi, %rsi
	# multiply
	imulq	$8, %rsi
	# add
	movq	-8(%rbp), %rcx
	addq	%rsi, %rcx
	# dereference
	movq	(%rcx), %rsi
	# greater than
	movq	-16(%rbp), %r8
	cmpq	%rsi, %r8
	setg	%r8b
	movzbl	%r8b, %r8d
	cmpl	$0, %r8d
	je		.skip6
	# cast
	movl	$2, %esi
	movslq	%esi, %rsi
	# multiply
	imulq	$8, %rsi
	# add
	movq	-8(%rbp), %r9
	addq	%rsi, %r9
	# dereference
	movq	(%r9), %rsi
	# cast
	movl	$2, %ebx
	movslq	%ebx, %rbx
	# multiply
	imulq	$8, %rbx
	# add
	movq	-8(%rbp), %r10
	addq	%rbx, %r10
	# dereference
	movq	(%r10), %rbx
	movq	%rdi, -80(%rbp)
	movq	%rsi, -88(%rbp)
	movq	%rcx, -96(%rbp)
	movl	%r8d, -100(%rbp)
	movq	%r9, -108(%rbp)
	movq	%rbx, -116(%rbp)
	movq	%r10, -124(%rbp)
	movq	-16(%rbp), %rsi
	movq	-116(%rbp), %rdi
	call	insert
	movq	-108(%rbp), %rdi
	movq	%rax, (%rdi)
.skip6:
	# end if
.exit5:
	# end if
.exit3:
	# end if
	# return
	movq	%rax, -132(%rbp)
	movq	-8(%rbp), %rax
	jmp	.function_1

.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	insert

search:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	# begin if
	# not
	movq	-8(%rbp), %rdi
	cmpq	$0, %rdi
	sete	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.skip9
	# return
	movq	%rax, -24(%rbp)
	movl	$0, %eax
	jmp	.function_8
.skip9:
	# end if
	# begin if
	# cast
	movl	$0, %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$8, %rdi
	# add
	movq	-8(%rbp), %rsi
	addq	%rdi, %rsi
	# dereference
	movq	(%rsi), %rdi
	# less than
	movq	-16(%rbp), %rcx
	cmpq	%rdi, %rcx
	setl	%cl
	movzbl	%cl, %ecx
	cmpl	$0, %ecx
	je		.skip11
	# cast
	movl	$1, %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$8, %rdi
	# add
	movq	-8(%rbp), %r8
	addq	%rdi, %r8
	# dereference
	movq	(%r8), %rdi
	movq	%rdi, -32(%rbp)
	movq	%rsi, -40(%rbp)
	movl	%ecx, -44(%rbp)
	movq	%r8, -52(%rbp)
	movq	-16(%rbp), %rsi
	movq	-32(%rbp), %rdi
	call	search
	# return
	jmp	.function_8
.skip11:
	# end if
	# begin if
	# cast
	movl	$0, %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$8, %rdi
	# add
	movq	-8(%rbp), %rsi
	addq	%rdi, %rsi
	# dereference
	movq	(%rsi), %rdi
	# greater than
	movq	-16(%rbp), %rcx
	cmpq	%rdi, %rcx
	setg	%cl
	movzbl	%cl, %ecx
	cmpl	$0, %ecx
	je		.skip13
	# cast
	movl	$2, %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$8, %rdi
	# add
	movq	-8(%rbp), %r8
	addq	%rdi, %r8
	# dereference
	movq	(%r8), %rdi
	movq	%rdi, -60(%rbp)
	movq	%rsi, -68(%rbp)
	movl	%ecx, -72(%rbp)
	movq	%r8, -80(%rbp)
	movq	-16(%rbp), %rsi
	movq	-60(%rbp), %rdi
	call	search
	# return
	jmp	.function_8
.skip13:
	# end if
	# return
	movl	%eax, -84(%rbp)
	movl	$1, %eax
	jmp	.function_8

.function_8:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	search

preorder:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movq	%rdi, -8(%rbp)
	# begin if
	cmpq	$0, -8(%rbp)
	je		.skip16
	# address
	leaq	string18, %rdi
	# cast
	movl	$0, %esi
	movslq	%esi, %rsi
	# multiply
	imulq	$8, %rsi
	# add
	movq	-8(%rbp), %rcx
	addq	%rsi, %rcx
	# dereference
	movq	(%rcx), %rsi
	# dereference
	movl	(%rsi), %r8d
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movl	%r8d, -44(%rbp)
	movl	-44(%rbp), %esi
	movq	-24(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# cast
	movl	$1, %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$8, %rdi
	# add
	movq	-8(%rbp), %rsi
	addq	%rdi, %rsi
	# dereference
	movq	(%rsi), %rdi
	movq	%rdi, -52(%rbp)
	movq	%rsi, -60(%rbp)
	movq	-52(%rbp), %rdi
	call	preorder
	# cast
	movl	$2, %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$8, %rdi
	# add
	movq	-8(%rbp), %rsi
	addq	%rdi, %rsi
	# dereference
	movq	(%rsi), %rdi
	movq	%rdi, -68(%rbp)
	movq	%rsi, -76(%rbp)
	movq	-68(%rbp), %rdi
	call	preorder
.skip16:
	# end if

.function_15:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	preorder

inorder:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movq	%rdi, -8(%rbp)
	# begin if
	cmpq	$0, -8(%rbp)
	je		.skip20
	# cast
	movl	$1, %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$8, %rdi
	# add
	movq	-8(%rbp), %rsi
	addq	%rdi, %rsi
	# dereference
	movq	(%rsi), %rdi
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-24(%rbp), %rdi
	call	inorder
	# address
	leaq	string22, %rdi
	# cast
	movl	$0, %esi
	movslq	%esi, %rsi
	# multiply
	imulq	$8, %rsi
	# add
	movq	-8(%rbp), %rcx
	addq	%rsi, %rcx
	# dereference
	movq	(%rcx), %rsi
	# dereference
	movl	(%rsi), %r8d
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rcx, -56(%rbp)
	movl	%r8d, -60(%rbp)
	movl	-60(%rbp), %esi
	movq	-40(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# cast
	movl	$2, %edi
	movslq	%edi, %rdi
	# multiply
	imulq	$8, %rdi
	# add
	movq	-8(%rbp), %rsi
	addq	%rdi, %rsi
	# dereference
	movq	(%rsi), %rdi
	movq	%rdi, -68(%rbp)
	movq	%rsi, -76(%rbp)
	movq	-68(%rbp), %rdi
	call	inorder
.skip20:
	# end if

.function_19:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	inorder

main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$64, %rsp

	movl	$0, %edi
	movl	%edi, -52(%rbp)
	# begin while
.loop24:
	# less than
	movl	-52(%rbp), %edi
	cmpl	$8, %edi
	setl	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit25
	# address
	leaq	-48(%rbp), %rsi
	# cast
	movl	-52(%rbp), %ecx
	movslq	%ecx, %rcx
	# multiply
	imulq	$4, %rcx
	# add
	addq	%rcx, %rsi
	# dereference
	movl	(%rsi), %ecx
	movl	-52(%rbp), %r8d
	movl	%r8d, (%rsi)
	# add
	movl	-52(%rbp), %edi
	addl	$1, %edi
	movl	%edi, -52(%rbp)
	jmp	.loop24
.exit25:
	# end while
	movq	null, %rdi
	movq	%rdi, -8(%rbp)
	# address
	leaq	-48(%rbp), %rdi
	# cast
	movl	$7, %esi
	movslq	%esi, %rsi
	# multiply
	imulq	$4, %rsi
	# add
	addq	%rsi, %rdi
	movq	%rdi, -72(%rbp)
	movq	-72(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	-48(%rbp), %rdi
	# cast
	movl	$4, %esi
	movslq	%esi, %rsi
	# multiply
	imulq	$4, %rsi
	# add
	addq	%rsi, %rdi
	movq	%rdi, -80(%rbp)
	movq	-80(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	-48(%rbp), %rdi
	# cast
	movl	$1, %esi
	movslq	%esi, %rsi
	# multiply
	imulq	$4, %rsi
	# add
	addq	%rsi, %rdi
	movq	%rdi, -88(%rbp)
	movq	-88(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	-48(%rbp), %rdi
	# cast
	movl	$0, %esi
	movslq	%esi, %rsi
	# multiply
	imulq	$4, %rsi
	# add
	addq	%rsi, %rdi
	movq	%rdi, -96(%rbp)
	movq	-96(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	-48(%rbp), %rdi
	# cast
	movl	$5, %esi
	movslq	%esi, %rsi
	# multiply
	imulq	$4, %rsi
	# add
	addq	%rsi, %rdi
	movq	%rdi, -104(%rbp)
	movq	-104(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	-48(%rbp), %rdi
	# cast
	movl	$2, %esi
	movslq	%esi, %rsi
	# multiply
	imulq	$4, %rsi
	# add
	addq	%rsi, %rdi
	movq	%rdi, -112(%rbp)
	movq	-112(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	-48(%rbp), %rdi
	# cast
	movl	$3, %esi
	movslq	%esi, %rsi
	# multiply
	imulq	$4, %rsi
	# add
	addq	%rsi, %rdi
	movq	%rdi, -120(%rbp)
	movq	-120(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	-48(%rbp), %rdi
	# cast
	movl	$6, %esi
	movslq	%esi, %rsi
	# multiply
	imulq	$4, %rsi
	# add
	addq	%rsi, %rdi
	movq	%rdi, -128(%rbp)
	movq	-128(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	insert
	movq	%rax, -8(%rbp)
	# address
	leaq	string26, %rdi
	movq	%rdi, -136(%rbp)
	movq	-136(%rbp), %rdi
	movl	$0, %eax
	call	printf
	movq	-8(%rbp), %rdi
	call	preorder
	# address
	leaq	string27, %rdi
	movq	%rdi, -144(%rbp)
	movq	-144(%rbp), %rdi
	movl	$0, %eax
	call	printf
	movq	-8(%rbp), %rdi
	call	inorder

.function_23:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	main

	.comm	null, 8
	string18: .asciz	"%d\n"
	string22: .asciz	"%d\n"
	string26: .asciz	"preorder traversal:\n"
	string27: .asciz	"inorder traversal:\n"

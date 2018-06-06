add:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	# add
	movl	-4(%rbp), %edi
	addl	-8(%rbp), %edi
	movl	%edi, %eax
	jmp	.function_1

.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	add

main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$48, %rsp

	# address
	leaq	-40(%rbp), %rdi
	# cast
	movl	$1, %esi
	movslq	%esi, %rsi
	movl	%esi, %ecx
	# multiply
	imulq	$4, %rcx
	# add
	addq	%rcx, %rdi
	# dereference
	movq	%rdi, %rsi
	movl	(%rsi), %edi
	movl	$6, %ecx
	movl	%ecx, (%rsi)
	# address
	leaq	string3, %rdi
	# address
	leaq	-40(%rbp), %rsi
	# cast
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movl	%ecx, %r8d
	# multiply
	imulq	$4, %r8
	# add
	addq	%r8, %rsi
	# dereference
	movq	%rsi, %rcx
	movl	(%rcx), %esi
	movl	%esi, %esi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf

.function_2:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	main

	string3: .asciz	"%d\n"

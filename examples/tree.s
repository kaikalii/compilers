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
	movl	%esi, %ecx
	# multiply
	movq	$8, %rsi
	imulq	%rcx, %rsi
	movq	%rsi, %rdi
	movl	$0, %eax
	call	malloc
	movq	%rax, %rcx
	movq	%rcx, -8(%rbp)
	# cast
	movl	$0, %edi
	movslq	%edi, %rdi
	movl	%edi, %esi
	# multiply
	imulq	$8, %rsi
	# add
	movq	-8(%rbp), %rdi
	addq	%rsi, %rdi
	# dereference
	movq	%rdi, %rsi
	movq	(%rsi), %rdi
	movq	-16(%rbp), %rcx
	movq	%rcx, (%rsi)
	# cast
	movl	$1, %edi
	movslq	%edi, %rdi
	movl	%edi, %esi
	# multiply
	imulq	$8, %rsi
	# add
	movq	-8(%rbp), %rdi
	addq	%rsi, %rdi
	# dereference
	movq	%rdi, %rsi
	movq	(%rsi), %rdi
	movq	null, %rcx
	movq	%rcx, (%rsi)
	# cast
	movl	$2, %edi
	movslq	%edi, %rdi
	movl	%edi, %esi
	# multiply
	imulq	$8, %rsi
	# add
	movq	-8(%rbp), %rdi
	addq	%rsi, %rdi
	# dereference
	movq	%rdi, %rsi
	movq	(%rsi), %rdi
	movq	null, %rcx
	movq	%rcx, (%rsi)
	jmp	.exit3
.skip2:
	# begin if
	# cast
	movl	$0, %edi
	movslq	%edi, %rdi
	movl	%edi, %esi
	# multiply
	imulq	$8, %rsi
	# add
	movq	-8(%rbp), %rdi
	addq	%rsi, %rdi
	# dereference
	movq	%rdi, %rsi
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
	movl	%edi, %r8d
	# multiply
	imulq	$8, %r8
	# add
	movq	-8(%rbp), %rdi
	addq	%r8, %rdi
	# dereference
	movq	%rdi, %r8
	movq	(%r8), %rdi
	# cast
	movl	$1, %r9d
	movslq	%r9d, %r9
	movl	%r9d, %ebx
	# multiply
	imulq	$8, %rbx
	# add
	movq	-8(%rbp), %r9
	addq	%rbx, %r9
	# dereference
	movq	%r9, %rbx
	movq	(%rbx), %r9
	movq	%r9, %r10
	movq	-16(%rbp), %rsi
	movq	%r10, %rdi
	call	insert
	movq	%rax, %r9
	movq	%r9, (%r8)
	jmp	.exit5
.skip4:
	# begin if
	# cast
	movl	$0, %r11d
	movslq	%r11d, %r11
	movl	%r11d, %r12d
	# multiply
	imulq	$8, %r12
	# add
	movq	-8(%rbp), %r11
	addq	%r12, %r11
	# dereference
	movq	%r11, %r12
	movq	(%r12), %r11
	# greater than
	movq	-16(%rbp), %r13
	cmpq	%r11, %r13
	setg	%r13b
	movzbl	%r13b, %r13d
	cmpl	$0, %r13d
	je		.skip6
	# cast
	movl	$2, %r11d
	movslq	%r11d, %r11
	movl	%r11d, %r14d
	# multiply
	imulq	$8, %r14
	# add
	movq	-8(%rbp), %r11
	addq	%r14, %r11
	# dereference
	movq	%r11, %r14
	movq	(%r14), %r11
	# cast
	movl	$2, %r15d
	movslq	%r15d, %r15

g:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %edi
	movl	$0, %eax
	call	abs
	movl	$0, %eax
	call	rand
	movl	%eax, %edi
	movl	$0, %eax
	call	abs
	# add
	addl	$1, %eax
	# remainder
	movl	, %edi
	movl	%eax, %esi
	movl	%edi, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%esi
	movl	%edx, %edi
	movl	%edi, %eax
	jmp	.function_1

.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	g

f:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	# remainder
	movl	-4(%rbp), %edi
	movl	$100000, %esi
	movl	%edi, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%esi
	movl	%edx, %edi
	movl	%edi, -4(%rbp)
	# remainder
	movl	-8(%rbp), %edi
	movl	$100000, %esi
	movl	%edi, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%esi
	movl	%edx, %edi
	movl	%edi, -8(%rbp)
	# begin if
	# address
	leaq	s, %rdi
	# multiply
	movq	$100, %rsi
	imulq	$1, %rsi
	# add
	addq	%rsi, %rdi
	# cast
	movl	$1, %esi
	movslq	%esi, %rsi
	movl	%esi, %ecx
	# multiply
	imulq	$1, %rcx
	# subtract
	subq	%rcx, %rdi
	# less than
	movq	s3, %rsi
	cmpq	%rdi, %rsi
	setl	%sil
	movzbl	%sil, %esi
	cmpl	$0, %esi
	je		.skip3
	# dereference
	movq	s3, %rdi
	movb	(%rdi), %cl
	movl	$102, %r8d
	movb	%r8b, (%rdi)
	# cast
	movl	$1, %edi
	movslq	%edi, %rdi
	movl	%edi, %esi
	# multiply
	imulq	$1, %rsi
	# add
	movq	s3, %rdi
	addq	%rsi, %rdi
	movq	%rdi, s3
.skip3:
	# end if
	# begin if
	# multiply
	movl	-8(%rbp), %edi
	imull	$2, %edi
	# greater than or equal
	movl	-4(%rbp), %esi
	cmpl	%edi, %esi
	setge	%sil
	movzbl	%sil, %esi
	cmpl	$0, %esi
	je		.skip5
	# multiply
	movl	-8(%rbp), %edi
	imull	$3, %edi
	# subtract
	movl	-4(%rbp), %ecx
	subl	%edi, %ecx
	movl	%eax, -20(%rbp)
	movl	%ecx, %eax
	jmp	.function_2
	jmp	.exit6
.skip5:
	# begin if
	# remainder
	movl	-4(%rbp), %edi
	movl	$2, %ecx
	movl	%edi, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%ecx
	movl	%edx, %edi
	# equal
	cmpl	$0, %edi
	sete	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.skip7
	# multiply
	movl	-4(%rbp), %ecx
	imull	$4, %ecx
	# divide
	movl	-8(%rbp), %r8d
	movl	$3, %r9d
	movl	%r8d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r9d
	movl	%eax, %r8d
	movl	%r8d, %esi
	movl	%ecx, %edi
	call	f
	# add
	movl	-4(%rbp), %r9d
	addl	$100, %r9d
	# subtract
	movl	-8(%rbp), %ebx
	subl	$4, %ebx
	movl	%ebx, %esi
	movl	%r9d, %edi
	call	f
	# add
	movl	, %r10d
	addl	%eax, %r10d
	movl	%r10d, %eax
	jmp	.function_2
	jmp	.exit8
.skip7:
	# multiply
	movl	-4(%rbp), %r10d
	imull	$2, %r10d
	# divide
	movl	-8(%rbp), %r11d
	movl	$3, %r12d
	movl	%r11d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r12d
	movl	%eax, %r11d
	movl	%r11d, %esi
	movl	%r10d, %edi
	call	f
	movl	-4(%rbp), %edi
	call	g
	movl	%eax, %edi
	call	g
	# add
	movl	-4(%rbp), %r12d
	addl	%eax, %r12d
	# subtract
	movl	-8(%rbp), %r13d
	subl	$10, %r13d
	movl	%r13d, %esi
	movl	%r12d, %edi
	call	f
	# add
	movl	, %r14d
	addl	%eax, %r14d
	movl	%r14d, %eax
	jmp	.function_2
.exit8:
	# end if
.exit6:
	# end if

.function_2:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	f

main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$64, %rsp

	movl	$500, %edi
	movl	%edi, -49(%rbp)
	# address
	leaq	-4(%rbp), %rdi
	movq	%rdi, p1
	# address
	leaq	i1, %rdi
	movq	%rdi, -12(%rbp)
	# address
	leaq	-20(%rbp), %rdi
	movq	%rdi, q1
	# address
	leaq	l1, %rdi
	movq	%rdi, -28(%rbp)
	# address
	leaq	-29(%rbp), %rdi
	movq	%rdi, s1
	# address
	leaq	c1, %rdi
	movq	%rdi, -37(%rbp)
	# begin while
.loop10:
	# greater than
	movl	-49(%rbp), %edi
	cmpl	$0, %edi
	setg	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit11
	# subtract
	movl	-49(%rbp), %esi
	subl	$1, %esi
	movl	%esi, -49(%rbp)
	movl	$0, %eax
	call	rand
	# remainder
	movl	$10, %edi
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%edi
	movl	%edx, %eax
	# add
	movl	$65, %edi
	addl	%eax, %edi
	movl	%edi, %edi
	movl	$0, %eax
	call	putchar
	# add
	addl	$1, %eax
	movl	%eax, %edi
	movl	$0, %eax
	call	putchar
	# add
	addl	$2, %eax
	movl	%eax, %edi
	movl	$0, %eax
	call	putchar
	# add
	addl	$3, %eax
	movl	%eax, %edi
	movl	$0, %eax
	call	putchar
	# add
	addl	$4, %eax
	movl	%eax, %edi
	movl	$0, %eax
	call	putchar
	movl	$32, %edi
	movl	$0, %eax
	call	putchar
	# address
	leaq	s, %rdi
	movq	%rdi, s3
	# address
	leaq	t, %rdi
	movq	%rdi, -45(%rbp)
	movl	$0, %eax
	call	rand
	# remainder
	movl	$100, %edi
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%edi
	movl	%edx, %eax
	# add
	addl	$1, %eax
	movl	%eax, i1
	movl	$0, %eax
	call	rand
	# remainder
	movl	$1000, %edi
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%edi
	movl	%edx, %eax
	# add
	addl	$1, %eax
	# cast
	movslq	%eax, %rax
	movl	%eax, %edi
	movq	%rdi, l1
	movl	$0, %eax
	call	rand
	# remainder
	movl	$10, %edi
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%edi
	movl	%edx, %eax
	# add
	addl	$1, %eax
	movl	%eax, %edi
	movb	%dil, c1
	movl	$0, %eax
	call	rand
	# remainder
	movl	$30, %edi
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%edi
	movl	%edx, %eax
	# add
	addl	$1, %eax
	movl	%eax, -4(%rbp)
	movl	$0, %eax
	call	rand
	# remainder
	movl	$300, %edi
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%edi
	movl	%edx, %eax
	# add
	addl	$1, %eax
	# cast
	movslq	%eax, %rax
	movl	%eax, %edi
	movq	%rdi, -20(%rbp)
	movl	$0, %eax
	call	rand
	# remainder
	movl	$3, %edi
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%edi
	movl	%edx, %eax
	# add
	addl	$1, %eax
	movl	%eax, %edi
	movb	%dil, -29(%rbp)
	# address
	leaq	string12, %rdi
	movl	-4(%rbp), %edx
	movl	i1, %esi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf
	# begin while
.loop13:
	# remainder
	movl	i1, %edi
	movl	$3, %esi
	movl	%edi, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%esi
	movl	%edx, %edi
	# not equal
	cmpl	$0, %edi
	setne	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit14
	# address
	leaq	string15, %rsi
	# dereference
	movq	p1, %rcx
	movl	(%rcx), %r8d
	# multiply
	movl	-4(%rbp), %r9d
	imull	%r8d, %r9d
	# cast
	movb	-29(%rbp), %r8b
	movsbl	%r8b, %r8d
	movb	%r8b, %bl
	# add
	addl	%ebx, %r9d
	# cast
	movslq	%r9d, %r9
	movl	%r9d, %r8d
	# dereference
	movq	q1, %r9
	movq	(%r9), %rbx
	# dereference
	movq	-37(%rbp), %r10
	movb	(%r10), %r11b
	# cast
	movsbl	%r11b, %r11d
	movb	%r11b, %r12b
	movl	%r12d, %edi
	movl	$0, %eax
	call	abs
	# add
	addl	$1, %eax
	# cast
	movslq	%eax, %rax
	movl	%eax, %r11d
	# remainder
	movq	%r11, %r13
	movq	%rbx, %rax
	movq	%rax, %rdx
	sarq	$31, %rdx
	idivq	%r13
	movq	%rdx, %rbx
	# subtract
	subq	%rbx, %r8
	movq	%r8, %rsi
	movq	%rsi, %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string16, %rdi
	movl	-4(%rbp), %esi
	movl	i1, %edi
	call	f
	movl	%eax, %esi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	call	rand
	# remainder
	movl	$20, %edi
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%edi
	movl	%edx, %eax
	# add
	movl	i1, %edi
	addl	%eax, %edi
	movl	%edi, i1
	# begin while
.loop17:
	movq	-20(%rbp), %rdi
	movl	$0, %eax
	call	labs
	# cast
	movl	$5, %edi
	movslq	%edi, %rdi
	movl	%edi, %esi
	# divide
	movq	%rsi, %rdi
	movq	%rax, %rax
	movq	%rax, %rdx
	sarq	$31, %rdx
	idivq	%rdi
	movq	%rax, %rax
	# cast
	movl	$10, %edi
	movslq	%edi, %rdi
	movl	%edi, %esi
	# greater than
	cmpq	%rsi, %rax
	setg	%al
	movzbl	%al, %eax
	cmpl	$0, %eax
	je		.exit18
	movl	$0, %eax
	call	rand
	# remainder
	movl	$7, %edi
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%edi
	movl	%edx, %eax
	# add
	addl	$1, %eax
	# cast
	movslq	%eax, %rax
	movl	%eax, %edi
	# divide
	movq	-20(%rbp), %rsi
	movq	%rdi, %rcx
	movq	%rsi, %rax
	movq	%rax, %rdx
	sarq	$31, %rdx
	idivq	%rcx
	movq	%rax, %rsi
	movq	%rsi, -20(%rbp)
	# begin if
	# cast
	movl	$0, %edi
	movslq	%edi, %rdi
	movl	%edi, %esi
	# not equal
	movq	-20(%rbp), %rdi
	cmpq	%rsi, %rdi
	setne	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.skip19
	# address
	leaq	string21, %rsi
	# cast
	movb	c1, %cl
	movsbq	%cl, %rcx
	movb	%cl, %r8b
	# cast
	movb	-29(%rbp), %cl
	movsbq	%cl, %rcx
	movb	%cl, %r9b
	# dereference
	movq	-37(%rbp), %rcx
	movb	(%rcx), %bl
	# cast
	movsbq	%bl, %rbx
	movb	%bl, %r10b
	# divide
	movq	-20(%rbp), %rbx
	movq	%r10, %rax
	movq	%rax, %rdx
	sarq	$31, %rdx
	idivq	%rbx
	movq	%rax, %r10
	# multiply
	imulq	%r10, %r9
	# add
	addq	%r9, %r8
	# dereference
	movq	-28(%rbp), %r9
	movq	(%r9), %rbx
	# add
	addq	%rbx, %r8
	movq	%r8, %rbx
	# cast
	movsbl	%bl, %ebx
	movb	%bl, %r8b
	movl	%r8d, %esi
	movq	%rsi, %rdi
	movl	$0, %eax
	call	printf
.skip19:
	# end if
	# cast
	movb	c1, %dil
	movsbl	%dil, %edi
	movb	%dil, %sil
	# add
	addl	$2, %esi
	movl	%esi, %edi
	movb	%dil, c1
	jmp	.loop17
.exit18:
	# end while
	# multiply
	movl	-4(%rbp), %edi
	imull	$3, %edi
	movl	%edi, -4(%rbp)
	jmp	.loop13
.exit14:
	# end while
	# begin while
.loop22:
	# cast
	movb	c1, %dil
	movsbl	%dil, %edi
	movb	%dil, %sil
	# greater than
	cmpl	$1, %esi
	setg	%sil
	movzbl	%sil, %esi
	cmpl	$0, %esi
	je		.exit23
	# cast
	movb	c1, %dil
	movsbl	%dil, %edi
	movb	%dil, %cl
	movl	$0, %eax
	call	rand
	# remainder
	movl	$3, %edi
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%edi
	movl	%edx, %eax
	# subtract
	subl	%eax, %ecx
	movl	%ecx, %edi
	movb	%dil, c1
	# address
	leaq	string24, %rdi
	# begin logical or
	# cast
	movb	-29(%rbp), %sil
	movsbq	%sil, %rsi
	movb	%sil, %cl
	# greater than
	movq	l1, %rsi
	cmpq	%rcx, %rsi
	setg	%sil
	movzbl	%sil, %esi
	movl	%esi, %ecx
	cmpl	$0, %ecx
	jne	.L25
	# begin logical and
	# cast
	movb	-29(%rbp), %sil
	movsbl	%sil, %esi
	movb	%sil, %r8b
	# dereference
	movq	p1, %rsi
	movl	(%rsi), %r9d
	# less than or equal
	cmpl	%r9d, %r8d
	setle	%r8b
	movzbl	%r8b, %r8d
	movl	%r8d, %r9d
	cmpl	$0, %r9d
	je	.L27
	# equal
	movq	p1, %r8
	cmpq	-12(%rbp), %r8
	sete	%r8b
	movzbl	%r8b, %r8d
	cmpl	$0, %r8d
	je	.L27
	movl	$1, %r9d
	jmp	.L28
.L27:
	movl	$0, %r9d
.L28:
	# end logical and
	cmpl	$0, %r9d
	jne	.L25
	movl	$0, %ecx
	jmp	.L26
.L25:
	movl	$1, %ecx
.L26:
	# end logical or
	movl	%ecx, %esi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf
	# begin if
	# dereference
	movq	-28(%rbp), %rdi
	movq	(%rdi), %rsi
	# multiply
	movq	-20(%rbp), %rcx
	imulq	%rsi, %rcx
	# dereference
	movq	-12(%rbp), %rsi
	movl	(%rsi), %r8d
	# add
	addl	$1, %r8d
	# cast
	movslq	%r8d, %r8
	movl	%r8d, %r9d
	# remainder
	movq	%r9, %r8
	movq	%rcx, %rax
	movq	%rax, %rdx
	sarq	$31, %rdx
	idivq	%r8
	movq	%rdx, %rcx
	# cast
	movl	$5, %r8d
	movslq	%r8d, %r8
	movl	%r8d, %r9d
	# greater than
	cmpq	%r9, %rcx
	setg	%cl
	movzbl	%cl, %ecx
	cmpl	$0, %ecx
	je		.skip29
	# address
	leaq	string31, %r8
	# cast
	movb	-29(%rbp), %r9b
	movsbl	%r9b, %r9d
	movb	%r9b, %bl
	# multiply
	movl	i1, %r9d
	imull	%ebx, %r9d
	# cast
	movslq	%r9d, %r9
	movl	%r9d, %ebx
	# subtract
	movq	l1, %r9
	subq	%rbx, %r9
	# dereference
	movq	s1, %rbx
	movb	(%rbx), %r10b
	# cast
	movsbl	%r10b, %r10d
	movb	%r10b, %r11b
	# dereference
	movq	-12(%rbp), %r10
	movl	(%r10), %r12d
	# remainder
	movl	%r12d, %r13d
	movl	%r11d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r13d
	movl	%edx, %r11d
	# cast
	movslq	%r11d, %r11
	movl	%r11d, %r12d
	# subtract
	subq	%r12, %r9
	# greater than or equal
	movq	l1, %r11
	cmpq	-20(%rbp), %r11
	setge	%r11b
	movzbl	%r11b, %r11d
	# cast
	movslq	%r11d, %r11
	movl	%r11d, %r12d
	# add
	addq	%r12, %r9
	movq	%r9, %rsi
	movq	%r8, %rdi
	movl	$0, %eax
	call	printf
	jmp	.exit30
.skip29:
	# begin if
	movl	$0, %eax
	call	rand
	# dereference
	movq	-37(%rbp), %r11
	movb	(%r11), %r12b
	# cast
	movsbl	%r12b, %r12d
	movb	%r12b, %r13b
	movl	%r13d, %edi
	movl	$0, %eax
	call	abs
	# add
	addl	$4, %eax
	# remainder
	movl	, %r12d
	movl	%eax, %r14d
	movl	%r12d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r14d
	movl	%edx, %r12d
	# less than
	cmpl	$10, %r12d
	setl	%r12b
	movzbl	%r12b, %r12d
	cmpl	$0, %r12d
	je		.skip32
	# address
	leaq	string34, %r14
	# dereference
	movq	s1, %r15

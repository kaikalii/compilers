g:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$g.size, %eax
	subq	%rax, %rsp

	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %edi
	movl	$0, %eax
	call	abs
	movl	%eax, -8(%rbp)
	movl	$0, %eax
	call	rand
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %edi
	movl	$0, %eax
	call	abs
	# add
	addl	$1, %eax
	# remainder
	movl	-8(%rbp), %r15d
	movl	%r15d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%eax
	movl	%edx, %r15d
	# return
	movl	%r15d, %eax
	jmp	.function_1

	.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	g.size, 16
	.globl	g

f:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$f.size, %eax
	subq	%rax, %rsp

	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	# remainder
	movl	-4(%rbp), %r15d
	movl	$100000, %r14d
	movl	%r15d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r14d
	movl	%edx, %r15d
	movl	%r15d, -4(%rbp)
	# remainder
	movl	-8(%rbp), %r15d
	movl	$100000, %r14d
	movl	%r15d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r14d
	movl	%edx, %r15d
	movl	%r15d, -8(%rbp)
	# begin if
	# address
	leaq	s, %r15
	# multiply
	movq	$100, %r14
	imulq	$1, %r14
	# add
	addq	%r14, %r15
	# cast
	movl	$1, %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$1, %r14
	# subtract
	subq	%r14, %r15
	# less than
	movq	s3, %r14
	cmpq	%r15, %r14
	setl	%r14b
	movzbl	%r14b, %r14d
	cmpl	$0, %r14d
	je		.skip3
	# dereference
	movq	s3, %r15
	movb	(%r15), %r13b
	movl	$102, %r12d
	movb	%r12b, (%r15)
	# cast
	movl	$1, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$1, %r15
	# add
	movq	s3, %r14
	addq	%r15, %r14
	movq	%r14, s3
	.skip3:
	# end if
	# begin if
	# multiply
	movl	-8(%rbp), %r15d
	imull	$2, %r15d
	# greater than or equal
	movl	-4(%rbp), %r14d
	cmpl	%r15d, %r14d
	setge	%r14b
	movzbl	%r14b, %r14d
	cmpl	$0, %r14d
	je		.skip5
	# multiply
	movl	-8(%rbp), %r15d
	imull	$3, %r15d
	# subtract
	movl	-4(%rbp), %r13d
	subl	%r15d, %r13d
	# return
	movl	%r13d, %eax
	jmp	.function_2
	jmp	.exit6
	.skip5:
	# begin if
	# remainder
	movl	-4(%rbp), %r15d
	movl	$2, %r13d
	movl	%r15d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r13d
	movl	%edx, %r15d
	# equal
	cmpl	$0, %r15d
	sete	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.skip7
	# multiply
	movl	-4(%rbp), %r13d
	imull	$4, %r13d
	# divide
	movl	-8(%rbp), %r12d
	movl	$3, %r11d
	movl	%r12d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r11d
	movl	%eax, %r12d
	movl	%r15d, -12(%rbp)
	movl	%r14d, -16(%rbp)
	movl	%r13d, -20(%rbp)
	movl	%r12d, -24(%rbp)
	movl	%eax, -28(%rbp)
	movl	-24(%rbp), %esi
	movl	-20(%rbp), %edi
	call	f
	# add
	movl	-4(%rbp), %r15d
	addl	$100, %r15d
	# subtract
	movl	-8(%rbp), %r14d
	subl	$4, %r14d
	movl	%r15d, -32(%rbp)
	movl	%r14d, -36(%rbp)
	movl	%eax, -40(%rbp)
	movl	-36(%rbp), %esi
	movl	-32(%rbp), %edi
	call	f
	# add
	movl	-40(%rbp), %r15d
	addl	%eax, %r15d
	# return
	movl	%r15d, %eax
	jmp	.function_2
	jmp	.exit8
	.skip7:
	# multiply
	movl	-4(%rbp), %r15d
	imull	$2, %r15d
	# divide
	movl	-8(%rbp), %r14d
	movl	$3, %r13d
	movl	%r14d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r13d
	movl	%eax, %r14d
	movl	%r15d, -44(%rbp)
	movl	%r14d, -48(%rbp)
	movl	%eax, -52(%rbp)
	movl	-48(%rbp), %esi
	movl	-44(%rbp), %edi
	call	f
	movl	%eax, -56(%rbp)
	movl	-4(%rbp), %edi
	call	g
	movl	%eax, -60(%rbp)
	movl	-60(%rbp), %edi
	call	g
	# add
	movl	-4(%rbp), %r15d
	addl	%eax, %r15d
	# subtract
	movl	-8(%rbp), %r14d
	subl	$10, %r14d
	movl	%r15d, -64(%rbp)
	movl	%r14d, -68(%rbp)
	movl	-68(%rbp), %esi
	movl	-64(%rbp), %edi
	call	f
	# add
	movl	-56(%rbp), %r15d
	addl	%eax, %r15d
	# return
	movl	%r15d, %eax
	jmp	.function_2
	.exit8:
	# end if
	.exit6:
	# end if

	.function_2:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	f.size, 80
	.globl	f

main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$main.size, %eax
	subq	%rax, %rsp

	movl	$500, %r15d
	movl	%r15d, -49(%rbp)
	# address
	leaq	-4(%rbp), %r15
	movq	%r15, p1
	# address
	leaq	i1, %r15
	movq	%r15, -12(%rbp)
	# address
	leaq	-20(%rbp), %r15
	movq	%r15, q1
	# address
	leaq	l1, %r15
	movq	%r15, -28(%rbp)
	# address
	leaq	-29(%rbp), %r15
	movq	%r15, s1
	# address
	leaq	c1, %r15
	movq	%r15, -37(%rbp)
	# begin while
	.loop10:
	# greater than
	movl	-49(%rbp), %r15d
	cmpl	$0, %r15d
	setg	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit11
	# subtract
	movl	-49(%rbp), %r14d
	subl	$1, %r14d
	movl	%r14d, -49(%rbp)
	movl	$0, %eax
	call	rand
	# remainder
	movl	$10, %r15d
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, %eax
	# add
	movl	$65, %r15d
	addl	%eax, %r15d
	movl	%r15d, -53(%rbp)
	movl	-53(%rbp), %edi
	movl	$0, %eax
	call	putchar
	# add
	addl	$1, %eax
	movl	%eax, -57(%rbp)
	movl	-57(%rbp), %edi
	movl	$0, %eax
	call	putchar
	# add
	addl	$2, %eax
	movl	%eax, -61(%rbp)
	movl	-61(%rbp), %edi
	movl	$0, %eax
	call	putchar
	# add
	addl	$3, %eax
	movl	%eax, -65(%rbp)
	movl	-65(%rbp), %edi
	movl	$0, %eax
	call	putchar
	# add
	addl	$4, %eax
	movl	%eax, -69(%rbp)
	movl	-69(%rbp), %edi
	movl	$0, %eax
	call	putchar
	movl	$32, %edi
	movl	$0, %eax
	call	putchar
	# address
	leaq	s, %r15
	movq	%r15, s3
	# address
	leaq	t, %r15
	movq	%r15, -45(%rbp)
	movl	$0, %eax
	call	rand
	# remainder
	movl	$100, %r15d
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, %eax
	# add
	addl	$1, %eax
	movl	%eax, i1
	movl	$0, %eax
	call	rand
	# remainder
	movl	$1000, %r15d
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, %eax
	# add
	addl	$1, %eax
	# cast
	movslq	%eax, %rax
	movq	%rax, l1
	movl	$0, %eax
	call	rand
	# remainder
	movl	$10, %r15d
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, %eax
	# add
	addl	$1, %eax
	movb	%al, c1
	movl	$0, %eax
	call	rand
	# remainder
	movl	$30, %r15d
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, %eax
	# add
	addl	$1, %eax
	movl	%eax, -4(%rbp)
	movl	$0, %eax
	call	rand
	# remainder
	movl	$300, %r15d
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, %eax
	# add
	addl	$1, %eax
	# cast
	movslq	%eax, %rax
	movq	%rax, -20(%rbp)
	movl	$0, %eax
	call	rand
	# remainder
	movl	$3, %r15d
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, %eax
	# add
	addl	$1, %eax
	movb	%al, -29(%rbp)
	# address
	leaq	string12, %r15
	movq	%r15, -77(%rbp)
	movl	-4(%rbp), %edx
	movl	i1, %esi
	movq	-77(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# begin while
	.loop13:
	# remainder
	movl	i1, %r15d
	movl	$3, %r14d
	movl	%r15d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r14d
	movl	%edx, %r15d
	# not equal
	cmpl	$0, %r15d
	setne	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit14
	# address
	leaq	string15, %r14
	# dereference
	movq	p1, %r13
	movl	(%r13), %r12d
	# multiply
	movl	-4(%rbp), %r11d
	imull	%r12d, %r11d
	# cast
	movb	-29(%rbp), %r12b
	movsbl	%r12b, %r12d
	# add
	addl	%r12d, %r11d
	# cast
	movslq	%r11d, %r11
	# dereference
	movq	q1, %r12
	movq	(%r12), %r10
	# dereference
	movq	-37(%rbp), %rbx
	movb	(%rbx), %r9b
	# cast
	movsbl	%r9b, %r9d
	movl	%r15d, -81(%rbp)
	movq	%r14, -89(%rbp)
	movq	%r13, -97(%rbp)
	movq	%r12, -105(%rbp)
	movq	%r11, -113(%rbp)
	movq	%r10, -121(%rbp)
	movq	%rbx, -129(%rbp)
	movl	%r9d, -133(%rbp)
	movl	-133(%rbp), %edi
	movl	$0, %eax
	call	abs
	# add
	addl	$1, %eax
	# cast
	movslq	%eax, %rax
	# remainder
	movq	-121(%rbp), %r15
	movq	%r15, %rax
	movq	%rax, %rdx
	sarq	$63, %rdx
	idivq	%rax
	movq	%rdx, %r15
	# subtract
	movq	-113(%rbp), %r14
	subq	%r15, %r14
	movq	%r14, -141(%rbp)
	movq	-141(%rbp), %rsi
	movq	-89(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string16, %r15
	movq	%r15, -149(%rbp)
	movl	-4(%rbp), %esi
	movl	i1, %edi
	call	f
	movl	%eax, -153(%rbp)
	movl	-153(%rbp), %esi
	movq	-149(%rbp), %rdi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	call	rand
	# remainder
	movl	$20, %r15d
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, %eax
	# add
	movl	i1, %r15d
	addl	%eax, %r15d
	movl	%r15d, i1
	# begin while
	.loop17:
	movq	-20(%rbp), %rdi
	movl	$0, %eax
	call	labs
	# cast
	movl	$5, %r15d
	movslq	%r15d, %r15
	# divide
	movq	%rax, %rax
	movq	%rax, %rdx
	sarq	$63, %rdx
	idivq	%r15
	movq	%rax, %rax
	# cast
	movl	$10, %r15d
	movslq	%r15d, %r15
	# greater than
	cmpq	%r15, %rax
	setg	%al
	movzbl	%al, %eax
	cmpl	$0, %eax
	je		.exit18
	movl	%eax, -157(%rbp)
	movl	$0, %eax
	call	rand
	# remainder
	movl	$7, %r15d
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, %eax
	# add
	addl	$1, %eax
	# cast
	movslq	%eax, %rax
	# divide
	movq	-20(%rbp), %r15
	movq	%r15, %rax
	movq	%rax, %rdx
	sarq	$63, %rdx
	idivq	%rax
	movq	%rax, %r15
	movq	%r15, -20(%rbp)
	# begin if
	# cast
	movl	$0, %r15d
	movslq	%r15d, %r15
	# not equal
	movq	-20(%rbp), %r14
	cmpq	%r15, %r14
	setne	%r14b
	movzbl	%r14b, %r14d
	cmpl	$0, %r14d
	je		.skip19
	# address
	leaq	string21, %r15
	# cast
	movb	c1, %r13b
	movsbq	%r13b, %r13
	# cast
	movb	-29(%rbp), %r12b
	movsbq	%r12b, %r12
	# dereference
	movq	-37(%rbp), %r11
	movb	(%r11), %r10b
	# cast
	movsbq	%r10b, %r10
	# divide
	movq	%r10, %rax
	movq	%rax, %rdx
	sarq	$63, %rdx
	idivq	-20(%rbp)
	movq	%rax, %r10
	# multiply
	imulq	%r10, %r12
	# add
	addq	%r12, %r13
	# dereference
	movq	-28(%rbp), %r12
	movq	(%r12), %r10
	# add
	addq	%r10, %r13
	# cast
	movsbl	%r13b, %r13d
	movq	%r15, -165(%rbp)
	movl	%r14d, -169(%rbp)
	movl	%r13d, -173(%rbp)
	movq	%r12, -181(%rbp)
	movq	%r11, -189(%rbp)
	movl	-173(%rbp), %esi
	movq	-165(%rbp), %rdi
	movl	$0, %eax
	call	printf
	.skip19:
	# end if
	# cast
	movb	c1, %r15b
	movsbl	%r15b, %r15d
	# add
	addl	$2, %r15d
	movb	%r15b, c1
	jmp	.loop17
	.exit18:
	# end while
	# multiply
	movl	-4(%rbp), %r15d
	imull	$3, %r15d
	movl	%r15d, -4(%rbp)
	jmp	.loop13
	.exit14:
	# end while
	# begin while
	.loop22:
	# cast
	movb	c1, %r15b
	movsbl	%r15b, %r15d
	# greater than
	cmpl	$1, %r15d
	setg	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit23
	# cast
	movb	c1, %r14b
	movsbl	%r14b, %r14d
	movl	%r15d, -193(%rbp)
	movl	%r14d, -197(%rbp)
	movl	$0, %eax
	call	rand
	# remainder
	movl	$3, %r15d
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, %eax
	# subtract
	movl	-197(%rbp), %r15d
	subl	%eax, %r15d
	movb	%r15b, c1
	# address
	leaq	string24, %r15
	# begin logical or
	# cast
	movb	-29(%rbp), %r14b
	movsbq	%r14b, %r14
	# greater than
	movq	l1, %r13
	cmpq	%r14, %r13
	setg	%r13b
	movzbl	%r13b, %r13d
	cmpl	$0, %r13d
	jne	.L25
	# begin logical and
	# cast
	movb	-29(%rbp), %r14b
	movsbl	%r14b, %r14d
	# dereference
	movq	p1, %r12
	movl	(%r12), %r11d
	# less than or equal
	cmpl	%r11d, %r14d
	setle	%r14b
	movzbl	%r14b, %r14d
	cmpl	$0, %r14d
	je	.L27
	# equal
	movq	p1, %r11
	cmpq	-12(%rbp), %r11
	sete	%r11b
	movzbl	%r11b, %r11d
	cmpl	$0, %r11d
	je	.L27
	movl	$1, %r14d
	jmp	.L28
	.L27:
	movl	$0, %r14d
	.L28:
	# end logical and
	cmpl	$0, %r14d
	jne	.L25
	movl	$0, %r13d
	jmp	.L26
	.L25:
	movl	$1, %r13d
	.L26:
	# end logical or
	movq	%r15, -205(%rbp)
	movl	%r13d, -209(%rbp)
	movq	%r12, -217(%rbp)
	movl	-209(%rbp), %esi
	movq	-205(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# begin if
	# dereference
	movq	-28(%rbp), %r15
	movq	(%r15), %r14
	# multiply
	movq	-20(%rbp), %r13
	imulq	%r14, %r13
	# dereference
	movq	-12(%rbp), %r14
	movl	(%r14), %r12d
	# add
	addl	$1, %r12d
	# cast
	movslq	%r12d, %r12
	# remainder
	movq	%r13, %rax
	movq	%rax, %rdx
	sarq	$63, %rdx
	idivq	%r12
	movq	%rdx, %r13
	# cast
	movl	$5, %r12d
	movslq	%r12d, %r12
	# greater than
	cmpq	%r12, %r13
	setg	%r13b
	movzbl	%r13b, %r13d
	cmpl	$0, %r13d
	je		.skip29
	# address
	leaq	string31, %r12
	# cast
	movb	-29(%rbp), %r11b
	movsbl	%r11b, %r11d
	# multiply
	movl	i1, %r10d
	imull	%r11d, %r10d
	# cast
	movslq	%r10d, %r10
	# subtract
	movq	l1, %r11
	subq	%r10, %r11
	# dereference
	movq	s1, %r10
	movb	(%r10), %bl
	# cast
	movsbl	%bl, %ebx
	# dereference
	movq	-12(%rbp), %r9
	movl	(%r9), %r8d
	# remainder
	movl	%ebx, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r8d
	movl	%edx, %ebx
	# cast
	movslq	%ebx, %rbx
	# subtract
	subq	%rbx, %r11
	# greater than or equal
	movq	l1, %rbx
	cmpq	-20(%rbp), %rbx
	setge	%bl
	movzbl	%bl, %ebx
	# cast
	movslq	%ebx, %rbx
	# add
	addq	%rbx, %r11
	movq	%r15, -225(%rbp)
	movq	%r14, -233(%rbp)
	movl	%r13d, -237(%rbp)
	movq	%r12, -245(%rbp)
	movq	%r11, -253(%rbp)
	movq	%r10, -261(%rbp)
	movq	%r9, -269(%rbp)
	movq	-253(%rbp), %rsi
	movq	-245(%rbp), %rdi
	movl	$0, %eax
	call	printf
	jmp	.exit30
	.skip29:
	# begin if
	movl	%eax, -273(%rbp)
	movl	$0, %eax
	call	rand
	# dereference
	movq	-37(%rbp), %r15
	movb	(%r15), %r14b
	# cast
	movsbl	%r14b, %r14d
	movq	%r15, -281(%rbp)
	movl	%r14d, -285(%rbp)
	movl	%eax, -289(%rbp)
	movl	-285(%rbp), %edi
	movl	$0, %eax
	call	abs
	# add
	addl	$4, %eax
	# remainder
	movl	-289(%rbp), %r15d
	movl	%r15d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%eax
	movl	%edx, %r15d
	# less than
	cmpl	$10, %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.skip32
	# address
	leaq	string34, %r14
	# dereference
	movq	s1, %r13
	movb	(%r13), %r12b
	# cast
	movsbl	%r12b, %r12d
	# address
	leaq	-37(%rbp), %r11
	# dereference
	movq	(%r11), %r10
	# dereference
	movb	(%r10), %bl
	# cast
	movsbl	%bl, %ebx
	# add
	addl	%ebx, %r12d
	# cast
	movb	c1, %bl
	movsbq	%bl, %rbx
	# not equal
	cmpq	-20(%rbp), %rbx
	setne	%bl
	movzbl	%bl, %ebx
	# cast
	movb	-29(%rbp), %r9b
	movsbl	%r9b, %r9d
	# not equal
	cmpl	-4(%rbp), %r9d
	setne	%r9b
	movzbl	%r9b, %r9d
	# multiply
	imull	%r9d, %ebx
	# add
	addl	%ebx, %r12d
	movl	%r15d, -293(%rbp)
	movq	%r14, -301(%rbp)
	movq	%r13, -309(%rbp)
	movl	%r12d, -313(%rbp)
	movq	%r11, -321(%rbp)
	movq	%r10, -329(%rbp)
	movl	-313(%rbp), %esi
	movq	-301(%rbp), %rdi
	movl	$0, %eax
	call	printf
	jmp	.exit33
	.skip32:
	# address
	leaq	string35, %r15
	# cast
	movl	$7, %r14d
	movslq	%r14d, %r14
	# divide
	movq	l1, %r13
	movq	%r13, %rax
	movq	%rax, %rdx
	sarq	$63, %rdx
	idivq	%r14
	movq	%rax, %r13
	# cast
	movb	-29(%rbp), %r14b
	movsbq	%r14b, %r14
	# subtract
	subq	%r14, %r13
	# dereference
	movq	s1, %r14
	movb	(%r14), %r12b
	# cast
	movsbl	%r12b, %r12d
	# dereference
	movq	-12(%rbp), %r11
	movl	(%r11), %r10d
	# remainder
	movl	%r12d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r10d
	movl	%edx, %r12d
	# cast
	movslq	%r12d, %r12
	# subtract
	subq	%r12, %r13
	# greater than or equal
	movq	l1, %r12
	cmpq	-20(%rbp), %r12
	setge	%r12b
	movzbl	%r12b, %r12d
	# cast
	movslq	%r12d, %r12
	# add
	addq	%r12, %r13
	movq	%r15, -337(%rbp)
	movq	%r14, -345(%rbp)
	movq	%r13, -353(%rbp)
	movq	%r11, -361(%rbp)
	movl	%eax, -365(%rbp)
	movq	-353(%rbp), %rsi
	movq	-337(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	c1, %r15
	movq	%r15, s1
	# address
	leaq	-29(%rbp), %r15
	movq	%r15, -37(%rbp)
	.exit33:
	# end if
	.exit30:
	# end if
	# begin if
	# cast
	movl	i1, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$1, %r15
	# dereference
	movq	s1, %r14
	movb	(%r14), %r13b
	# cast
	movsbq	%r13b, %r13
	# multiply
	imulq	$1, %r13
	# add
	addq	-37(%rbp), %r13
	# add
	addq	%r13, %r15
	# cast
	movb	c1, %r13b
	movsbq	%r13b, %r13
	# dereference
	movq	-28(%rbp), %r12
	movq	(%r12), %r11
	# multiply
	imulq	%r11, %r13
	# multiply
	imulq	$1, %r13
	# add
	addq	%r13, %r15
	cmpq	$0, %r15
	je		.skip36
	# address
	leaq	string38, %r13
	# add
	movq	l1, %r11
	addq	-20(%rbp), %r11
	# cast
	movb	c1, %r10b
	movsbq	%r10b, %r10
	# add
	addq	%r10, %r11
	movq	%r15, -373(%rbp)
	movq	%r14, -381(%rbp)
	movq	%r13, -389(%rbp)
	movq	%r12, -397(%rbp)
	movq	%r11, -405(%rbp)
	movq	-405(%rbp), %rsi
	movq	-389(%rbp), %rdi
	movl	$0, %eax
	call	printf
	.skip36:
	# end if
	# begin if
	# multiply
	movq	$100, %r15
	imulq	$1, %r15
	# address
	leaq	t, %r14
	# add
	addq	%r14, %r15
	# cast
	movl	$1, %r14d
	movslq	%r14d, %r14
	# multiply
	imulq	$1, %r14
	# subtract
	subq	%r14, %r15
	# greater than or equal
	cmpq	-45(%rbp), %r15
	setge	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.skip39
	# dereference
	movq	-45(%rbp), %r14
	movb	(%r14), %r13b
	movl	%r15d, -409(%rbp)
	movq	%r14, -417(%rbp)
	movb	%r13b, -418(%rbp)
	movl	$0, %eax
	call	rand
	# remainder
	movl	$26, %r15d
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, %eax
	# add
	movl	$65, %r15d
	addl	%eax, %r15d
	movq	-417(%rbp), %r14
	movb	%r15b, (%r14)
	# cast
	movl	$1, %r15d
	movslq	%r15d, %r15
	# multiply
	imulq	$1, %r15
	# add
	movq	-45(%rbp), %r14
	addq	%r15, %r14
	movq	%r14, -45(%rbp)
	.skip39:
	# end if
	movl	$0, %eax
	call	rand
	# remainder
	movl	$100, %r15d
	movl	%eax, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, %eax
	# cast
	movslq	%eax, %rax
	# subtract
	movq	l1, %r15
	subq	%rax, %r15
	movq	%r15, l1
	jmp	.loop22
	.exit23:
	# end while
	# address
	leaq	t, %r15
	movq	%r15, -12(%rbp)
	movl	$0, %r15d
	movl	%r15d, i1
	# dereference
	movq	s3, %r15
	movb	(%r15), %r14b
	movl	$0, %r13d
	movb	%r13b, (%r15)
	# dereference
	movq	-45(%rbp), %r15
	movb	(%r15), %r14b
	movl	$0, %r13d
	movb	%r13b, (%r15)
	# begin while
	.loop41:
	# less than
	movl	i1, %r15d
	cmpl	$5, %r15d
	setl	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit42
	# address
	leaq	string43, %r14
	# cast
	movl	i1, %r13d
	movslq	%r13d, %r13
	# multiply
	imulq	$4, %r13
	# add
	movq	-12(%rbp), %r12
	addq	%r13, %r12
	# dereference
	movl	(%r12), %r13d
	movl	%r15d, -422(%rbp)
	movq	%r14, -430(%rbp)
	movl	%r13d, -434(%rbp)
	movq	%r12, -442(%rbp)
	movl	-434(%rbp), %esi
	movq	-430(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# add
	movl	i1, %r15d
	addl	$1, %r15d
	movl	%r15d, i1
	jmp	.loop41
	.exit42:
	# end while
	# address
	leaq	string44, %r15
	# dereference
	movq	s1, %r14
	movb	(%r14), %r13b
	# cast
	movsbl	%r13b, %r13d
	# dereference
	movq	-37(%rbp), %r12
	movb	(%r12), %r11b
	# cast
	movsbl	%r11b, %r11d
	# dereference
	movq	p1, %r10
	movl	(%r10), %ebx
	# multiply
	imull	%ebx, %r11d
	# dereference
	movq	-12(%rbp), %rbx
	movl	(%rbx), %r9d
	# multiply
	imull	%r9d, %r11d
	# add
	addl	%r11d, %r13d
	movq	%r15, -450(%rbp)
	movq	%r14, -458(%rbp)
	movl	%r13d, -462(%rbp)
	movq	%r12, -470(%rbp)
	movq	%r10, -478(%rbp)
	movq	%rbx, -486(%rbp)
	movl	-462(%rbp), %esi
	movq	-450(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string45, %r15
	# address
	leaq	s, %r14
	# address
	leaq	t, %r13
	movq	%r15, -494(%rbp)
	movq	%r14, -502(%rbp)
	movq	%r13, -510(%rbp)
	movq	-510(%rbp), %rdx
	movq	-502(%rbp), %rsi
	movq	-494(%rbp), %rdi
	movl	$0, %eax
	call	printf
	movl	$10, %edi
	movl	$0, %eax
	call	putchar
	jmp	.loop10
	.exit11:
	# end while

	.function_9:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	main.size, 512
	.globl	main

	.comm	i1, 4
	.comm	p1, 8
	.comm	z, 4
	.comm	l1, 8
	.comm	q1, 8
	.comm	c1, 1
	.comm	s1, 8
	.comm	s3, 8
	.comm	s, 100
	.comm	t, 100
	string12: .asciz	"i1 = %d  i2 = %d\n"
	string15: .asciz	"%d "
	string16: .asciz	"%d "
	string21: .asciz	"%d "
	string24: .asciz	"%d "
	string31: .asciz	"%ld "
	string34: .asciz	"%d "
	string35: .asciz	"%d "
	string38: .asciz	"%d "
	string43: .asciz	"%d "
	string44: .asciz	"%d "
	string45: .asciz	"%.20s %.20s"

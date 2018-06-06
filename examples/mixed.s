main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp

	movl	$100, %edi
	movl	%edi, -12(%rbp)
	movl	$30, %edi
	movb	%dil, -30(%rbp)
	movl	$2, %edi
	movb	%dil, -31(%rbp)
	# cast
	movb	-30(%rbp), %dil
	movsbl	%dil, %edi
	# add
	movl	-12(%rbp), %esi
	addl	%edi, %esi
	# cast
	movb	-31(%rbp), %dil
	movsbl	%dil, %edi
	# add
	addl	%edi, %esi
	movl	%esi, -4(%rbp)
	# cast
	movb	-30(%rbp), %dil
	movsbl	%dil, %edi
	# subtract
	movl	-12(%rbp), %esi
	subl	%edi, %esi
	# cast
	movb	-31(%rbp), %dil
	movsbl	%dil, %edi
	# subtract
	subl	%edi, %esi
	# cast
	movslq	%esi, %rsi
	movq	%rsi, -20(%rbp)
	# cast
	movb	-30(%rbp), %dil
	movsbl	%dil, %edi
	# multiply
	movl	-12(%rbp), %esi
	imull	%edi, %esi
	# cast
	movb	-31(%rbp), %dil
	movsbl	%dil, %edi
	# multiply
	imull	%edi, %esi
	# cast
	movslq	%esi, %rsi
	movq	%rsi, -28(%rbp)
	# cast
	movb	-30(%rbp), %dil
	movsbl	%dil, %edi
	# divide
	movl	-12(%rbp), %esi
	movl	%edi, %ecx
	movl	%esi, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%ecx
	movl	%eax, %esi
	# cast
	movb	-31(%rbp), %dil
	movsbl	%dil, %edi
	# add
	addl	%edi, %esi
	movl	%esi, -8(%rbp)
	# cast
	movb	-30(%rbp), %dil
	movsbl	%dil, %edi
	# remainder
	movl	-12(%rbp), %esi
	movl	%edi, %ecx
	movl	%esi, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%ecx
	movl	%edx, %esi
	# cast
	movb	-31(%rbp), %dil
	movsbl	%dil, %edi
	# subtract
	subl	%edi, %esi
	movb	%sil, -29(%rbp)
	# address
	leaq	string2, %rdi
	movq	%rdi, -40(%rbp)
	movl	-4(%rbp), %esi
	movq	-40(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string3, %rdi
	movq	%rdi, -48(%rbp)
	movq	-20(%rbp), %rsi
	movq	-48(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string4, %rdi
	movq	%rdi, -56(%rbp)
	movq	-28(%rbp), %rsi
	movq	-56(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string5, %rdi
	movq	%rdi, -64(%rbp)
	movl	-8(%rbp), %esi
	movq	-64(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string6, %rdi
	# cast
	movb	-29(%rbp), %sil
	movsbl	%sil, %esi
	movq	%rdi, -72(%rbp)
	movl	%esi, -76(%rbp)
	movl	-76(%rbp), %esi
	movq	-72(%rbp), %rdi
	movl	$0, %eax
	call	printf

.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	main

	string2: .asciz	"%d\n"
	string3: .asciz	"%ld\n"
	string4: .asciz	"%ld\n"
	string5: .asciz	"%d\n"
	string6: .asciz	"%d\n"

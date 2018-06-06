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
	movb	%dil, %sil
	# add
	movl	-12(%rbp), %edi
	addl	%esi, %edi
	# cast
	movb	-31(%rbp), %sil
	movsbl	%sil, %esi
	movb	%sil, %cl
	# add
	addl	%ecx, %edi
	movl	%edi, -4(%rbp)
	# cast
	movb	-30(%rbp), %dil
	movsbl	%dil, %edi
	movb	%dil, %sil
	# subtract
	movl	-12(%rbp), %edi
	subl	%esi, %edi
	# cast
	movb	-31(%rbp), %sil
	movsbl	%sil, %esi
	movb	%sil, %cl
	# subtract
	subl	%ecx, %edi
	# cast
	movslq	%edi, %rdi
	movl	%edi, %esi
	movq	%rsi, -20(%rbp)
	# cast
	movb	-30(%rbp), %dil
	movsbl	%dil, %edi
	movb	%dil, %sil
	# multiply
	movl	-12(%rbp), %edi
	imull	%esi, %edi
	# cast
	movb	-31(%rbp), %sil
	movsbl	%sil, %esi
	movb	%sil, %cl
	# multiply
	imull	%ecx, %edi
	# cast
	movslq	%edi, %rdi
	movl	%edi, %esi
	movq	%rsi, -28(%rbp)
	# cast
	movb	-30(%rbp), %dil
	movsbl	%dil, %edi
	movb	%dil, %sil
	# divide
	movl	-12(%rbp), %edi
	movl	%esi, %ecx
	movl	%edi, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%ecx
	movl	%eax, %edi
	# cast
	movb	-31(%rbp), %sil
	movsbl	%sil, %esi
	movb	%sil, %cl
	# add
	addl	%ecx, %edi
	movl	%edi, -8(%rbp)
	# cast
	movb	-30(%rbp), %dil
	movsbl	%dil, %edi
	movb	%dil, %sil
	# remainder
	movl	-12(%rbp), %edi
	movl	%esi, %ecx
	movl	%edi, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%ecx
	movl	%edx, %edi
	# cast
	movb	-31(%rbp), %sil
	movsbl	%sil, %esi
	movb	%sil, %cl
	# subtract
	subl	%ecx, %edi
	movl	%edi, %esi
	movb	%sil, -29(%rbp)
	# address
	leaq	string2, %rdi
	movl	-4(%rbp), %esi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string3, %rdi
	movq	-20(%rbp), %rsi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string4, %rdi
	movq	-28(%rbp), %rsi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string5, %rdi
	movl	-8(%rbp), %esi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string6, %rdi
	# cast
	movb	-29(%rbp), %sil
	movsbl	%sil, %esi
	movb	%sil, %cl
	movl	%ecx, %esi
	movq	%rdi, %rdi
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

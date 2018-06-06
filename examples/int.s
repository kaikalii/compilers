main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp

	movl	$100, %edi
	movl	%edi, -4(%rbp)
	movl	$30, %edi
	movl	%edi, -8(%rbp)
	movl	$2, %edi
	movl	%edi, -12(%rbp)
	# add
	movl	-4(%rbp), %edi
	addl	-8(%rbp), %edi
	# add
	addl	-12(%rbp), %edi
	movl	%edi, -16(%rbp)
	# subtract
	movl	-4(%rbp), %edi
	subl	-8(%rbp), %edi
	# subtract
	subl	-12(%rbp), %edi
	movl	%edi, -20(%rbp)
	# multiply
	movl	-4(%rbp), %edi
	imull	-8(%rbp), %edi
	# multiply
	imull	-12(%rbp), %edi
	movl	%edi, -24(%rbp)
	# divide
	movl	-4(%rbp), %edi
	movl	-8(%rbp), %esi
	movl	%edi, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%esi
	movl	%eax, %edi
	# add
	addl	-12(%rbp), %edi
	movl	%edi, -28(%rbp)
	# remainder
	movl	-4(%rbp), %edi
	movl	-8(%rbp), %esi
	movl	%edi, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%esi
	movl	%edx, %edi
	# subtract
	subl	-12(%rbp), %edi
	movl	%edi, -32(%rbp)
	# address
	leaq	string2, %rdi
	movl	-16(%rbp), %esi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string3, %rdi
	movl	-20(%rbp), %esi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string4, %rdi
	movl	-24(%rbp), %esi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string5, %rdi
	movl	-28(%rbp), %esi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf
	# address
	leaq	string6, %rdi
	movl	-32(%rbp), %esi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf

.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	main

	string2: .asciz	"%d\n"
	string3: .asciz	"%d\n"
	string4: .asciz	"%d\n"
	string5: .asciz	"%d\n"
	string6: .asciz	"%d\n"

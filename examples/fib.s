fib:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	%edi, -4(%rbp)
	# begin if
	# begin logical or
	# equal
	movl	-4(%rbp), %edi
	cmpl	$0, %edi
	sete	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	jne	.L4
	# equal
	movl	-4(%rbp), %esi
	cmpl	$1, %esi
	sete	%sil
	movzbl	%sil, %esi
	cmpl	$0, %esi
	jne	.L4
	movl	$0, %edi
	jmp	.L5
.L4:
	movl	$1, %edi
.L5:
	# end logical or
	cmpl	$0, %edi
	je		.skip2
	# return
	movl	$1, %eax
	jmp	.function_1
.skip2:
	# end if
	# subtract
	movl	-4(%rbp), %edi
	subl	$1, %edi
	movl	%edi, -20(%rbp)
	movl	-20(%rbp), %edi
	call	fib
	# subtract
	movl	-4(%rbp), %edi
	subl	$2, %edi
	movl	%edi, -24(%rbp)
	movl	-24(%rbp), %edi
	call	fib
	# add
	movl	, %edi
	addl	%eax, %edi
	# return
	movl	%edi, %eax
	jmp	.function_1

.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	fib

main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	# address
	leaq	string7, %rdi
	# address
	leaq	-4(%rbp), %rsi
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdi
	movl	$0, %eax
	call	scanf
	# address
	leaq	string8, %rdi
	movq	%rdi, -40(%rbp)
	movl	-4(%rbp), %edi
	call	fib
	movl	%eax, %esi
	movq	-40(%rbp), %rdi
	movl	$0, %eax
	call	printf

.function_6:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	main

	string7: .asciz	"%d"
	string8: .asciz	"%d\n"

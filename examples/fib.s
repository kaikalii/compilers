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
	movl	%edi, %esi
	cmpl	$0, %esi
	jne	.L4
	# equal
	movl	-4(%rbp), %edi
	cmpl	$1, %edi
	sete	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	jne	.L4
	movl	$0, %esi
	jmp	.L5
.L4:
	movl	$1, %esi
.L5:
	# end logical or
	cmpl	$0, %esi
	je		.skip2
	movl	$1, %eax
	jmp	.function_1
.skip2:
	# end if
	# subtract
	movl	-4(%rbp), %edi
	subl	$1, %edi
	movl	%edi, %edi
	call	fib
	# subtract
	movl	-4(%rbp), %esi
	subl	$2, %esi
	movl	%esi, %edi
	call	fib
	# add
	movl	, %ecx
	addl	%eax, %ecx
	movl	%ecx, %eax
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
	movq	%rsi, %rsi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	scanf
	# address
	leaq	string8, %rdi
	movl	-4(%rbp), %edi
	call	fib
	movl	%eax, %esi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf

.function_6:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	main

	string7: .asciz	"%d"
	string8: .asciz	"%d\n"

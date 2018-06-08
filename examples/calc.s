lexan:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$lexan.size, %eax
	subq	%rax, %rsp

	# begin if
	# equal
	movl	c, %r15d
	cmpl	$0, %r15d
	sete	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.skip2
	movl	%r15d, -12(%rbp)
	movl	$0, %eax
	call	getchar
	movl	%eax, c
	.skip2:
	# end if
	# begin while
	.loop4:
	# begin logical and
	movl	c, %edi
	movl	$0, %eax
	call	isspace
	cmpl	$0, %eax
	je	.L6
	# not equal
	movl	c, %r15d
	cmpl	NL, %r15d
	setne	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je	.L6
	movl	$1, %eax
	jmp	.L7
	.L6:
	movl	$0, %eax
	.L7:
	# end logical and
	cmpl	$0, %eax
	je		.exit5
	movl	%eax, -16(%rbp)
	movl	$0, %eax
	call	getchar
	movl	%eax, c
	jmp	.loop4
	.exit5:
	# end while
	# begin if
	movl	c, %edi
	movl	$0, %eax
	call	isdigit
	# not
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	cmpl	$0, %eax
	je		.skip8
	movl	c, %r15d
	movl	%r15d, -8(%rbp)
	movl	$0, %r15d
	movl	%r15d, c
	# return
	movl	-8(%rbp), %eax
	jmp	.function_1
	.skip8:
	# end if
	movl	$0, %r15d
	movl	%r15d, -4(%rbp)
	# begin while
	.loop10:
	movl	c, %edi
	movl	$0, %eax
	call	isdigit
	cmpl	$0, %eax
	je		.exit11
	# multiply
	movl	-4(%rbp), %r15d
	imull	$10, %r15d
	# add
	addl	c, %r15d
	# subtract
	subl	$48, %r15d
	movl	%r15d, -4(%rbp)
	movl	c, %edi
	movl	$0, %eax
	call	getchar
	movl	%eax, c
	jmp	.loop10
	.exit11:
	# end while
	movl	-4(%rbp), %r15d
	movl	%r15d, lexval
	# return
	movl	NUM, %eax
	jmp	.function_1

	.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	lexan.size, 16
	.globl	lexan

match:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$match.size, %eax
	subq	%rax, %rsp

	movl	%edi, -4(%rbp)
	# begin if
	# not equal
	movl	lookahead, %r15d
	cmpl	-4(%rbp), %r15d
	setne	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.skip13
	# address
	leaq	string15, %r14
	movl	%r15d, -8(%rbp)
	movq	%r14, -16(%rbp)
	movl	lookahead, %esi
	movq	-16(%rbp), %rdi
	movl	$0, %eax
	call	printf
	movl	$1, %edi
	movl	$0, %eax
	call	exit
	.skip13:
	# end if
	call	lexan
	movl	%eax, lookahead

	.function_12:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	match.size, 16
	.globl	match

factor:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$factor.size, %eax
	subq	%rax, %rsp

	# begin if
	# equal
	movl	lookahead, %r15d
	cmpl	LPAREN, %r15d
	sete	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.skip17
	movl	%r15d, -8(%rbp)
	movl	LPAREN, %edi
	call	match
	movl	$0, %eax
	call	expr
	movl	%eax, -4(%rbp)
	movl	RPAREN, %edi
	call	match
	# return
	movl	-4(%rbp), %eax
	jmp	.function_16
	.skip17:
	# end if
	movl	lexval, %r15d
	movl	%r15d, -4(%rbp)
	movl	NUM, %edi
	call	match
	# return
	movl	-4(%rbp), %eax
	jmp	.function_16

	.function_16:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	factor.size, 16
	.globl	factor

term:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$term.size, %eax
	subq	%rax, %rsp

	call	factor
	movl	%eax, -4(%rbp)
	# begin while
	.loop20:
	# begin logical or
	# equal
	movl	lookahead, %r15d
	cmpl	STAR, %r15d
	sete	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	jne	.L22
	# equal
	movl	lookahead, %r14d
	cmpl	SLASH, %r14d
	sete	%r14b
	movzbl	%r14b, %r14d
	cmpl	$0, %r14d
	jne	.L22
	movl	$0, %r15d
	jmp	.L23
	.L22:
	movl	$1, %r15d
	.L23:
	# end logical or
	cmpl	$0, %r15d
	je		.exit21
	# begin if
	# equal
	movl	lookahead, %r14d
	cmpl	STAR, %r14d
	sete	%r14b
	movzbl	%r14b, %r14d
	cmpl	$0, %r14d
	je		.skip24
	movl	%r15d, -8(%rbp)
	movl	%r14d, -12(%rbp)
	movl	STAR, %edi
	call	match
	call	factor
	# multiply
	movl	-4(%rbp), %r15d
	imull	%eax, %r15d
	movl	%r15d, -4(%rbp)
	jmp	.exit25
	.skip24:
	movl	SLASH, %edi
	call	match
	call	factor
	# divide
	movl	-4(%rbp), %r15d
	movl	%r15d, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%eax
	movl	%eax, %r15d
	movl	%r15d, -4(%rbp)
	.exit25:
	# end if
	jmp	.loop20
	.exit21:
	# end while
	# return
	movl	-4(%rbp), %eax
	jmp	.function_19

	.function_19:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	term.size, 16
	.globl	term

expr:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$expr.size, %eax
	subq	%rax, %rsp

	call	term
	movl	%eax, -4(%rbp)
	# begin while
	.loop27:
	# begin logical or
	# equal
	movl	lookahead, %r15d
	cmpl	PLUS, %r15d
	sete	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	jne	.L29
	# equal
	movl	lookahead, %r14d
	cmpl	MINUS, %r14d
	sete	%r14b
	movzbl	%r14b, %r14d
	cmpl	$0, %r14d
	jne	.L29
	movl	$0, %r15d
	jmp	.L30
	.L29:
	movl	$1, %r15d
	.L30:
	# end logical or
	cmpl	$0, %r15d
	je		.exit28
	# begin if
	# equal
	movl	lookahead, %r14d
	cmpl	PLUS, %r14d
	sete	%r14b
	movzbl	%r14b, %r14d
	cmpl	$0, %r14d
	je		.skip31
	movl	%r15d, -8(%rbp)
	movl	%r14d, -12(%rbp)
	movl	PLUS, %edi
	call	match
	call	term
	# add
	movl	-4(%rbp), %r15d
	addl	%eax, %r15d
	movl	%r15d, -4(%rbp)
	jmp	.exit32
	.skip31:
	movl	MINUS, %edi
	call	match
	call	term
	# subtract
	movl	-4(%rbp), %r15d
	subl	%eax, %r15d
	movl	%r15d, -4(%rbp)
	.exit32:
	# end if
	jmp	.loop27
	.exit28:
	# end while
	# return
	movl	-4(%rbp), %eax
	jmp	.function_26

	.function_26:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	expr.size, 16
	.globl	expr

main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$main.size, %eax
	subq	%rax, %rsp

	movl	$256, %r15d
	movl	%r15d, NUM
	# address
	leaq	string34, %r15
	# dereference
	movb	(%r15), %r14b
	# cast
	movsbl	%r14b, %r14d
	movl	%r14d, NL
	# address
	leaq	string35, %r15
	# dereference
	movb	(%r15), %r14b
	# cast
	movsbl	%r14b, %r14d
	movl	%r14d, LPAREN
	# address
	leaq	string36, %r15
	# dereference
	movb	(%r15), %r14b
	# cast
	movsbl	%r14b, %r14d
	movl	%r14d, RPAREN
	# address
	leaq	string37, %r15
	# dereference
	movb	(%r15), %r14b
	# cast
	movsbl	%r14b, %r14d
	movl	%r14d, PLUS
	# address
	leaq	string38, %r15
	# dereference
	movb	(%r15), %r14b
	# cast
	movsbl	%r14b, %r14d
	movl	%r14d, MINUS
	# address
	leaq	string39, %r15
	# dereference
	movb	(%r15), %r14b
	# cast
	movsbl	%r14b, %r14d
	movl	%r14d, STAR
	# address
	leaq	string40, %r15
	# dereference
	movb	(%r15), %r14b
	# cast
	movsbl	%r14b, %r14d
	movl	%r14d, SLASH
	call	lexan
	movl	%eax, lookahead
	# begin while
	.loop41:
	# negate
	movl	$1, %r15d
	negl	%r15d
	# not equal
	movl	lookahead, %r14d
	cmpl	%r15d, %r14d
	setne	%r14b
	movzbl	%r14b, %r14d
	cmpl	$0, %r14d
	je		.exit42
	movl	%r14d, -8(%rbp)
	call	expr
	movl	%eax, -4(%rbp)
	# address
	leaq	string43, %r15
	movq	%r15, -16(%rbp)
	movl	-4(%rbp), %esi
	movq	-16(%rbp), %rdi
	movl	$0, %eax
	call	printf
	# begin while
	.loop44:
	# equal
	movl	lookahead, %r15d
	cmpl	NL, %r15d
	sete	%r15b
	movzbl	%r15b, %r15d
	cmpl	$0, %r15d
	je		.exit45
	movl	%r15d, -20(%rbp)
	movl	NL, %edi
	call	match
	jmp	.loop44
	.exit45:
	# end while
	jmp	.loop41
	.exit42:
	# end while

	.function_33:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.set	main.size, 32
	.globl	main

	.comm	NUM, 4
	.comm	NL, 4
	.comm	LPAREN, 4
	.comm	RPAREN, 4
	.comm	PLUS, 4
	.comm	MINUS, 4
	.comm	STAR, 4
	.comm	SLASH, 4
	.comm	lookahead, 4
	.comm	c, 4
	.comm	lexval, 4
	string15: .asciz	"syntax error at %d\n"
	string34: .asciz	"\n"
	string35: .asciz	"("
	string36: .asciz	")"
	string37: .asciz	"+"
	string38: .asciz	"-"
	string39: .asciz	"*"
	string40: .asciz	"/"
	string43: .asciz	"%d\n"

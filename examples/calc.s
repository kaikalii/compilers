lexan:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	# begin if
	# equal
	movl	c, %edi
	cmpl	$0, %edi
	sete	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.skip2
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
	movl	%eax, %edi
	cmpl	$0, %edi
	je	.L6
	# not equal
	movl	c, %esi
	cmpl	NL, %esi
	setne	%sil
	movzbl	%sil, %esi
	cmpl	$0, %esi
	je	.L6
	movl	$1, %edi
	jmp	.L7
.L6:
	movl	$0, %edi
.L7:
	# end logical and
	cmpl	$0, %edi
	je		.exit5
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
	movl	c, %edi
	movl	%edi, -8(%rbp)
	movl	$0, %edi
	movl	%edi, c
	movl	%eax, -20(%rbp)
	movl	-8(%rbp), %eax
	jmp	.function_1
.skip8:
	# end if
	movl	$0, %edi
	movl	%edi, -4(%rbp)
	# begin while
.loop10:
	movl	c, %edi
	movl	$0, %eax
	call	isdigit
	cmpl	$0, %eax
	je		.exit11
	# multiply
	movl	-4(%rbp), %edi
	imull	$10, %edi
	# add
	addl	c, %edi
	# subtract
	subl	$48, %edi
	movl	%edi, -4(%rbp)
	movl	c, %edi
	movl	$0, %eax
	call	getchar
	movl	%eax, c
	jmp	.loop10
.exit11:
	# end while
	movl	-4(%rbp), %edi
	movl	%edi, lexval
	movl	%eax, -24(%rbp)
	movl	NUM, %eax
	jmp	.function_1

.function_1:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	lexan

match:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	%edi, -4(%rbp)
	# begin if
	# not equal
	movl	lookahead, %edi
	cmpl	-4(%rbp), %edi
	setne	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.skip13
	# address
	leaq	string15, %rsi
	movl	lookahead, %esi
	movq	%rsi, %rdi
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

	.globl	match

factor:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	# begin if
	# equal
	movl	lookahead, %edi
	cmpl	LPAREN, %edi
	sete	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.skip17
	movl	LPAREN, %edi
	call	match
	movl	$0, %eax
	call	expr
	movl	%eax, -4(%rbp)
	movl	RPAREN, %edi
	call	match
	movl	%eax, -20(%rbp)
	movl	-4(%rbp), %eax
	jmp	.function_16
.skip17:
	# end if
	movl	lexval, %edi
	movl	%edi, -4(%rbp)
	movl	NUM, %edi
	call	match
	movl	%eax, -24(%rbp)
	movl	-4(%rbp), %eax
	jmp	.function_16

.function_16:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	factor

term:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	call	factor
	movl	%eax, -4(%rbp)
	# begin while
.loop20:
	# begin logical or
	# equal
	movl	lookahead, %edi
	cmpl	STAR, %edi
	sete	%dil
	movzbl	%dil, %edi
	movl	%edi, %esi
	cmpl	$0, %esi
	jne	.L22
	# equal
	movl	lookahead, %edi
	cmpl	SLASH, %edi
	sete	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	jne	.L22
	movl	$0, %esi
	jmp	.L23
.L22:
	movl	$1, %esi
.L23:
	# end logical or
	cmpl	$0, %esi
	je		.exit21
	# begin if
	# equal
	movl	lookahead, %edi
	cmpl	STAR, %edi
	sete	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.skip24
	movl	STAR, %edi
	call	match
	call	factor
	# multiply
	movl	-4(%rbp), %edi
	imull	%eax, %edi
	movl	%edi, -4(%rbp)
	jmp	.exit25
.skip24:
	movl	SLASH, %edi
	call	match
	call	factor
	# divide
	movl	-4(%rbp), %edi
	movl	%eax, %esi
	movl	%edi, %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%esi
	movl	%eax, %edi
	movl	%edi, -4(%rbp)
.exit25:
	# end if
	jmp	.loop20
.exit21:
	# end while
	movl	-4(%rbp), %eax
	jmp	.function_19

.function_19:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	term

expr:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	call	term
	movl	%eax, -4(%rbp)
	# begin while
.loop27:
	# begin logical or
	# equal
	movl	lookahead, %edi
	cmpl	PLUS, %edi
	sete	%dil
	movzbl	%dil, %edi
	movl	%edi, %esi
	cmpl	$0, %esi
	jne	.L29
	# equal
	movl	lookahead, %edi
	cmpl	MINUS, %edi
	sete	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	jne	.L29
	movl	$0, %esi
	jmp	.L30
.L29:
	movl	$1, %esi
.L30:
	# end logical or
	cmpl	$0, %esi
	je		.exit28
	# begin if
	# equal
	movl	lookahead, %edi
	cmpl	PLUS, %edi
	sete	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.skip31
	movl	PLUS, %edi
	call	match
	call	term
	# add
	movl	-4(%rbp), %edi
	addl	%eax, %edi
	movl	%edi, -4(%rbp)
	jmp	.exit32
.skip31:
	movl	MINUS, %edi
	call	match
	call	term
	# subtract
	movl	-4(%rbp), %edi
	subl	%eax, %edi
	movl	%edi, -4(%rbp)
.exit32:
	# end if
	jmp	.loop27
.exit28:
	# end while
	movl	-4(%rbp), %eax
	jmp	.function_26

.function_26:
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.globl	expr

main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	$256, %edi
	movl	%edi, NUM
	# address
	leaq	string34, %rdi
	# dereference
	movq	%rdi, %rsi
	movb	(%rsi), %dil
	# cast
	movsbl	%dil, %edi
	movb	%dil, %cl
	movl	%ecx, NL
	# address
	leaq	string35, %rdi
	# dereference
	movq	%rdi, %rsi
	movb	(%rsi), %dil
	# cast
	movsbl	%dil, %edi
	movb	%dil, %cl
	movl	%ecx, LPAREN
	# address
	leaq	string36, %rdi
	# dereference
	movq	%rdi, %rsi
	movb	(%rsi), %dil
	# cast
	movsbl	%dil, %edi
	movb	%dil, %cl
	movl	%ecx, RPAREN
	# address
	leaq	string37, %rdi
	# dereference
	movq	%rdi, %rsi
	movb	(%rsi), %dil
	# cast
	movsbl	%dil, %edi
	movb	%dil, %cl
	movl	%ecx, PLUS
	# address
	leaq	string38, %rdi
	# dereference
	movq	%rdi, %rsi
	movb	(%rsi), %dil
	# cast
	movsbl	%dil, %edi
	movb	%dil, %cl
	movl	%ecx, MINUS
	# address
	leaq	string39, %rdi
	# dereference
	movq	%rdi, %rsi
	movb	(%rsi), %dil
	# cast
	movsbl	%dil, %edi
	movb	%dil, %cl
	movl	%ecx, STAR
	# address
	leaq	string40, %rdi
	# dereference
	movq	%rdi, %rsi
	movb	(%rsi), %dil
	# cast
	movsbl	%dil, %edi
	movb	%dil, %cl
	movl	%ecx, SLASH
	call	lexan
	movl	%eax, lookahead
	# begin while
.loop41:
	# negate
	movl	$1, %edi
	negl	%edi
	# not equal
	movl	lookahead, %esi
	cmpl	%edi, %esi
	setne	%sil
	movzbl	%sil, %esi
	cmpl	$0, %esi
	je		.exit42
	call	expr
	movl	%eax, -4(%rbp)
	# address
	leaq	string43, %rdi
	movl	-4(%rbp), %esi
	movq	%rdi, %rdi
	movl	$0, %eax
	call	printf
	# begin while
.loop44:
	# equal
	movl	lookahead, %edi
	cmpl	NL, %edi
	sete	%dil
	movzbl	%dil, %edi
	cmpl	$0, %edi
	je		.exit45
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

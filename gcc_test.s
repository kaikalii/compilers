	.file	"test.c"
	.text
	.globl	f
	.type	f, @function
f:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movl	%ecx, -16(%rbp)
	movl	%r8d, -20(%rbp)
	movl	%r9d, -24(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	putchar
	movl	-8(%rbp), %eax
	movl	%eax, %edi
	call	putchar
	movl	-12(%rbp), %eax
	movl	%eax, %edi
	call	putchar
	movl	-16(%rbp), %eax
	movl	%eax, %edi
	call	putchar
	movl	-20(%rbp), %eax
	movl	%eax, %edi
	call	putchar
	movl	-24(%rbp), %eax
	movl	%eax, %edi
	call	putchar
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	f, .-f
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$70, %r9d
	movl	$69, %r8d
	movl	$68, %ecx
	movl	$67, %edx
	movl	$66, %esi
	movl	$65, %edi
	call	f
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-16)"
	.section	.note.GNU-stack,"",@progbits

foo:
	# foo() prologue
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$foo.size, %rsp

	.set	foo.size, 0

	movl	$1, x(%rip)
	movl	$2, y(%rip)
	movl	$3, z(%rip)

	# foo() epilogue
	movq	%rbp, %rsp
	popq	%rbp
	ret
	.globl	foo

# declare globals
.comm	x,4,4
.comm	y,4,4
.comm	z,4,4

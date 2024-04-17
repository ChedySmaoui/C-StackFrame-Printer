	.file	"Factorial.c"
	.text
	.type	factorial, @function
factorial:
.LFB0:
	.cfi_startproc
	pushq	%rbp    			# Saves the caller's value for %rbp into the callee's stack (since %rbp is callee-saved,the callee must save it by x86 Assembly calling conventions).
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp  		# The base pointer is given the value of the current stack pointer value (This is part of the calling conventions,
# rsp points to the top of the previous stack frame which is now the base of the current stack frame).
	.cfi_def_cfa_register 6
	subq	$16, %rsp 			# The stack pointer is decremented by 16 bytes to make room for the local variables (stack pointer will now point to the top of the current stack frame).
# All the space in memory between the stack pointer and the base pointer is the factorial function's stack frame.
	movq	%rdi, -8(%rbp) 		# The value of C variable "n" (1st function argument of factorial) is moved into the memory address 8 bytes below the base pointer.
# By convention, rdi holds the 1st 64-bit argument of a function call.
	movq	%rsi, -16(%rbp) 	# The value of C variable "accumulator" (2nd function argument) is moved into the memory address 16 bytes below the base pointer.
# By convention, rsi holds the 2nd 64-bit argument of a function call.
	cmpq	$1, -8(%rbp) 		# Performs n (stored in -8(rbp)) minus 1 without modifying operands.
	ja	.L2 					# If n is above 1 jumps to .L2 (which jumps the conditional statment's block in the C file; i.e. does another factorial call).
	movl	$7, %edi 			# Otherwise, the condition to enter the conditional statement's block in the C file is met.
# DEFAULT_VALUE_OF_N +1 (which is 7) is passed as the argument "number" of the function  printStackFrames.
# By convention, edi holds the 1st 32-bit argument of a function call.
	call	printStackFrames 	# Calls the printStackFrames function with argument "number" set to 7.
	movq	-16(%rbp), %rax 	# Returns the value of the "accumulator" variable by copying it to rax (return value register).
	jmp	.L3 					# Jumps to L3 to terminate the program and free the stack.
.L2:
	movq	-8(%rbp), %rax 		# Moves the value of "n" to the rax register.
	imulq	-16(%rbp), %rax		# Multiplies "n" by the "accumulator" and stores the result in rax (returned value).
	movq	-8(%rbp), %rdx		# Copies the value of "n" into a new register rdx.
	subq	$1, %rdx			# Tubsitute 1 to "n" and stores n-1 in rdx.
	movq	%rax, %rsi			# The result of the last factorial call (in rax) is copied in rsi to be passed as the "accumulator" (2nd argument) of the next factorial call.
	movq	%rdx, %rdi			# "n-1" is copied in rdi to be passed as the "n" (1st argument) of the next factorial call.
	call	factorial			# Calls factorial recursively using the newly modified parameters "n" (in rdi) and "accumulator" (in rsi)
.L3:
	leave 						# Clean up the stack frame of the factorial sequence of calls subroutine. It moves the base pointer rbp to the stack pointer rsp.
# This effectively deallocates the stack frame by restoring the stack pointer to its value before the "enter" instruction was executed. And it pops the old
# base pointer rbp from the stack. This restores the previous base pointer, which was saved at the beginning of the subroutine.
	.cfi_def_cfa 7, 8
	ret 						# Pops the return address from the stack and jumps back to that address.
	.cfi_endproc
.LFE0:
	.size	factorial, .-factorial
	.section	.rodata
	.align 8
.LC0:
	.string	"executeFactorial: basePointer = %lx\n"
	.align 8
.LC1:
	.string	"executeFactorial: returnAddress = %lx\n"
	.align 8
.LC2:
	.string	"executeFactorial: about to call factorial which should print the stack\n"
	.align 8
.LC3:
	.string	"executeFactorial: factorial(%lu) = %lu\n"
	.text
	.globl	executeFactorial
	.type	executeFactorial, @function
executeFactorial:
.LFB1:
	.cfi_startproc
	pushq	%rbp				# Saves the caller's value for %rbp into the callee's stack (since %rbp is callee-saved,the callee must save it).
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp			# The base pointer is given the value of the current stack pointer.
	.cfi_def_cfa_register 6
	subq	$48, %rsp			# The stack pointer is decremented by 48 bytes to make room for the local variables.
	# All the space in memory between the stack pointer and the base pointer is the executeFactorial function's stack frame.
	movl	$0, %eax
	call	getBasePointer		# Calls getBasePointer to obtain the current base pointer.
	movq	%rax, -8(%rbp)		# Stores the current base pointer (memory address) returned by getBasePointer as an unsigned long 8 bytes below the current base pointer.
	movq	-8(%rbp), %rax		# Copies the current base pointer in the temporary register rax (the return value).
	movq	%rax, %rsi			# Copies the current base pointer in rsi (Passes the 2nd argument to the function printf)
	movl	$.LC0, %edi			# Copies the string "executeFactorial: basePointer = %lx\n" to edi (Passes the 1st argument to the function printf)
	movl	$0, %eax
	call	printf				# Prints out the string with the current base pointer (in rsi).
	movl	$0, %eax
	call	getReturnAddress 	# Calls getreturnAddress to obtain the executeFactorial's return address
	movq	%rax, -16(%rbp)	 	# Stores the return address in C unsigned long variable returnAddress (which is 16 bytes below the current base pointer)
	movq	-16(%rbp), %rax  	# Copies the return address in the temporary register rax (return value).
	movq	%rax, %rsi		 	# Copies the return address in rsi (Passes the 2nd argument to the function printf)
	movl	$.LC1, %edi		 	# Copies the string "executeFactorial: returnAddress = %lx\n" in edi (Passes the 1st argument to the function printf)
	movl	$0, %eax
	call	printf			 	# Calls printf function with the above string and unsigned long return address as arguments.
	movl	$.LC2, %edi
	call	puts
	movq	$0, -24(%rbp)	 	# Initializes the unsigned long C variable "result" which is assigned value 0l
	movq	$6, -32(%rbp)	 	# Initializes the unsigned long C variable "number" which is assigned the constant DEFAULT_VALUE_OF_N (which is 6)
	movq	$1, -40(%rbp)	 	# Initializes the unsigned long C variable "accumulator" which is assigned the value 1l
	movq	-40(%rbp), %rdx 
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi			# Passes "accumulator" the 2nd argument to the function factorial
	movq	%rax, %rdi			# Passes "number" the 1st argument to the function factorial
	call	factorial			# Calls factorial with accumulator = 1 and number = 6
	movq	%rax, -24(%rbp)		# Stores the value returned by factorial(6,1) into the C variable called "result"
	movq	-24(%rbp), %rdx		
	movq	-32(%rbp), %rax
	movq	%rax, %rsi			# Passes "number" the 2nd argument to the function printf
	movl	$.LC3, %edi			# Passes the string "executeFactorial: factorial(%lu) = %lu\n" the 1st argument to the function printf
	movl	$0, %eax
	call	printf				# Prints out : "executeFactorial: factorial(6) = 720"
	nop
	leave						# Clean up the stack frame subroutine. It moves the base pointer rbp to the stack pointer rsp.
# This effectively deallocates the stack frame by restoring the stack pointer to its value before the "enter" instruction was executed. And it pops the old
# base pointer rbp from the stack. This restores the previous base pointer, which was saved at the beginning of the subroutine.
	.cfi_def_cfa 7, 8
	ret							# Pops the return address from the stack and jumps back to that address.
	.cfi_endproc
.LFE1:
	.size	executeFactorial, .-executeFactorial
	.ident	"GCC: (GNU) 11.4.1 20230605 (Red Hat 11.4.1-2)"
	.section	.note.GNU-stack,"",@progbits

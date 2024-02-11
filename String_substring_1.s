//@ Subroutine String_substring_1: Provided a pointer to a string, and 2 integers n and m, 
//							  	   String_substring_1 will return the substring of that 
//@								   string starting from the nth index to the mth index.
//@ X0: Must point to the string
//@ X1: Must contain an integer n
//@ X2: Must contain an integer m
//@ LR: Must contain the return address
//@ All AAPCS required registers are preserved, r19-r30.
//@ X0 is not preserved.

	.data
	ptrString:	.quad 0	// Stores pointer of allocated string
	
	.global String_substring_1
	.text
	
String_substring_1:
	// preserving registers x19-x30 (AAPCS)
	str x19, [sp, #-16]!
	str x20, [sp, #-16]!
	str x21, [sp, #-16]!
	str x22, [sp, #-16]!
	str x23, [sp, #-16]!
	str x24, [sp, #-16]!
	str x25, [sp, #-16]!
	str x26, [sp, #-16]!
	str x27, [sp, #-16]!
	str x28, [sp, #-16]!
	str x29, [sp, #-16]!
	str x30, [sp, #-16]!
	mov x29, sp			// setting stack frame
	
	mov x24, x0			// copies string address to x24
	
	sub x19, x2, x1		// substring length = string length - top bound
	mov x25, x19		// making a copy in x25
	
	// storing parameters for malloc
	str x1, [sp, #-16]!
	str x2, [sp, #-16]!
	str x24, [sp, #-16]!
	str x25, [sp, #-16]!
	
	add x19, x19, #1	// x19 = x19 + 1 (for null terminator)
	mov x0, x19			// moves total bytes needed to x0 for malloc
	bl	malloc			// branch and link to function malloc
	
	ldr x21, =ptrString	// loads address of ptrString into x21
	str x0, [x21]		// stores address of allocated memory at ptrString
	
	// retrieving parameters after malloc
	ldr x25, [sp], #16
	ldr x24, [sp], #16
	ldr x2, [sp], #16
	ldr x1, [sp], #16
	
	ldr x19, =ptrString	// loads address of ptrString into x19
	ldr x19, [x19]		// loads address pointed to by ptrString into x19
	
	mov x23, #0			// initialized x21 (offset) to 0
	
loop:
	ldrb w22, [x24, x1]		// loads byte from string at index x1 
	strb w22, [x19, x23]	// stores byte into allocated memory address + offset
	
	add x1, x1, #1			// n = n + 1
	add x23, x23, #1		// offset = offset + 1
	
	cmp x23, x25			// compares substring length to x25
	blt loop				// if greater than 0, loop, else continue
	
endloop:
	ldr x0, =ptrString		// loads address of ptrString into X0
	ldr x0, [x0]			// loads address pointed to by ptrString into X0
	bl putstring
	
exit:
	// restoring preserved registers x19-x30 (AAPACS)
	ldr x30, [sp], #16
	ldr x29, [sp], #16
	ldr x28, [sp], #16
	ldr x27, [sp], #16
	ldr x26, [sp], #16
	ldr x25, [sp], #16
	ldr x24, [sp], #16
	ldr x23, [sp], #16
	ldr x22, [sp], #16
	ldr x21, [sp], #16
	ldr x20, [sp], #16
	ldr x19, [sp], #16
	
	ret	// returns to calling function
	
//@ Subroutine String_copy: Provided a pointer to a string, and 2 integers n and m, 
//							  	  String_copy will return the substring of that 
//@								   string starting from the nth index to the mth index.
//@ X0: Must point to the string
//@ X1: Must point to the address to be copied to
//@ LR: Must contain the return address
//@ All registers are preserved.

	.data
	.global String_copy
	.text
	
String_copy:
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
	
	mov x19, x0 		// copies address of first string into x19
	
	bl	String_length	// branch and link to function String_length, x0 now holds str len
	
	mov x20, #0			// initializing x20 (offset) to 0
	
loop:
	ldrb w21, [x19, x20]	// loads byte of string in x19 into w21 + offset
	strb w21, [x1, x20]		// stores byte into x1 + offset
	
	sub x0, x0, #1			// x0 = x0 - 1 (counter)
	add x20, x20, #1		// offset = offset + 1
	
	cmp x0, #0				// compares x0 to 0
	bne loop				// if not equal, branch to loop

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
	
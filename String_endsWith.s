//@ Subroutine String_endsWith: Provided a pointer to a string, an integers n, and a 
//@							  	pointer to another string, String_endsWith will determine
//@								whether the second string matches the end of the first 
//@								string. Prints TRUE or FALSE.
//@ X0: Must point to a string
//@ X1: Must point to a second (sub)string
//@ LR: Must contain the return address
//@ All AAPCS required registers are preserved, r19-r30.
//@ X0 is not preserved.

	.data
szTrue:		.asciz "TRUE"
szFalse:	.asciz "FALSE"
	
	.global String_endsWith
	.text
	
String_endsWith:
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
	
	mov x20, x0			// copies string address from x0 to x20
	mov x21, x1 		// copies string address from x1 to x21
	
	bl String_length	// branch and link to function string_Length
	mov x27, x0			// moves s1 string length to x27 
	
	mov x0, x1 			// moves substring address from x2 to x0 
	bl	String_length	// branch and link to function string_Length
	mov x28, x0 		// moves s2 string length to x28
	
	mov x19, x0 		// x19 will become the counter (string length of substring)
	
	sub x26, x27, x28	// x25 (offset for s1) = x27 - x28
	mov x25, #0			// x25 is offset for substring
	
mainLoop:
	ldrb w23, [x20, x26]	// gets a byte from the pointer + offset
	ldrb w24, [x21, x25]	// gets a byte from the pointer + offset

	cmp	w23, w24		// compares the two bytes
	bne false			// if w23 and w24 are not equal, branches to false
	
	add x26, x26, #1	// x21 = x21 + 1
	add x25, x25, #1	// x25 = x25 + 1
	
	sub x19, x19, #1	// x19 = x19 - 1
	cmp x19, #0			// compares x19 to 0
	beq true			// if equal, branches to true
	
	b	mainLoop		// unconditional branch to mainLoop
	
true:
	ldr x0, =szTrue
	bl	putstring
	b exit

false:
	ldr x0, =szFalse
	bl	putstring
	
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
	
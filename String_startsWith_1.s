//@ Subroutine String_startWith_1: Provided a pointer to a string, an integers n, and a
//@							  	    pointer to another string, String_startsWith_1 will 
//@									determine whether the second string matches the index
//@									pointed to by the first string. Prints TRUE or FALSE.
//@ X0: Must point to a string
//@ X1: Must contain an integer n
//@ X2: Must point to a second (sub)string
//@ LR: Must contain the return address
//@ All AAPCS required registers are preserved, r19-r30.
//@ X0 is not preserved.

	.data
szTrue:		.asciz "TRUE"
szFalse:	.asciz "FALSE"
	
	.global String_startsWith_1
	.text
	
String_startsWith_1:
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
	mov x21, x1 		// copies int in x1 to x21
	mov x22, x2 		// copies string address from x2 to x22
	
	mov x0, x2 			// moves substring address from x2 to x0 
	bl	String_length	// branch and link to function string_Length
	
	// maybe error check here
	
	mov x19, x0 		// x19 will become the counter (string length of substring)
	mov x25, #0			// x25 is offset for substring
	
mainLoop:
	ldrb w23, [x20, x21]	// gets a byte from the pointer + offset
	ldrb w24, [x22, x25]	// gets a byte from the pointer + offset

	cmp	w23, w24		// compares the two bytes
	bne false			// if w23 and w24 are not equal, branches to false
	
	add x21, x21, #1	// x21 = x21 + 1
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
	
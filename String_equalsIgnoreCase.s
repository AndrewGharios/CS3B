//@ Subroutine String_equalsIgnoreCase: Provided a pointer to two strings, String_equals 
//							  			will return whether or not the two strings are 
//							  			equal. TRUE or FALSE will be printed.
//@ X1: Must point to the first string 
//@ X2: Must point to the second string
//@ LR: Must contain the return address
//@ All AAPCS required registers are preserved, r19-r30.
//@ X0 is not preserved.

	.data
szTrue:		.asciz "TRUE"
szFalse:	.asciz "FALSE"
	
	.global String_equalsIgnoreCase
	.text
	
String_equalsIgnoreCase:
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
	mov x29, sp		// setting stack frame
	
	mov x19, #1			// sets counter (x19) to 1
	
	mov x0, x1			// moves string address in x1 (first string) to x0
	bl	String_length	// branch and link to function String_length
	mov x25, x0			// moves value in x0 (string length of s1) to x25
	
	mov x0, x2			// moves string address in x2 (second string) to x0
	bl	String_length	// branch and link to function String_length
	mov x26, x0			// moves value in x0 (string length of s2) to x26
	
	cmp x25, x26		// compares the two string lengths
	bne	false			// if the lengths are not equal, branches to false

	ldrb w21, [x1]		// gets a byte from the first string and loads it into w21
	
	cmp w21, #96		// compares w21 to 96 (ASCII value a)
	blt	cont			// if char is already uppercase, jump to cont

	sub w21, w21, #32	// else, turns the lowercase character uppercase
	
cont:
	ldrb w22, [x2]		// gets a byte from the second string and loads it into w22
	
	cmp w22, #96		// compares w22 to 96 (ASCII value a)
	blt	loop			// if char is already uppercase, jump to loop

	sub w22, w22, #32	// else, turns the lowercase character uppercase
	
loop:
	cmp w21, w22		// compares the two bytes
	bne false			// if w21 and w22 are not equal, branches to false
	
	ldrb w21, [x1], #1	// gets a byte from the pointer
	
	cmp w21, #96		// compares w21 to 96 (ASCII value a)
	blt	cont2			// if char is already uppercase, jump to cont

	sub w21, w21, #32	// else, turns the lowercase character uppercase
	
cont2:
	ldrb w22, [x2], #1	// gets a byte from the pointer
	
	cmp w22, #96		// compares w22 to 96 (ASCII value a)
	blt	cont3			// if char is already uppercase, jump to cont3

	sub w22, w22, #32	// else, turns the lowercase character uppercase
	
cont3:
	cmp x19, x25		// compares counter to string length
	beq true			// if equal, branches to true
	
	add x19, x19, #1	// increments counter by 1
	
	b loop

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
	
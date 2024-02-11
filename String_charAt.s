//@ Subroutine String_charAt: Provided a pointer to a string and a integer byte n, 
//@							  String_charAt will return the char at the nth index of the 
//@							  string.
//@ X0: Must point to a string
//@ X1: Must contain an integer
//@ LR: Must contain the return address
//@ All AAPCS required registers are preserved, r19-r30.
//@ X0 is not preserved.

	.data
	.global String_charAt
	.text
	
String_charAt:
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
	
	//mov x20, x0			// moving address of string to x20
	//bl	String_length	// branch and link to String_length
	
	//sub x0, x0, #1		// subtracting string length to set correct number of indices
	//cmp x0, x1		// comparing string length to index
	//blt err				// if string length is less than index, branch to error
	
	add x1, x1, #1		// x1 = x1 + 1
	mov x19, #0			// setting counter to 0
	
	//mov x0, x20
	ldrb w21, [x0]		// gets a byte from the string and loads it into w21
	
loop:
	cmp x19, x1 		// comparing counter to index
	beq	exitloop

	ldrb w21, [x0], #1	// gets a byte from the pointer
	add x19, x19, #1	// increments counter by 1

	b 	loop			// unconditional branch to loop
	
exitloop:
	mov x0, x21
	b	exit

err:
	mov x0, #1			// if the index was out of bounds, function returns int 1

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
	
// Andrew Gharios
// Lab 3:
// Purpose: 
// Date:

.global _start //Provides program starting address

	.data	// Data section
szX:	.asciz "10"	// c-string.. user inp
szY:	.asciz "15"	// c-string.. user inp
szSum:	.skip 21 	// empty string to store result
dbX:	.quad 0		// quad to hold int value of szX
dbY:	.quad 0		// quad to hold int value of szY
dbSum:	.quad 0		// quad to hold sum value of dbY+dbX
chCr:	.byte 10	// Carriage return byte
	.text
_start:
	//Converting szX to a 64-bit integer dbX
	ldr	x0,=szX		// load x0 with szX address
	bl	ascint64	// call ascint64 function
	ldr	x5,=dbX		// load x1 with dbX address
	str	x0,[x5]		// store value of x0 into address x5 is pointing to.	

	//Converting szY to a 64-bit integer dbY
	ldr	x0,=szY	// load x0 with szX address
	bl	ascint64	// call ascint64 function
	ldr	x6,=dbY		// load x1 with dbX address
	str	x0,[x6]		// store value of x0 into address x6 is pointing to.


	//Adding dbX and dbY into quad dbSum
	ldr x5,[x5]		// Load x5 with the value stored in x5 address.
	ldr x6,[x6] 	// Load x6 with the value stored in x6 address.
	ldr x3,=dbSum	// load x3 register with dbSum address.
	add x5,x5, x6	// [X5]dbX = [X5]dbX + [X6]dbY
	str x5,[x3]	 	// store value of x5 into address x3 is pointing to.

	//Convert dbSum from int to ASCII
	ldr x0,=dbSum	// x0 for int value to convert to ASCII
	ldr x0,[x0]		// x0=[dbSum]
	ldr x1,=szSum    // x1 for empty string that will be able to hold a ASCII value.
	bl int64asc		// call int64asc function

	//print
	ldr	x0,=szSum 	// x0 to print
	bl putstring	// call putstring function

	//use putch to print /n
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	// End of program parameters
	mov X0, #0  // 0 to return
	mov X8, #93 // Linux code 93 terminates
	svc 0	    // Call Linux to execute

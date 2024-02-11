// Programmer: Andrew Gharios
// Lab 2:
// Purpose: Write to display two strings and a carriage return
//     using putstring and putch.
// Date: 30 Aug 2023

	.data
szMsg1: 	.asciz "The sun shines bright."		// Storing strings
szMsg2:		.asciz "It was too wet to play."
chCr:		.byte 10				// Carriage return byte.

	.global _start 		// Program start address for Linux.
	.text
_start:			   		// Call start.

	ldr 	x0, =szMsg1	// print szMsg1
	bl	putstring	// Branch and Link to putstring

	ldr 	x0, =chCr	// print carriage return
	bl	putch		// Branch and Link to putch

	ldr 	x0, =szMsg2	// print szMsg2
	bl	putstring	// Branch and Link to putstring

	ldr 	x0, =chCr	// print carriage return
	bl	putch		// Branch and Link to putch

// End of program parameters
	mov X0, #0  // 0 to return
	mov X8, #93 // Linux code 93 terminates
	svc 0	    // Call Linux to execute

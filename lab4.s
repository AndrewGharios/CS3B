q// Andrew Gharios
// Lab 4:
// Purpose: Store 4 values into labels A,B,C,D and add them together printing the following formula: A + B + C + D = result 
// Date: 09/05/2023

.global _start //Provides program starting address

	.data	// Data section
	
dbA:	 .quad 100		   // quad to hold the value of A
dbB:	 .quad 10000	   // quad to hold the value of B
dbC:	 .quad 10000000	   // quad to hold the value of C
dbD:	 .quad 10000000000 // quad to hold the value of D
dbSum:	 .quad 0		   // quad to hold sum value of dbY+dbX
szA:	 .skip 21		   // Ascii storage for dbA
szB:	 .skip 21		   // Ascii storage for dbB
szC:	 .skip 21		   // Ascii storage for dbC
szD:	 .skip 21		   // Ascii storage for dbD
szSum:	 .skip 21 		   // empty string to store result
szPlus:	 .asciz " + "	   // label to store ascii for " + "
szEqual: .asciz " = "	   // label to store ascii for " = "
chCr:	 .byte 10		   // Carriage return byte
	.text
_start:
	// Accumulate dbA through dbD and convert to ASCII values. 
	//A
	LDR X0,=dbA     // point to dbAs address 
	LDR X0,[X0]		// Load X0 with value in dbA address.
	
	ADD X11,X11,X0 	// Add dbA to the accumulator in X11.
	
	LDR X1,=szA     // pointer to load converted Ascii value of dbA.
	BL	int64asc 	// int64asC[X0,[szA]]
	
	//B
	LDR X0,=dbB     // point to dbAs address 
	LDR X0,[X0]		// Load X0 with value in dbB address.
	
	ADD X11,X11,X0 	// Add dbA to the accumulator in X11.
	
	LDR X1,=szB     // pointer to load converted Ascii value of dbB.
	BL	int64asc 	// int64asC[X0,[szB]]
	
	//C
	LDR X0,=dbC     // point to dbAs address 
	LDR X0,[X0]		// Load X0 with value in dbC address.
	
	ADD X11,X11,X0 	// Add dbA to the accumulator in X11.
	
	LDR X1,=szC     // pointer to load converted Ascii value of dbC.
	BL	int64asc 	// int64asc[X0,[szC]]
	
	//D
	LDR X0,=dbD     // point to dbAs address 
	LDR X0,[X0]		// Load X0 with value in dbD address.
	
	ADD X11,X11,X0 	// Add dbA to the accumulator in X11.
	
	LDR X1,=szD     // pointer to load converted Ascii value of dbD.
	BL	int64asc 	// int64asC[X1,[szD]]
	
	//Convert accumulator X11 into AScii and store into szSum.
	ADD X0,X0,X11	// X0 = X0 + X11(accumulator)
	LDR X1,=szSum 	// Ascii pointer to store sum value.
	BL 	int64asc	// int64asc[X0,szSum].
	
	//print A + B + C + D = SUM
	ldr	x0,=szA		// Load X0 with szA
	bl putstring	// Call putstring function
	
	ldr x0,=szPlus 	// Load X0 with ascii "+"
	bl putstring	// Call putstring
	
	ldr x0,=szB 	// Load X0 with szB
	bl putstring	// Call putstring function
	
	ldr x0,=szPlus 	// Load X0 with ascii "+"
	bl putstring	// Call putstring
	
	ldr x0,=szC 	// Load X0 with szC
	bl putstring	// Call putstring function
	
	ldr x0,=szPlus 	// Load X0 with ascii "+"
	bl putstring	// Call putstring
	
	ldr x0,=szD 	// Load X0 with szD
	bl putstring	// Call putstring function
	
	ldr x0,=szEqual // Load X0 with ascii "="
	bl putstring	// Call putstring
	
	ldr x0,=szSum 	// Load X0 with sum value
	bl putstring	// Call putstring.

	//use putch to print '/n'
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	// End of program parameters
	mov X0, #0  // 0 to return
	mov X8, #93 // Linux code 93 terminates
	svc 0	    // Call Linux to execute

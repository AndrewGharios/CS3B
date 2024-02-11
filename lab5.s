// Andrew Gharios
// Lab 5:
// Purpose: Take user input from console of 4 values and store into labels A,B,C,D and add them together printing the following formula: A - B + C - D = result 
// Date: 09/08/2023

.global _start //Provides program starting address
	.equ	MAX_BYTES, 21 // sets MAX_BYTES to a constant of 21.
	.data	// Data section
dbA:	 .quad 0		    // quad to hold the value of A
dbB:	 .quad 0	  	 	// quad to hold the value of B
dbC:	 .quad 0	   	   // quad to hold the value of C
dbD:	 .quad 0 		   // quad to hold the value of D
szA:	 .skip 21		   // Ascii storage for dbA
szB:	 .skip 21		   // Ascii storage for dbB
szC:	 .skip 21		   // Ascii storage for dbC
szD:	 .skip 21		   // Ascii storage for dbD
szSum:	 .skip 21 		   // empty string to store result
szPlus:	 .asciz " + "	   // label to store ascii for " + "
szMinus: .asciz " - "	   // label to store ascii for " - "
szEqual: .asciz " = "	   // label to store ascii for " = "
chCr:	 .byte 10		   // Carriage return byte
	.text
_start:
	//get szA through szD from the keyboard
	LDR X0,=szA		 //loads x0 with szAs address.
	MOV X1,MAX_BYTES //loads x1 with constant MAX_BYTES(21).
	bl getstring 	 // branch and link to getstring function.
	
	LDR X0,=szB		 //loads x0 with szBs address.
	MOV X1,MAX_BYTES //loads x1 with constant MAX_BYTES(21).
	bl getstring 	 // branch and link to getstring function.
	
	LDR X0,=szC		 //loads x0 with szCs address.
	MOV X1,MAX_BYTES //loads x1 with constant MAX_BYTES(21).
	bl getstring 	 // branch and link to getstring function.
	
	LDR X0,=szD		 //loads x0 with szDs address.
	MOV X1,MAX_BYTES //loads x1 with constant MAX_BYTES(21).
	bl getstring 	 // branch and link to getstring function.
	
	// Convert szA through szD from Ascii to int64 for computations.
	LDR X0,=szA		 //loads x0 with szAs address.
	bl ascint64		 // call ascii to int64 function.
	LDR X1,=dbA 	 //loads x1 with dbAs address.
	STR X0,[X1] 	 //store returned value in X0 into address X1 is pointing to.
	
	LDR X0,=szB		 //loads x0 with szBs address.
	bl ascint64		 // call ascii to int64 function.
	LDR X1,=dbB 	 //loads x1 with dbBs address.
	STR X0,[X1] 	 //store returned value in X0 into address X1 is pointing to.
	
	LDR X0,=szC		 //loads x0 with szCs address.
	bl ascint64		 // call ascii to int64 function.
	LDR X1,=dbC 	 //loads x1 with dbCs address.
	STR X0,[X1] 	 //store returned value in X0 into address X1 is pointing to.
	
	LDR X0,=szD		 //loads x0 with szDs address.
	bl ascint64		 // call ascii to int64 function.
	LDR X1,=dbD 	 //loads x1 with dbDs address.
	STR X0,[X1] 	 //store returned value in X0 into address X1 is pointing to.
	
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
	
	SUB X11,X11,X0 	// Add dbA to the accumulator in X11.
	
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
	
	SUB X11,X11,X0 	// Add dbA to the accumulator in X11.
	
	LDR X1,=szD     // pointer to load converted Ascii value of dbD.
	BL	int64asc 	// int64asC[X1,[szD]]
	
	//Convert accumulator X11 into AScii and store into szSum.
	ADD X0,X0,X11	// X0 = X0 + X11(accumulator)
	LDR X1,=szSum 	// Ascii pointer to store sum value.
	BL 	int64asc	// int64asc[X0,szSum].
	
	//print A - B + C - D = SUM
	ldr	x0,=szA		// Load X0 with szA
	bl putstring	// Call putstring function
	
	ldr x0,=szMinus 	// Load X0 with ascii "-"
	bl putstring	// Call putstring
	
	ldr x0,=szB 	// Load X0 with szB
	bl putstring	// Call putstring function
	
	ldr x0,=szPlus 	// Load X0 with ascii "+"
	bl putstring	// Call putstring
	
	ldr x0,=szC 	// Load X0 with szC
	bl putstring	// Call putstring function
	
	ldr x0,=szMinus // Load X0 with ascii "-"
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

// Andrew Gharios
// Exam Lab-1:
// Purpose: Take user input from console of 2 values and store into labels x and y, then perform the following formula and print it: 2 * (x + 2y) = result
// Date: 9/19/2023

.global _start //Provides program starting address
	.equ	MAX_BYTES, 21 // sets MAX_BYTES to a constant of 21.
	.data	// Data section
	
dbX:	 	.quad 0		    	// quad to hold the value of X
dbY:	 	.quad 0	  	 		// quad to hold the value of Y
szX:	 	.skip 21		   	// Ascii storage for dbX
szY:	 	.skip 21		   	// Ascii storage for dbY
szSum:	 	.skip 21 		   	// empty ascii storage to store result
szTemp:  	.skip 21 		   	// empty ascii storage for printing.
chCr:	 	.byte 10		   	// Carriage return byte
szPlus:	 	.asciz " + "	   	// label to store ascii for " + "
szTimes: 	.asciz " * "	   	// label to store ascii for " - "
szEqual: 	.asciz " = "	   	// label to store ascii for " = "
szOpenp:  	.asciz "("        	// label to store ascii for "("
szClosep: 	.asciz ")"        	// label to store ascii for ")"
szSpace:  	.asciz " "			// label to store ascii for space " "
szTwo:		.asciz "2"			// label to store ascii for "2"
szPrompt1:	.asciz "Enter x: " 	// Ascii to prompt user input.
szPrompt2:	.asciz "Enter y: "	// Ascii to prompt user input.
szHeader: 	.asciz "Author: Andrew Gharios\nDate: 09/19/2023\nProgram: Exam 1\n\n" // Ascii label holding the class header.

	.text
_start:
	//Print class header.
	ldr x0,=szHeader // Loads x0 with szHeaders address.
	bl putstring 	 // Call putstring to print header.
	
	//get szX and szY from console(user input)
	ldr x0,=szPrompt1 //Load x0 with szPrompt1s address.
	bl putstring 	 //Calls putstring to output prompting user input.
	LDR X0,=szX		 //loads x0 with szAs address.
	MOV X1,MAX_BYTES //loads x1 with constant MAX_BYTES(21).
	bl getstring 	 // branch and link to getstring function.
	
	//Repeat for Y.
	ldr x0,=szPrompt2 //Load x0 with szPrompt2s address.
	bl putstring 	 //Calls putstring to output prompting user input.
	LDR X0,=szY		 //loads x0 with szBs address.
	MOV X1,MAX_BYTES //loads x1 with constant MAX_BYTES(21).
	bl getstring 	 // branch and link to getstring function.
	
	// Convert szX and szY from Ascii to int64 for computations.
	// Store converted values into dbX and dbY.
	LDR X0,=szX		 //loads x0 with szXs address.
	bl ascint64		 // call ascii to int64 function.
	LDR X1,=dbX 	 //loads x1 with dbXs address.
	STR X0,[X1] 	 //store returned value in X0 into address X1 is pointing to.
	
	LDR X0,=szY		 //loads x0 with szYs address.
	bl ascint64		 // call ascii to int64 function.
	LDR X1,=dbY 	 //loads x1 with dbYs address.
	STR X0,[X1] 	 //store returned value in X0 into address X1 is pointing to.
	
	// Compute 2 * (x + 2y)
	LDR X0,=dbY     // point to dbYs address 
	LDR X0,[X0]		// Load X0 with value in dbY address.
	ADD X11,X0,X0   // X11 = X0 + X0 equivelant to (y + y = 2y)
	
	// add x to 2y
	LDR X0,=dbX     // point to dbXs address 
	LDR X0,[X0]		// Load X0 with value in dbX address.
	ADD X11,X11,X0 	// Add dbx to the accumulator in X11.
	
	// Multiply (x + 2y) which is stored in X11 by adding it to itself and store in X0 to branch.
	ADD X0,X11,X11 // X0 = X11 + X11 equivelant to ( [(x+2y) + (x+2y)] = 2(x+2y)
	
	//Convert result from in64 into Ascii and store into szSum.	
	// Register already X0 pointing to int64 to be converted.
	LDR X1,=szSum 	// Ascii pointer to store sum value.
	BL 	int64asc	// int64asc[X0,szSum].
	
	//print 2 * ( X + 2 * Y) = SUM
	ldr x0,=szTwo   // Loads x0 with szTwo
	bl putstring	// Call putstring to print "2"
	
	ldr x0,=szTimes // Loads x0 with szTimes
	bl putstring	// Call putstring to print "*"
	
	ldr x0,=szOpenp // Loads x0 with szOpenp
	bl putstring	// Call putstring to print "("
	
	ldr	x0,=szX		// Load X0 with szA
	bl putstring	// Call putstring function
	
	ldr x0,=szPlus 	// Load X0 with ascii "+"
	bl putstring	// Call putstring
	
	ldr x0,=szTwo   // Loads x0 with szTwo
	bl putstring	// Call putstring to print "2"
	
	ldr x0,=szTimes // Loads x0 with szTimes
	bl putstring	// Call putstring to print "*"
	
	ldr x0,=szY 	// Load X0 with szB
	bl putstring	// Call putstring function
	
	ldr x0,=szClosep// Load X0 with szClosep
	bl putstring	// call putstring to print ")"
	
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

// Andrew Gharios
// Lab 8:
// Purpose: Prompt user for two quad inputs X and Y and display the largest of two.
// Possible outputs: X > Y , Y > X, or X == Y.

// Date: 9/22/2023

.global _start //Provides program starting address
	.equ	MAX_BYTES, 21 // sets MAX_BYTES to a constant of 21.
	.data	// Data section
dbX:	 	.quad 0		    	// Quad to hold the value of X
dbY:	 	.quad 0	  	 		// Quad to hold the value of Y
szX:	 	.skip 21		   	// Ascii storage for dbX
szY:	 	.skip 21		   	// Ascii storage for dbY
szSum:	 	.skip 21 		   	// Empty ascii storage to store result
szTemp:  	.skip 21 		   	// Empty ascii storage for printing.
chCr:	 	.byte 10		   	// Carriage return byte
szPlus:	 	.asciz " + "	   	// Label to store ascii for " + "
szPrompt1:	.asciz "Enter x: " 	// Ascii to prompt user input.
szPrompt2:	.asciz "Enter y: "	// Ascii to prompt user input.
szBiggerz:	.asciz "x > y : " 	// Ascii to represent output.
szSmallerz:	.asciz "y > x : " 	// Ascii to represent output.
szEqualz:	.asciz "x == y : "  // Ascii to represent output.
szBigger:	.asciz " > " 		// Ascii to represent bigger than sign " > ".
szEqual:	.asciz " == " 		// Ascii to represent equals sign " == ".

	.text
_start:
	//get szX and szY from console(user input)
	//Getting X:
	ldr x0,=szPrompt1 //Load x0 with szPrompt1s address.
	bl putstring 	 //Calls putstring to output prompting user input.
	LDR X0,=szX		 //loads x0 with szAs address.
	MOV X1,MAX_BYTES //loads x1 with constant MAX_BYTES(21).
	bl getstring 	 // branch and link to getstring function.
	
	//Repeat for Y:
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

	//Compare and output correct condition.
	LDR X3,=dbX		 //loads x3 with dbXs address.
	LDR X3,[X3]
	LDR X4,=dbY 	 //loads x4 with dbYs address.
	LDR X4,[X4]
	 
	CMP X3,X4		 // Compare X3 and X4
	
	B.LT elseSmaller // If X3 < X4, Branch to elseSmaller
	B.EQ elseEquals	 // If X3 == X4, Branch to elseEquals. 
	
	//If (x > y) Output: " x > y : [x] > [y]\n"
		ldr x0,=szBiggerz 	// Load X0 with szSmallers address.
		bl	putstring		// Branch & Link to putstring to output " y > x : "
		
		ldr x0,=szX			// Load X0 with szXs address.
		bl 	putstring		// Call putstring to output szX.
		
		ldr x0,=szBigger 	// Load X0 with szSmallers address.
		bl	putstring		// Branch & Link to putstring to output " > "
		
		ldr x0,=szY			// Load X0 with szYs address.
		bl 	putstring		// Call putstring to output szY.
		
		ldr x0,=chCr		// print carriage return
		bl	putch			// call putch fucntion
	
		B endIf		 		// Unconditional branch to end when done executing.
	
	//Else if(x < y) Output: " y > x : [y] > [x]\n"
	elseSmaller:
		ldr x0,=szSmallerz 	// Load X0 with szSmallers address.
		bl	putstring		// Branch & Link to putstring to output " y > x : "
		
		ldr x0,=szY			// Load X0 with szYs address.
		bl 	putstring		// Call putstring to output szY.
		
		ldr x0,=szBigger 	// Load X0 with szSmallers address.
		bl	putstring		// Branch & Link to putstring to output " > "
		
		ldr x0,=szX			// Load X0 with szXs address.
		bl 	putstring		// Call putstring to output szX.
		
		ldr x0,=chCr		// print carriage return
		bl	putch			// call putch fucntion
		
		B endIf				// Unconditional branch to end when done executing.
	//else(x == y) Output: "x == y : [x] == [y]\n"
	elseEquals:
		ldr x0,=szEqualz 	// Load X0 with szEqualzs address.
		bl	putstring		// Branch & Link to putstring to output " x == y : "
		
		ldr x0,=szX			// Load X0 with szXs address.
		bl 	putstring		// Call putstring to output szX.
		
		ldr x0,=szEqual 	// Load X0 with szEquals address.
		bl	putstring		// Branch & Link to putstring to output " == "
		
		ldr x0,=szY			// Load X0 with szYs address.
		bl 	putstring		// Call putstring to output szY.
		
		ldr x0,=chCr		// print carriage return
		bl	putch			// call putch fucntion to print "\n".
	
	//Jump label to exit condition clause after correct body is executed.
	endIf:

	//use putch to print '/n'
	ldr x0,=chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	// End of program parameters
	mov X0, #0  // 0 to return
	mov X8, #93 // Linux code 93 terminates
	svc 0	    // Call Linux to execute

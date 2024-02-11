// Andrew Gharios
// Lab 9:
// Purpose: Prompt user for 10 quad inputs, store them into an array and then output the result along with the sum of all the values inputted.

// Date: 9/27/2023

.global _start //Provides program starting address
	.equ	MAX_BYTES, 21 // sets MAX_BYTES to a constant of 21.
	.data	// Data section
dbAr:	 	.quad 0,0,0,0,0,0,0,0,0,0		// Quad Array to hold 10 quad values.
szTemp:  	.skip 21 		   				// Empty ascii storage for printing.
chCr:	 	.byte 10		   				// Carriage return byte
szPrompt:	.asciz "Enter an integer: " 	// Ascii to prompt user input.
szSpace:	.asciz " "						// Ascuu to hold a space.
szOutput:	.asciz "Values in array: "		// Ascii to hold output text.
szOutsum:	.asciz "Sum of all values: "	// Ascii to hold output text.	

	.text
_start:
	//get 10 integers from user input, convert them to ASCII, and store them into dbAr
	//for i = 0; i < 10; i++
	mov x13,#0		  // Load x13 with a 0 to initialize it.
	mov x11,#0 		  // Load X11 with a 0 to keep track of the index.
	mov x12,#0		  // Load X12 with a 0 to kepe track of sum.
	
	forLoop:		  //Loop label
	CMP x13,#10		  //Compare x0 with immediate 10.
	B.EQ loopEnd	  //Jump to end if i == 10.
	
	//Output prompt for user input.
	ldr x0,=szPrompt //Load x0 with szPrompt1s address.
	bl putstring 	  //Calls putstring to output prompting user input.
	LDR X0,=szTemp	  //loads x0 with szTemps address.
	MOV X1,MAX_BYTES  //loads x1 with constant MAX_BYTES(21).
	bl getstring 	  // branch and link to getstring function.
	
	LDR X0,=szTemp	  // loads x0 with szTemps address.
	bl ascint64		  // call ascii to int64 function.
	LDR X1,=dbAr 	  // loads x1 with dbArs base address.
	ADD X1,X1,X11	  // Increments base address with value of Index.
	STR X0,[X1] 	  // store returned value in X0 into address X1 is pointing to.
	
	ADD X12,X12,X0	  // Accumulate inputted value into X12.
	
	// i++ & index++
	ADD x13,x13,#1	 // Add 1 to the loop control value.
	ADD X11,X11,#8	 // Add 8 to Array Index.
	
	
	B forLoop		 // Jump back to beginning of loop unconditionally.
	
	loopEnd:		 // End of 1st loop.
	//use putch to print '/n' twice.
	ldr x0,=chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	//Loop again through the array to output every value stored.
	//for i = 0; i < 10; i++
	mov x13,#0		 // Load x13 with a 0 to initialize it.
	mov x11,#0 		 // Load X11 with a 0 to keep track of the index.
	
	ldr	x0,=szOutput // Load X0 with szOut
	bl putstring	 // Call putstring function
	
	forLoop2:		 //Loop label
	CMP x13,#10		 //Compare x0 with immediate 10.
	B.EQ loopEnd2	 //Jump to end if i == 10.
	
	
	// Convert and output integer at current index of dbAr.
	ldr x0,=dbAr	  // Load X0 with dbArs base addres.
	add x0,x0,x11     // Increment base address to correct index.
	ldr x0,[x0]
	ldr x1,=szTemp	  // Load X1 with szTemps address.
	bl int64asc		  // Branch to int64asc to convert quad at current index to ASCII.
	
	ldr	x0,=szTemp 	  // Load X0 with szTemp
	bl putstring	  // Call putstring function to output szTemps contents.
	ldr	x0,=szSpace	  // Load X0 with szSpace
	bl putstring	  // Call putstring function to output a space.
	
	// i++ & index++
	ADD x13,x13,#1	 // Add 1 to the loop control value.
	ADD X11,X11,#8	 // Add 8 to Array Index to move to the next element.
	
	B forLoop2		 // Jump back to beginning of loop unconditionally.
	
	loopEnd2:		 // End of 2nd loop.
	
	//use putch to print '/n' twice.
	ldr x0,=chCr	// print carriage return
	bl	putch		// call putch fucntion
	ldr x0,=chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	
	// Convert and Output Sum stored in x12.
	ldr	x0,=szOutsum // Load X0 with szOut
	bl putstring	 // Call putstring function
	
	MOV X0,X12		// Load X0 with value stored in x12(accumulator).
	LDR X1,=szTemp 	// Ascii pointer to store sum value.
	BL 	int64asc	// int64asc[X0,szTemp].

	// Convert and Output Sum stored in x12.
	ldr	x0,=szTemp // Load X0 with szTemp
	bl putstring	 // Call putstring function to output szTemps contents.

	//use putch to print '/n'
	ldr x0,=chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	// End of program parameters
	mov X0, #0  // 0 to return
	mov X8, #93 // Linux code 93 terminates
	svc 0	    // Call Linux to execute

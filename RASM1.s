// Andrew Gharios
// RASM-1:
// Purpose: Take user input from console of 4 values and store into labels A,B,C,D and add them together printing the following formula: (A + B) - (C + D) = result 
// Date: 9/14/2023

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
szSum:	 .skip 21 		   // empty ascii storage to store result
szTemp:  .skip 21 		   // empty ascii storage for printing.
chCr:	 .byte 10		   // Carriage return byte
szPlus:	 .asciz " + "	   // label to store ascii for " + "
szMinus: .asciz " - "	   // label to store ascii for " - "
szEqual: .asciz " = "	   // label to store ascii for " = "
szOpenp:  .asciz "("        // label to store ascii for "("
szClosep: .asciz ")"        // label to store ascii for ")"
szSpace:  .asciz " "		// label to store ascii for space " "
szAddrs:  .asciz "The addresses of the 4 ints: " // Ascii to output 4 addresses.
szPrompt: .asciz "Enter a whole number: " // Ascii to prompt user input.
//class Header
szHeader: 	.asciz "Name: Andrew Gharios" // Ascii label holding the class header.
szHeader1:	.asciz "Class: CS 3B"		  // Ascii label holding the class header.
szHeader2:  .asciz "Lab: RASM1"			  // Ascii label holding the class header.
szHeader3:  .asciz "Date: 9/14/2023"	  // Ascii label holding the class header.

	.text
_start:
	//Print class header.
	ldr x0,=szHeader // Loads x0 with szHeaders address.
	bl putstring 	 // Call putstring to print header.
	ldr x0, =chCr	 // print carriage return
	bl	putch		 // call putch function
	
	ldr x0,=szHeader1 // Loads x0 with szHeaders1 address.
	bl putstring 	  // Call putstring to print header.
	ldr x0, =chCr	  // print carriage return
	bl	putch		  // call putch function	
	
	ldr x0,=szHeader2 // Loads x0 with szHeaders2 address.
	bl putstring 	  // Call putstring to print header.
	ldr x0, =chCr	 // print carriage return
	bl	putch		 // call putch function
	
	ldr x0,=szHeader3 // Loads x0 with szHeaders3 address.
	bl putstring 	  // Call putstring to print header.
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch function
	ldr x0,=szSpace // Load x0 with szSpaces address.
	bl putstring	// call putstring to output a space and then print return carriage to make a new line.
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch function
	
	//get szA through szD from user input.
	ldr x0,=szPrompt //Load x0 with szPrompts address.
	bl putstring 	 //Calls putstring to output prompting user input.
	LDR X0,=szA		 //loads x0 with szAs address.
	MOV X1,MAX_BYTES //loads x1 with constant MAX_BYTES(21).
	bl getstring 	 // branch and link to getstring function.
	
	//B
	ldr x0,=szPrompt //Load x0 with szPrompts address.
	bl putstring 	 //Calls putstring to output prompting user input.
	LDR X0,=szB		 //loads x0 with szBs address.
	MOV X1,MAX_BYTES //loads x1 with constant MAX_BYTES(21).
	bl getstring 	 // branch and link to getstring function.
	
	//C
	ldr x0,=szPrompt //Load x0 with szPrompts address.
	bl putstring 	 //Calls putstring to output prompting user input.
	LDR X0,=szC		 //loads x0 with szCs address.
	MOV X1,MAX_BYTES //loads x1 with constant MAX_BYTES(21).
	bl getstring 	 // branch and link to getstring function.
	
	//D	
	ldr x0,=szPrompt //Load x0 with szPrompts address.
	bl putstring 	 //Calls putstring to output prompting user input.
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
	
	// Compute (A+B) - (C+D) 
	//A + B stored in X11
	LDR X0,=dbA     // point to dbAs address 
	LDR X0,[X0]		// Load X0 with value in dbA address.
	
	ADD X11,X11,X0 	// Add dbA to the accumulator in X11.
	
	LDR X0,=dbB     // point to dbAs address 
	LDR X0,[X0]		// Load X0 with value in dbB address.
	
	ADD X11,X11,X0 	// Add dbB to the accumulator in X11.
	
	//C + D stored in X12
	LDR X0,=dbC     // point to dbAs address 
	LDR X0,[X0]		// Load X0 with value in dbC address.
	
	ADD X12,X12,X0 	// Add dbC to the accumulator in X12.
	
	LDR X0,=dbD     // point to dbAs address 
	LDR X0,[X0]		// Load X0 with value in dbD address.
	
	ADD X12,X12,X0 	// Add dbD to the accumulator in X12.

	//Convert result into Ascii and store into szSum.	
	SUB X0,X11,X12  // X0 = X12 - X11 ->X0=(A+B)-(C+D)
	LDR X1,=szSum 	// Ascii pointer to store sum value.
	BL 	int64asc	// int64asc[X0,szSum].
	
	//print (A + B) - (C + D) = SUM
	ldr x0,=szOpenp // Loads x0 with szOpenp
	bl putstring	// Call putstring to print "("
	
	ldr	x0,=szA		// Load X0 with szA
	bl putstring	// Call putstring function
	
	ldr x0,=szPlus 	// Load X0 with ascii "+"
	bl putstring	// Call putstring
	
	ldr x0,=szB 	// Load X0 with szB
	bl putstring	// Call putstring function
	
	ldr x0,=szClosep// Load X0 with szClosep
	bl putstring	// call putstring to print ")"
	
	ldr x0,=szMinus 	// Load X0 with ascii "-"
	bl putstring	// Call putstring
	
	ldr x0,=szOpenp // Loads x0 with szOpenp
	bl putstring	// Call putstring to print "("
	
	ldr x0,=szC 	// Load X0 with szC
	bl putstring	// Call putstring function
	
	ldr x0,=szPlus 	// Load X0 with ascii "+"
	bl putstring	// Call putstring
	
	ldr x0,=szD 	// Load X0 with szD
	bl putstring	// Call putstring function\
	
	ldr x0,=szClosep// Load X0 with szClosep
	bl putstring	// call putstring to print ")"
	
	ldr x0,=szEqual // Load X0 with ascii "="
	bl putstring	// Call putstring
	
	ldr x0,=szSum 	// Load X0 with sum value
	bl putstring	// Call putstring.

	//use putch to print '/n'
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	//Make a new line by outputting a " \n"
	ldr x0,=szSpace // Load x0 with szSpaces address.
	bl putstring	// call putstring to output a space and then print return carriage to make a new line.
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch function
	
	//Print the addresses of the 4 ints A,B,C,D.
	ldr x0,=szAddrs // loads x0 with szAddrs address.
	bl putstring	// Outputs address formatting:
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	ldr x0,=dbA 	// load x0 with dbAs address.
	ldr x1,=szTemp  // load x1 with szTemps address.
	bl int64asc		// Convert address to ascii and store in szTemp.
	
	ldr x0,=szTemp  // load x0 with szTemps address.
	bl putstring	// print the address temporarily stored.
	ldr x0,=szSpace	// load x0 with szSpaces address.
	bl putstring	// call putstring to print a space.
	
	ldr x0,=dbB 	// load x0 with dbBs address.
	ldr x1,=szTemp  // load x1 with szTemps address.
	bl int64asc		// Convert address to ascii and store in szTemp.
	
	ldr x0,=szTemp  // load x0 with szTemps address.
	bl putstring	// print the address temporarily stored.
	ldr x0,=szSpace	// load x0 with szSpaces address.
	bl putstring	// call putstring to print a space.
	
	ldr x0,=dbC 	// load x0 with dbCs address.
	ldr x1,=szTemp  // load x1 with szTemps address.
	bl int64asc		// Convert address to ascii and store in szTemp.
	
	ldr x0,=szTemp  // load x0 with szTemps address.
	bl putstring	// print the address temporarily stored.
	ldr x0,=szSpace	// load x0 with szSpaces address.
	bl putstring	// call putstring to print a space.
	
	ldr x0,=dbD 	// load x0 with dbDs address.
	ldr x1,=szTemp  // load x1 with szTemps address.
	bl int64asc		// Convert address to ascii and store in szTemp.
	
	ldr x0,=szTemp  // load x0 with szTemps address.
	bl putstring	// print the address temporarily stored.
	
	//use putch to print '/n'
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	// End of program parameters
	mov X0, #0  // 0 to return
	mov X8, #93 // Linux code 93 terminates
	svc 0	    // Call Linux to execute

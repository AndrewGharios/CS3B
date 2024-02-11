// Andrew Gharios
// Exam Lab-2:
// Purpose: 
// Date: 11/16/2023

.global _start //Provides program starting address
	.equ	MAX_BYTES, 21 // sets MAX_BYTES to a constant of 21.
	.data	// Data section
	
str1Ptr:    .quad  0		// Head pointer
str2Ptr:    .quad  0		// Second pointer
szSum:	 	.skip 21 		   	// empty ascii storage to store result
dbLength:	.quad 0				// Storing lenght of string
szInputbuf: .skip 21		   	// empty ascii storage for printing.
chCr:	 	.byte 10		   	// Carriage return byte
szPrompt1:	.asciz "Enter String #1: " 	// Ascii to prompt user input.
szPrompt2:	.asciz "Enter String #2: "	// Ascii to prompt user input.
szDisp1:	.asciz "Displaying string #1: " 	// Ascii to prompt user input.
szDisp2:	.asciz "Displaying string #2: "	// Ascii to prompt user input.
szConvert:	.asciz "Converting to Upper Case ..."	// Convert string output

	.text
_start:
	//get string1 from user
	ldr x0,=szPrompt1 	//Load x0 with szPrompt1s address.
	bl putstring 	 	//Calls putstring to output prompting user input.
	LDR X0,=szInputbuf	//loads x0 with inputbuf address.
	MOV X1,MAX_BYTES 	//loads x1 with constant MAX_BYTES(21).
	bl getstring 	 	// branch and link to getstring function.
	
	//point str1Ptr to the mallocd copy of inputted string
	ldr x0,=szInputbuf	// Load x0 with szInputBuf
	bl String_length	// branch to string length
	ldr x1,=dbLength	// Load String length address into x1
	str x0,[x1]			// Store returned stringlen in x0 into x1s address
	bl malloc			// Branch to malloc to allocate heap memory for this string
	
	mov x11,#0			// Index for traversing the strings
	
loop:
	ldr x1,=szInputbuf	// Load x1 with copied string address
	ldrb w2,[x1,x11]	// Load byte in x1 + x11 offset into w2
	strb w2,[x0,x11]	// Store byte into new malloced space
	
	add x11,x11,#1		// Increment index
	
	ldr x12,=dbLength	// Load lengths address into x12
	ldr x12,[x12]		// Load value inside address of x12
	cmp x11,x12			// Compare index with strlength
	bne loop			// Jump back to 1stindex until full string has been copied
	
	ldr x1,=str1Ptr		// Load into x1 the address of str1Ptr
	str x0,[x1]			// Point pointer to new mallocd string addres
	
	//get string2 from user
	ldr x0,=szPrompt2  //Load x0 with szPrompt1s address.
	bl putstring 	   //Calls putstring to output prompting user input.
	LDR X0,=szInputbuf //loads x0 with inputbuf address.
	MOV X1,MAX_BYTES   //loads x1 with constant MAX_BYTES(21).
	bl getstring 	   // branch and link to getstring function.
	
		//point str1Ptr to the mallocd copy of inputted string
	ldr x0,=szInputbuf	// Load x0 with szInputBuf
	bl String_length	// branch to string length
	ldr x1,=dbLength	// Load String length address into x1
	str x0,[x1]			// Store returned stringlen in x0 into x1s address
	bl malloc			// Branch to malloc to allocate heap memory for this string
	
	mov x11,#0			// Index for traversing the strings
	
loop2:
	ldr x1,=szInputbuf	// Load x1 with copied string address
	ldrb w2,[x1,x11]	// Load byte in x1 + x11 offset into w2
	strb w2,[x0,x11]	// Store byte into new malloced space
	
	add x11,x11,#1		// Increment index
	
	ldr x12,=dbLength	// Load lengths address into x12
	ldr x12,[x12]		// Load value inside address of x12
	cmp x11,x12			// Compare index with strlength
	bne loop2			// Jump back to 1stindex until full string has been copied
	
	ldr x1,=str2Ptr		// load into x1 the address of str2Ptr
	str x0,[x1]			// store mallocd string address into x1
	
	//Print string 1
	ldr x0,=szDisp1		// Load x0 with szDisp prompt
	bl putstring		// branch to putstring
	
	ldr x0,=str1Ptr		// load x0 with str1Ptr address
	ldr x0,[x0]			// Point to mallocd address
	bl putstring		// branch to putstring

	//use putch to print '/n'
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	//Print string 2
	ldr x0,=szDisp2		// Load x0 with szDisp prompt
	bl putstring		// branch to putstring
	
	ldr x0,=str2Ptr		// load x0 with str1Ptr address
	ldr x0,[x0]			// Point to mallocd address
	bl putstring		// branch to putstring
	
	//use putch to print '/n'
	ldr x0, =chCr		// print carriage return
	bl	putch			// call putch fucntion
	//use putch to print '/n'
	ldr x0, =chCr		// print carriage return
	bl	putch			// call putch fucntion
	
	//Converts both strings to uppercase
	ldr x0,=szConvert	// Load x0 with szConvert prompt
	bl putstring		// branch to putstring
	
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	ldr x0,=szDisp1		// Load x0 with szDisp prompt
	bl putstring		// branch to putstring
	
	ldr x0,=str1Ptr		// load x0 with str1Ptr address
	ldr x0,[x0]			// Point to mallocd address
	bl String_toUpperCase		// branch to uppercase function
	bl putstring		// Branch to putstring
	bl free
	
	//use putch to print '/n'
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	//Print string 2
	ldr x0,=szDisp2		// Load x0 with szDisp prompt
	bl putstring		// branch to putstring
	
	ldr x0,=str2Ptr		// load x0 with str1Ptr address
	ldr x0,[x0]			// Point to mallocd address
	bl String_toUpperCase		// branch to uppercase function
	bl putstring		// branch to putstring.
	bl free
	
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	// Free pointers
	ldr x0,=str1Ptr		// load x0 with str1Ptr address
	ldr x0,[x0]			// Point to mallocd address
	bl free				// Branch to free mallocd space
	
	ldr x0,=str2Ptr		// load x0 with str1Ptr address
	ldr x0,[x0]			// Point to mallocd address
	bl free				// Branch to free mallocd space
	
	// End of program parameters
	mov X0, #0  // 0 to return
	mov X8, #93 // Linux code 93 terminates
	svc 0	    // Call Linux to execute
	
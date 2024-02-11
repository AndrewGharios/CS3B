//@ Subroutine String_concat: Provided two strings will merge the two given
//@							  into a concated single string and returns the address of it in X0.
//@ X0: Must point to a null terminated string
//@ X1: Must point to another null terminated string
//@ LR: Must contain the return address
//@ All AAPCS required registers are preserved, r19-r29 and SP.
//@ X0 is not preserved.

.data
ptrString: .quad 0			// Intialize label for concated string
szSpace:   .byte 32		// Initialize space byte
	.text
.global String_concat

String_concat: 
	// Preserving all AAPACS registers
	STR X19, [SP, #-16]!	// Storing contents of register onto stack.
	STR X20, [SP, #-16]!	// Storing contents of register onto stack.
	STR X21, [SP, #-16]!	// Storing contents of register onto stack.
	STR X22, [SP, #-16]!	// Storing contents of register onto stack.
	STR X23, [SP, #-16]!	// Storing contents of register onto stack.
	STR X24, [SP, #-16]!	// Storing contents of register onto stack.
	STR X25, [SP, #-16]!	// Storing contents of register onto stack.
	STR X26, [SP, #-16]!	// Storing contents of register onto stack.
	STR X27, [SP, #-16]!	// Storing contents of register onto stack.
	STR X28, [SP, #-16]!	// Storing contents of register onto stack.
	STR X29, [SP, #-16]!	// Storing contents of register onto stack.
	STR LR, [SP, #-16]!		// Storing contents of link register onto stack.
	MOV X29, SP 			// Stack frame
	
	//Loop initalization
	MOV X19,X0 				// Moves the string base address input to X19.
	BL String_length 		// Branch to String_length
	MOV X21,X0				// Copy the string length of given string to X21.
	
	MOV X20,X1 				// Moves the second strings base address input to X19.
	MOV X0,X1				// Copy address of second string into x0
	BL String_length 		// Branch to String_length
	MOV X22,X0				// Copy the string length of given string to X22.
	
	ADD X23,X21,X22			// Add length of both strings to X23.
	ADD X23,X23,#1			// Add 1 to length for space.
	
	//Malloc new string
	STR X19, [SP, #-16]!	// Store current registers onto stack to preserve.
	STR X20, [SP, #-16]!	// Store current registers onto stack to preserve.
	STR X21, [SP, #-16]!	// Store current registers onto stack to preserve.
	STR X22, [SP, #-16]!	// Store current registers onto stack to preserve.

	MOV X0, X23       // Moves string length of both combined strings with an extra space to X0
	BL malloc         // Calls function to malloc

	LDR X1, =ptrString // Loads ptrStrings address into X1
	STR X0,[X1]       // Point X1 to allocated space by malloc.

	// Restore registers
	LDR X22, [SP], #16		// Restores register from stack.
	LDR X21, [SP], #16		// Restores register from stack.
	LDR X20, [SP], #16		// Restores register from stack.
	LDR X19, [SP], #16		// Restores register from stack.

	// Loads address of the malloc string
	LDR X23, =ptrString		// Loads ptrStrings address into X23.
	LDR X23, [X23]			// Load value of X23s address into X23.
	
	MOV X24,#0				// Initalize index to traverse first string.
	MOV X25,#0				// Intialize index to traverse second string.
	MOV X26,#0				// Initialize index to traverse new concated string.
	
_loop:
		LDRB W27,[X19,X24]	// Load W27 with base address of first string + current index
		STRB W27,[X23,X26]	// Store byte in W27 into new strings base address + current index
		
		SUB X21,X21,#1		// Stringlen--
		ADD X24,X24,#1		// First string Index++
		ADD X26,x26,#1		// New string Index++
		
		CMP X21,#0			// Check if string length <= 0
		B.EQ _end1			// If the string length is 0 exit loop
		b _loop				// Branch back to loop
_end1:
		LDR X29,=szSpace	// Load x29 with szSpaces address
		LDRB W29,[X29]		// Load X29 with the byte in szSpace
		STRB W29,[X23,X26]	// Store that byte in the new string.
		ADD X26,X26,#1		// Add 1 to index of new string.
_loop2:
		LDRB W27,[X20,X25]	// Load W27 with base address of second string + current index
		STRB W27,[X23,X26]	// Store byte in W27 into new strings base address + current index
		
		SUB X22,X22,#1		// Stringlen--
		ADD X25,X25,#1		// Second string Index++
		ADD X26,x26,#1		// New string Index++
		
		CMP X22,#0			// Check if string length <= 0
		B.EQ _exit			// If the string length is 0 exit loop
		b _loop2			// Branch back to loop 
		
_exit:
	ldr x0,=ptrString		// Load X0 with ptrStrings address.
	ldr x0,[x0]				// Load new concated string into X0 to return.
	
//Restore preserved Registers.
	LDR LR,[SP],#16			// Restore Link register from stack.
	LDR X29,[SP],#16		// Restoring register from stack.
	LDR X28,[SP],#16		// Restoring register from stack.
	LDR X27,[SP],#16		// Restoring register from stack.
	LDR X26,[SP],#16		// Restoring register from stack.
	LDR X25,[SP],#16		// Restoring register from stack.
	LDR X24,[SP],#16		// Restoring register from stack.
	LDR X23,[SP],#16		// Restoring register from stack.
	LDR X22,[SP],#16		// Restoring register from stack.
	LDR X21,[SP],#16		// Restoring register from stack.
	LDR X20,[SP],#16		// Restoring register from stack.
	LDR X19,[SP],#16		// Restoring register from stack.
	
	RET
//@ Subroutine String_replace: Provided a string, a char to replace and a char to replace with,
//@							  this function will replace all occurences of char to replace with the char to replace with.
//@ X0: Must point to a null terminated string
//@ X1: Must point to char that is going to be replaced.
//@ X2: Must point to new char that will be replacing the old one.
//@ LR: Must contain the return address
//@ All AAPCS required registers are preserved, r19-r29 and SP.
//@ X0 is not preserved.

	.data
ptrString: .quad 0			// Intialize label for concated string
	
	.text
.global String_replace

String_replace: 
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
	MOV X23,X0				// Copy the string length of given string to X23.
	MOV X20,#0				// Initialize counter/index to 0
	
	LDRB W21,[X1]			// load W21 with char to change
	LDRB W22,[X2]			// load W24 with char to replace with

	STR X19, [SP, #-16]!	// Store current registers onto stack to preserve.
	STR X20, [SP, #-16]!	// Store current registers onto stack to preserve.
	STR X21, [SP, #-16]!	// Store current registers onto stack to preserve.
	STR X22, [SP, #-16]!	// Store current registers onto stack to preserve.

	MOV X0,X23       		// Moves string length of both combined strings with an extra space to X0
	BL malloc         		// Calls function to malloc

	LDR X1, =ptrString 		// Loads ptrStrings address into X1
	STR X0,[X1]       		// Point X1 to allocated space by malloc.

	// Restore registers
	LDR X22, [SP], #16		// Restores register from stack.
	LDR X21, [SP], #16		// Restores register from stack.
	LDR X20, [SP], #16		// Restores register from stack.
	LDR X19, [SP], #16		// Restores register from stack.

	// Loads address of the malloc string
	LDR X23, =ptrString		// Loads ptrStrings address into X23.
	LDR X23, [X23]			// Load value of X23s address into X23.

_loop:
		LDRB W25,[X19,X20]	// Load the next byte.
		
		CMP X25,X21			// Check if current byte needs to be changed
		B.EQ _change		// If the byte is found, branch to change it
		
		STRB W25,[X23,X20]	// Store current byte into new string
		
		ADD X20,X20,#1		// Index/Counter++

		CMP X25,#0			// Check if byte is null
		B.EQ _exit			// End function if entire string has been looped through
		b _loop				// Branch back to loop

_change:	
		STRB W22,[X23,X20]	// Replace old char with new one at current address.
		ADD X20,X20,#1		// Increment index
		b _loop				// Loop back to continue checking string

_exit:
	ldr x0,=ptrString		// Load X0 with ptrStrings address.
	ldr x0,[x0]				// Load new concated string into X0 to return.
	
//Restore preserved Registers.
	LDR LR,[SP],#16		// Restore Link register from stack.
	LDR X29,[SP],#16	// Restoring register from stack.
	LDR X28,[SP],#16	// Restoring register from stack.
	LDR X27,[SP],#16	// Restoring register from stack.
	LDR X26,[SP],#16	// Restoring register from stack.
	LDR X25,[SP],#16	// Restoring register from stack.
	LDR X24,[SP],#16	// Restoring register from stack.
	LDR X23,[SP],#16	// Restoring register from stack.
	LDR X22,[SP],#16	// Restoring register from stack.
	LDR X21,[SP],#16	// Restoring register from stack.
	LDR X20,[SP],#16	// Restoring register from stack.
	LDR X19,[SP],#16	// Restoring register from stack.
	
	RET

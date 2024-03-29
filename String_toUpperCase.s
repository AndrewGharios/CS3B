//@ Subroutine String_toUpperCase: Provided a string, this function will make the entire string lowercase
//@							  
//@ X0: Must point to a null terminated string
//@ LR: Must contain the return address
//@ All AAPCS required registers are preserved, r19-r29 and SP.
//@ X0 is not preserved.

	.data
ptrString: .quad 0			// Intialize label for concated string
	
	.text
.global String_toUpperCase

String_toUpperCase: 
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

	STR X19, [SP, #-16]!	// Store current registers onto stack to preserve.
	STR X20, [SP, #-16]!	// Store current registers onto stack to preserve.

	MOV X0,X23       		// Moves string length of both combined strings with an extra space to X0
	BL malloc         		// Calls function to malloc

	LDR X1, =ptrString 		// Loads ptrStrings address into X1
	STR X0,[X1]       		// Point X1 to allocated space by malloc.

	// Restore registers
	LDR X20, [SP], #16		// Restores register from stack.
	LDR X19, [SP], #16		// Restores register from stack.

	// Loads address of the malloc string
	LDR X23, =ptrString		// Loads ptrStrings address into X23.
	LDR X23, [X23]			// Load value of X23s address into X23.

_loop:
		LDRB W25,[X19,X20]	// Load the next byte.
		
		CMP X25,#0			// Check if byte is null
		B.EQ _exit			// End function if entire string has been looped through
		
		
		CMP	 W25, #122		// Compare current byte with Z
		B.PL _change		// Jump if char is > Z
		CMP	 W25, #'a'		// Compare current byte with A
		B.MI _change		// Jump if char is < A
		
		SUB W25,W25,#32		// Add 20 to byte to make it lowercase
		STRB W25,[X23,X20]	// Store current byte into new string
		ADD X20,X20,#1		// Index/Counter++
		
		b _loop				// Branch back to loop

_change:	
		STRB W25,[X23,X20]	// Replace old char with new one at current address.
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

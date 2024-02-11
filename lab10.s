// Andrew Gharios
// Lab10 :
// Purpose: Create a function that received a pointer to the address of a string
//			and must return the correct length of that string.

.text
.global String_length

String_length: 
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
	MOV X19,X0 		// Moves the string base address input to X19.
	MOV x0,#0		// Loads X0 with a null.
	MOV X20,#0		// Initalize counter
	LDRB W22,[X19]	// Loads the byte of the base address
	
_loop:
		CMP X22,#0	// Check if current byte is a null
		B.EQ _exit	// If the byte is null exit the loop.
		
		LDRB W22,[X19],#1	// Reload the next byte.
		ADD X20,X20,#1		// Counter++
		b _loop				// Branch back to loop till string is counted.
		
_exit:
		SUB X20,X20,#1		// Removes one from the counter to account for null.
		MOV X0,X20			// Moves the total length of the string into x0.
		
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
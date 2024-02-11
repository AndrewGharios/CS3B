//@ Subroutine String_lastIndexOf_1: Provided a character and a string, this function will 
//@							  return the last index of the specified character in given String.
//@ X0: Must point to a null terminated string
//@ X1: Must point to a char to find
//@ LR: Must contain the return address
//@ All AAPCS required registers are preserved, r19-r29 and SP.
//@ X0 is not preserved.

.text
.global String_lastIndexOf_1

String_lastIndexOf_1: 
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
	
	LDRB W20,[X1]			// Moves the char byte to find into W20.
	LDRB W22,[X19,X23]		// Loads the byte of the base address + string length
	
_loop:
		CMP X22,X20			// Check if current byte is a null
		B.EQ _exit			// If the byte is null exit the loop.
		
		LDRB W22,[X19,X23]	// Reload the next byte.
		SUB X23,X23,#1		// Stringlen--
		
		CMP X23,#0			// Check if string length is <=0
		B.EQ notFound
		
		b _loop				// Branch back to loop till string is counted.
		
notFound:
	MOV x0,#-1				// Move a -1 into x0.
	b end					// end of function
		
_exit:
	ADD X23,X23,#1		// X23++
	MOV X0,X23			// Moves the index of the char inside the given string into x0.

end:		
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
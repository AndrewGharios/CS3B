//@ Subroutine String_lastIndexOf_3: Provided two strings, this function will 
//@							  return the last ooccurence of the second string inside the first string.
//@ X0: Must point to a null terminated string
//@ X1: Must point to a a second null terminated string to findt
//@ LR: Must contain the return address
//@ All AAPCS required registers are preserved, r19-r29 and SP.
//@ X0 is not preserved.

.text
.global String_lastIndexOf_3

String_lastIndexOf_3: 
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
	
	MOV X20,X1				// Moves the string base address of second input into X20
	MOV X0,X1				// Copies the same string address to X0
	BL String_length 		// Branch to String_length
	MOV X24,X0				// Copy the string length of given string to X24.
	
	SUB X23,X23,#1
	SUB X24,X24,#1
	
	LDRB W25,[X20,X24]		// Moves the char byte to find into W25 + index
	LDRB W22,[X19,X23]		// Loads the byte of the base address + index
	
_loop:
		CMP X22,X25			// Check if current byte is a null
		B.EQ _exit			// If the byte is null exit the loop.
		
		SUB X23,X23,#1		// Stringlen--
		LDRB W22,[X19,X23]	// Reload the next byte.
		
_check:
		CMP X23,#0			// Check if string length is <=0
		B.EQ notFound
		b _loop				// Branch back to loop till string is counted.
		
notFound:
	MOV x0,#-1				// Move a -1 into x0.
	b end					// end of function

_exit:
		SUB X23,X23,#1		// Stringlen--
		SUB X24,X24,#1		// String2len--
	
		LDRB W22,[X19,X23]	// Reload the next byte.
		LDRB W25,[X20,X24]	// Reload the next byte.
		
		CMP X22,X25			// Check if current byte is the same
		B.NE _check			// If the byte is not the same exit the loop.
		
		CMP X23,#0			// Compare Stringlength with 0
		B.EQ notFound		// Jump to notFound if string length <=0
		
		CMP X24,#0			// Compare 2nd string length with 0
		B.EQ _exit2			// Exit loop if second string has been looped through
		
		b _exit				// Loop back to continue checking string
		
_exit2:
	MOV X0,X23				// Moves the index of the last occurence inside the given string into x0.

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
	
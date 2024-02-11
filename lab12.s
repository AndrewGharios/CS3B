// Andrew Gharios
// Lab12 :	
// Purpose: This is a function that will receive a int64 number and return the factorial of that number using recursion.
//			
// Pre-conditions:
// -X0: must contain a value >= 0
// -X0: value 'n' must be <= 20
// -LR: Contains the returns address
//
// Post-conditions:
// -X0: contains the factorial of integer input
// -ALL registers are preserved (except X0), AAPCS requirements are met

.text
.global _factorial
	
_factorial: 
	// preserving registers x19-x30 (AAPCS)
	str x19, [sp, #-16]!
	str x20, [sp, #-16]!
	str x21, [sp, #-16]!
	str x22, [sp, #-16]!
	str x23, [sp, #-16]!
	str x24, [sp, #-16]!
	str x25, [sp, #-16]!
	str x26, [sp, #-16]!
	str x27, [sp, #-16]!
	str x28, [sp, #-16]!
	str x29, [sp, #-16]!
	str x30, [sp, #-16]!
	mov x29, sp		// setting stack frameing.
	
	MOV x19,X0		// Store a copy of n
	
base_case:
	CMP X0,#0		// Compare x19 to 0
	B.EQ _exit		// Branch to exit if int == 0

	SUB X0,X0,#1	// n - 1
	bl _factorial	// branch to factorial
	
	MOV x1,X19		// Copy x19 into x1
	mul x0,x0,x1	// x0 = x0 * x1
	b _end			// exit function
		
_exit:
	MOV X0,#1	// Return 1

_end:	
	// restoring preserved registers x19-x30 (AAPACS)
	ldr x30, [sp], #16
	ldr x29, [sp], #16
	ldr x28, [sp], #16
	ldr x27, [sp], #16
	ldr x26, [sp], #16
	ldr x25, [sp], #16
	ldr x24, [sp], #16
	ldr x23, [sp], #16
	ldr x22, [sp], #16
	ldr x21, [sp], #16
	ldr x20, [sp], #16
	ldr x19, [sp], #16
	
	ret	// returns to calling function
	
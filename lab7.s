// Andrew Gharios
// Lab 7:
// Purpose: Load given data segment with the right values, store into approriate labels, then memory dump the labels as follows: 
//	bA:		155
//	chInit:	'j'
//	u16Hi:	88
//	wAlt:	.16, -1, -2
//	szMsg1:	"And Sally"
//	dbBig:	223372036854775807

// Date: 9/18/2023

.global _start //Provides program starting address

	.data	// Data section
//Given data segement
bA:		.skip 	1	
chInit:	.skip	1
u16Hi:	.hword	0
wAlt:	.word	0, 0, 0
szMsg1:	.skip	10
dbBig:	.quad	0
//End of given data segment.


szTemp:	.skip	21	//temporary storage to store converted int to ascii values.
chCr:	.byte	10	// Carriage return byte

//Hard coded asciz labels for outpout.
szLine1:	.asciz "bA = "			// hardcoded ascii text for output.
szLine3:	.asciz "chInit = "		// hardcoded ascii text for output.
szLine4:	.asciz "u16Hi = "		// hardcoded ascii text for output.	
szLine6:	.asciz "wAlt[0] = "		// hardcoded ascii text for output.
szLine7:	.asciz "wAlt[1] = "		// hardcoded ascii text for output.
szLine8:	.asciz "wAlt[2] = "		// hardcoded ascii text for output.
szLine9: 	.asciz "szMsg1 = "		// hardcoded ascii text for output.
szLine10: 	.asciz "dbBig = "		// hardcoded ascii text for output.

	.text
_start:
	//Store the given values into data segment.
	//Load bA with byte 155.
	ldr x0,=bA		// Load address of bA into X0
	mov x1,#155		// Moves 155 into x1.
	STRB w1,[x0]	// Stores byte 155 into address x0 is pointing to.
	
	//Load chInit wity byte 106 equivelant to "j".
	ldr x0,=chInit	// Load address of chInit into x0.
	mov w1,#106     // Moves 106 into w1.	
	STRB w1,[x0]	// Stores byte 155 into address x0 is pointing to.
	
	//Load half-word u16Hi with 88.
	ldr x0,=u16Hi 	// Load address of u16Hi into x0
	mov w1,#88		// Moves 88 into w1.
	strh w1,[x0]	// Stores 2 bytes from w1 into x0.
	
	//Load wAlt[0] with 16.
	ldr x0,=wAlt	// Load address of wAlt into x0.
	mov w1,#16		// Moves 16 into w1.
	str w1,[x0]		// stores contents of x1 into w0.
	
	//Load wAlt[1] with -1.
	ldr x0,=wAlt	// Load address of wAlt into x0.
	add x0,x0,#4	// Add 4 to base address to get to wAlt[2]
	mov w1,#-1		// Moves -1 into w1.
	str w1,[x0]		// stores contents of x1 into w0.
	
	//Load wAlt[2] with -2.
	ldr x0,=wAlt	// Load address of wAlt into x0.
	add x0,x0,#8	// Add 8 to base address to get to wAlt[2]
	mov w1,#-2		// Moves -2 into w1. 
	str w1,[x0]		// stores contents of x1 into w0.
	
	//Load szMsg1 with appropriate ascii bytes to represent c-string "And Sally\n"
	//Ascii hex value of message: 41 6e /64 20/	53 61 /6c 6c /79 00
	ldr x0,=szMsg1	// Load address of szMsg1 into x0.
	mov x1,#65		// Move decimal 65 into x1 which is the ASCII equiv. to A
	strb w1,[x0]	// Store byte in w1 into x0.
	
	ldr x0,=szMsg1	// Load address of szMsg1 into x0.
	add x0,x0,#1	// Add 1 byte to base address to move to appropriate index of c-string.
	mov x1,#110		// Move decimal 110 into x1 which is the ASCII equiv. to n
	strb w1,[x0]	// Store byte in w1 into x0.
	
	ldr x0,=szMsg1	// Load address of szMsg1 into x0.
	add x0,x0,#2	// Add 2 bytes to base address to move to appropriate index of c-string.
	mov x1,#100		// Move decimal 100 into x1 which is the ASCII equiv. to d
	strb w1,[x0]	// Store byte in w1 into x0.
	
	ldr x0,=szMsg1	// Load address of szMsg1 into x0.
	add x0,x0,#3	// Add 3 bytes to base address to move to appropriate index of c-string.
	mov x1,#32		// Move decimal 32 into x1 which is the ASCII equiv. to a space(" ")
	strb w1,[x0]	// Store byte in w1 into x0.
	
	ldr x0,=szMsg1	// Load address of szMsg1 into x0.
	add x0,x0,#4	// Add 4 bytes to base address to move to appropriate index of c-string.
	mov x1,#83		// Move decimal 83 into x1 which is the ASCII equiv. to S
	strb w1,[x0]	// Store byte in w1 into x0.
	
	ldr x0,=szMsg1	// Load address of szMsg1 into x0.
	add x0,x0,#5	// Add 5 bytes to base address to move to appropriate index of c-string.
	mov x1,#97		// Move decimal 97 into x1 which is the ASCII equiv. to a
	strb w1,[x0]	// Store byte in w1 into x0.
	
	ldr x0,=szMsg1	// Load address of szMsg1 into x0.
	add x0,x0,#6	// Add 6 bytes to base address to move to appropriate index of c-string.
	mov x1,#108		// Move decimal 108 into x1 which is the ASCII equiv. to l
	strb w1,[x0]	// Store byte in w1 into x0.
	
	ldr x0,=szMsg1	// Load address of szMsg1 into x0.
	add x0,x0,#7	// Add 7 bytes to base address to move to appropriate index of c-string.
	mov x1,#108		// Move decimal 108 into x1 which is the ASCII equiv. to l
	strb w1,[x0]	// Store byte in w1 into x0.
	
	ldr x0,=szMsg1	// Load address of szMsg1 into x0.
	add x0,x0,#8	// Add 8 bytes to base address to move to appropriate index of c-string.
	mov x1,#121		// Move decimal 121 into x1 which is the ASCII equiv. to y
	strb w1,[x0]	// Store byte in w1 into x0.
	
	ldr x0,=szMsg1	// Load address of szMsg1 into x0.
	add x0,x0,#9	// Add 9 bytes to base address to move to appropriate index of c-string.
	mov x1,#0		// Move decimal 0 into x1 which is the ASCII equiv. to NULL(\n)
	strb w1,[x0]	// Store byte in w1 into x0.
	
	//Load dbBig with given quad.
	ldr x0,=dbBig	// Load address of dbBig into x0.
	mov x1,#9223372036854775807		// Loads x1 with the given quad.
	str x1,[x0]		// Store contents of x1 into x0.
	
	//Memory dump of all Labels in data segment.
	//bA 
	ldr x0,=szLine1 // Hardcoded ascii output.
	bl putstring	// call putstring.
	
	ldr x0,=bA		// Load address of bA into X0
	ldrb w0,[x0]	// Load the byte from address bA into w0 to convert o ascii.
	ldr x1,=szTemp	// Load x1 with szTemps address.
	bl int64asc		// Call int64asc to convert bA to ascii.
		
	ldr x0,=szTemp	// Load x0 with szTemps address.
	bl putstring	// Display temporarily stored value.
	
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	//chInit
	ldr x0,=szLine3 // Hardcoded ascii output.
	bl putstring
	
	ldr x0, =chInit	// Load address of chInit into x0.
	bl 	putch 		// call putch to print chInit.
	
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	//u16Hi
	ldr x0,=szLine4 // Hardcoded ascii output.
	bl putstring	// call putstring.
	
	ldr x0, =u16Hi  // Load u16His address into x0
	ldrh w0,[x0] 	// Load w0 with the contents of address in x0.
	ldr x1, =szTemp // x1 with address pointing to szTemp.
	bl int64asc 	// Call int64asc to convert u16Hi to ascii.
	
	ldr x0, =szTemp // Load x0 with szTemps address
	bl putstring	// Print converted ascii of u16Hi. 
	
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	//wAlt[0]
	ldr x0,=szLine6 // Hardcoded ascii output.
	bl putstring
	
	ldr x0,=wAlt	// Load wAlts base address into x0.
	ldrh w0,[x0] 	// Load w0 with the contents of address in x0.
	ldr x1,=szTemp  // temporarily store converted ascii into szTemp.
	bl int64asc		// Convert into ascii by calling int64asc.
	
	ldr x0,=szTemp 	// Reload szTemps address into x0.
	bl 	putstring	// Print temporarily stored value by calling putstring.
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
		//wAlt[1]
	ldr x0,=szLine7	// Hardcoded ascii output.
	bl putstring	// call putstring
	
	ldr x1,=wAlt	// Load wAlts base address into x0.
	ADD x1,x1,#4 	// Add 4 to the base address to reach the address of wAlt[1].
	ldrsw x0,[x1]	// Load signed word from x1s address into x0
	
	ldr x1,=szTemp  // temporarily store converted ascii into szTemp.
	bl int64asc		// Convert into ascii by calling int64asc.
	
	ldr x0,=szTemp 	// Reload szTemps address into x0.
	bl 	putstring	// Print temporarily stored value by calling putstring.
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	//wAlt[2]
	ldr x0,=szLine8 // Hardcoded ascii output.
	bl putstring	// call putstring
	
	ldr x0,=wAlt	// Load wAlts base address into x0.
	ADD x0,x0,#8 	// Add 8 to the base address to reach the address of wAlt[2].
	ldrsw x0,[x0] 	// Load w0 with the contents of address in x0.
	ldr x1,=szTemp  // temporarily store converted ascii into szTemp.
	bl int64asc		// Convert into ascii by calling int64asc.
	
	ldr x0,=szTemp 	// Reload szTemps address into x0.
	bl 	putstring	// Print temporarily stored value by calling putstring.
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	//szMsg1 asciz
	ldr x0,=szLine9 // Print "szMsg1 = "
	bl putstring	// call putstring 
	ldr x0,=szMsg1	//load x0 with address for szMsg1 asciz.
	bl putstring	//call putstring since its already an asciz value.
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	//dbBig quad
	ldr x0,=szLine10 // Print "dbBig = "
	bl putstring	 // call putstring.
	
	ldr x0,=dbBig	// Load x0 with address of dbBig.
	ldr x0,[x0]		// Load x0 with value inside of dbBigs address.
	ldr x1,=szTemp  // Load x1 with address of szTemp
	bl int64asc	    // Converts value of x0 from int64 to ascii and stores it in address x1 is pointing to.
	
	ldr x0,=szTemp // Label temporarily holding dbBigs ascii converted value.
	bl putstring   // call putstring to print szTemp.
	

	//use putch to print '/n'
	ldr x0,=chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	// End of program parameters
	mov X0, #0  // 0 to return
	mov X8, #93 // Linux code 93 terminates
	svc 0	    // Call Linux to execute

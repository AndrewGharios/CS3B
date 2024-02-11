// Andrew Gharios
// Lab 6:
// Purpose: Load and display given data table from memory. 

// Date: 9/12/2023

.global _start //Provides program starting address

	.data	// Data section
//Data segment given by professor
bA:		.byte	155
bFlag:	.byte	1
chInit:	.byte	'j'
u16Hi:	.hword	88
u16Lo:	.hword	45
wAlt:	.word	16, -1, -2
szMsg1:	.asciz	"And Sally and I"
dbBig:	.quad	9223372036854775807

szTemp:	.skip	21	//temporary storage to store converted int to ascii values.
chCr:	.byte	10	// Carriage return byte

//Hard coded asciz labels for outpout.
szLine1:	.asciz "bA = "			// hardcoded ascii text for output.
szLine2:	.asciz "bFlag = "		// hardcoded ascii text for output.
szLine3:	.asciz "chInit = "		// hardcoded ascii text for output.
szLine4:	.asciz "u16Hi = "		// hardcoded ascii text for output.
szLine5: 	.asciz "u16Lo = "		// hardcoded ascii text for output.	
szLine6:	.asciz "wAlt[0] = "		// hardcoded ascii text for output.
szLine7:	.asciz "wAlt[1] = "		// hardcoded ascii text for output.
szLine8:	.asciz "wAlt[2] = "		// hardcoded ascii text for output.
szLine9: 	.asciz "szMsg1 = "		// hardcoded ascii text for output.
szLine10: 	.asciz "dbBig = "		// hardcoded ascii text for output.

	.text
_start:
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
	
	//bFlag
	ldr x0,=szLine2 // Hardcoded ascii output.
	bl putstring	// call putstring
	
	ldr x0,=bFlag	// Load the address of bFlag into x0.
	ldrb w0,[x0]	// Load the byte from address bFlag into w0 to convert o ascii.
	ldr x1,=szTemp	// Load x1 with szTemps address.
	bl int64asc		// Call int64asc to convert bFlag to ascii.
		
	
	ldr x0,=szTemp	// Load x0 with szTemps address.
	bl putstring	// Call putstring to print bFlag as ascii.
	
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	//chInit
	ldr x0,=szLine3 // Hardcoded ascii output.
	bl putstring
	
	ldr x0, =chInit	// Load address of chInit into x0.
	bl 	putch 		// call putch to print chInit.
	
	ldr x0, =chCr	// print carriage return
	bl	putch		// call putch fucntion
	
	//CHECK FOR LDRH
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
	
	//CHECK FOR LDRH
	//u16Lo
	ldr x0,=szLine5 // Hardcoded ascii output.
	bl putstring
	ldr x0, =u16Lo  // Load u16Los address into x0
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
	ldr w0,[x0] 	// Load w0 with the contents of address in x0.
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

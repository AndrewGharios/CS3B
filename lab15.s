// Andrew Gharios
// Lab14 :	
// Purpose: This program will open text file "output.txt", read its contents
//		    then display the contents on the console.
// 

.equ O_RDONLY, 0	// Read only code
.equ O_WRONLY, 1	// Write only code
.equ O_CREAT,  0100	// Create & read code
.equ S_RDWR,   0660 // chmod permissions
.equ AT_FDCWD, -100	// local directory (file descriptor)
.equ NR_openat, 56  // Openat code
.equ NR_close,	57	// close code
.equ NR_write,	64	// writing code
.equ NR_read,	63	// writing code
.equ NR_exit,	93	// exit code

	.data // Data section
dbAr:	.quad 0,0,0,0,0			// Quad Array to hold 5 quad values.
szFile: .asciz "input.txt"		// c-string of files name
iFD:	.byte 0					// byte to store file 
fileBuf:	.skip	512					// File buffer
//Error handling strings
szEOF:		.asciz	"Reached the End of File\n"
szERROR:	.asciz	"FILE READ ERROR\n"

.global _start
.text

_start: 
	// Open output.txt for writing
	mov x0, #AT_FDCWD // mov into x0 local directory code
	ldr x1, =szFile	  // Load x1 with file name address
	mov x2, #O_CREAT  // mov into x2 create if doesnt exist code
	mov x3,	#S_RDWR	  // mov into x3 RW permission
	mov x8,#NR_openat // mov into x8 open at code
	svc 0 			  // Open file for read only access

	ldr x1,=iFD		  // Load iFds address into x1
	strb w0,[x1]	  // Save returned file directory in iFD

	// Initialize loop to store into array
	mov x13,#0		  // Load x13 with a 0 to initialize it.
	mov x11,#0 		  // Load X11 with a 0 to keep track of the array index.
	
	//for(i = 0; i <= 5; i++): read from file and store in arr
forLoop:		  	  //Loop label
	CMP x13,#6		  //Compare x0 with immediate 5.
	B.EQ loopEnd	  //Jump to end if i == 5.
	
	// Read from output.txt
	ldr x1, =fileBuf	// load fileBufs address into x1
	bl getline			// branch and link to getline
	cmp x0,#0			// compare returned byte with 0
	beq loopEnd			// Jump to end
	
	ldr x0, =fileBuf	// load fileBufs address into x0
	bl ascint64		  	// call ascii to int64 function.
	LDR X1,=dbAr 	  	// loads x1 with dbArs base address.
	ADD X1,X1,X11	  	// Increments base address with value of Index.
	STR X0,[X1] 	  	// store returned value in X0 into address X1 is pointing to.
	
	// i++ & index++
	ADD x13,x13,#1	  // Add 1 to the loop control value.
	ADD X11,X11,#8	  // Add 8 to Array Index.
	
	ldr x0, =iFD		// Load iFDs address into x0
	ldrb w0, [x0]		// Reload the File descriptor byte into w0
	
	B forLoop		  // Jump back to beginning of loop unconditionally.
	
loopEnd:		 	  // End of 1st loop.
// Close output.txt	
	ldr x0,=iFD		  // Load x0 with iFDs address
	ldrb w0,[x0]	  // Load byte in address of x0 in w0.
	mov x8, #NR_close // mov into x8 exit code
	svc 0			  // Close the file

// End of program parameters
	mov X0, #0  	  // 0 to return
	mov X8, #NR_exit  // Linux code to terminate
	svc 0	    	  // Call Linux to execute

//**GETCHAR**//	
getchar:
	mov x2, #1		// mov 1 into x2
	mov x8, #NR_read // read
	svc 0			// does the lr change
	RET				// Return char
	
//**GETLINE**//
getline:
	str x30, [sp, #-16]!	// Store the LR onto the stack
	
top:
	bl getchar		// Branch to getchar
	ldrb w2,[x1]	// load byte in x1 into w2
	
	cmp w2, #0x0a	// Is char LF?
	beq EOLINE		// branch to end of line
	
	cmp w0, #0x0	// nothing read from file
	beq EOF			// branch to end of line
	
	cmp w0, #0x0	// compare byte with 0x0
	blt ERROR		// branch to error
	
	add x1, x1, #1	// increment x1
	
	ldr x0, =iFD	// Load iFDs address into x0
	ldrb w0, [x0]	// Reload the File descriptor byte into w0
	b top			// branch to top

EOLINE:
	mov w2, #0		// store null at the end of fileBuf replacing the lineFeed
	strb w2, [x1]	// store w2 into x1
	b skip			// branch to skip
	
EOF:
	add x1,x1,#1	// increment x1
	mov w2, #0		// store null at the end of fileBuf replacing the lineFeed
	strb w2, [x1]	// store w2 into x1	
	//ldr x0, =szEOF	// Load szEOFs address into x0
	b skip			// branch to skip
	
ERROR:
	mov x0, x19			// copy x19 back into x0
	ldr x0, =szERROR	// load x0 with szErrors address
	bl putstring		// Output error string
	mov x0, x19			// copy x19 back into x0
	b skip				// branch to skip
	
skip:
	ldr x30, [sp], #16	// reload LR from stack
	RET					// return getline
	
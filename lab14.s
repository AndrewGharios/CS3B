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
szFile: 	.asciz "output.txt"			// c-string of files name
iFD:		.byte 0						// byte to store file 
iSp:		.byte 10					// byte for space
fileBuf:	.skip	512					// File buffer
szEOF:		.asciz	"Reached the End of File\n"
szERROR:	.asciz	"FILE READ ERROR\n"


.global _start
.text

_start: 

// Open output.txt for writing
	mov x0, #AT_FDCWD	 // mov into x0 local directory code
	ldr x1, =szFile		 // Load x1 with file name address
	mov x2, #O_CREAT	 // mov into x2 create if doesnt exist code
	mov x3,	#S_RDWR		 // mov into x3 RW permission
	mov x8, #NR_openat   // mov into x8 open at code
	svc 0 				 // Open file for read only access

	ldr x1,=iFD			 // Load iFds address into x1
	strb w0,[x1]		 // Save returned file directory in iFD


//Initialize main loop
	mov x11,#0			// Initialize X11 as a counter with 0
	
top1:
	ldr x1, =fileBuf	// load fileBufs address into x1
	bl getline			// branch and link to getline
	cmp x0,#0			// compare returned byte with 0
	beq last			// Jump to last 
	
	ldr x0, =fileBuf	// load fileBufs address into x0
	bl putstring		// output filebuf
	
	cmp x11,#0			// Compare X11 with 0
	beq newLine			// Jump to newLine and add a newline to the buffer
	
back:
	ldr x0, =iFD		// Load iFDs address into x0
	ldrb w0, [x0]		// Reload the File descriptor byte into w0
	
	add x11,x11,#1		// Increment x11
	
	b	top1			// branch to top1
	
last:
// Close output.txt	
	ldr x0,=iFD			 // Load x0 with iFDs address
	ldrb w0,[x0]		 // Load byte in address of x0 in w0.
	mov x8, #NR_close 	 // mov into x8 exit code
	svc 0				 // Close the file

//**EXIT**//
exit:
	mov x0, #0			// Use 0 return code
	mov x8, #NR_exit	// Service command code 93 terminates program
	svc 0				// Call linux to terminate the program

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
	
	cmp w2, #0xa	// Is char LF?
	beq EOLINE		// branch to end of line
	
	cmp w0, #0x0	// nothing read from file
	beq EOF			// branch to end of line
	
	cmp w0, #0x0	// compare byte with 0x0
	blt ERROR		// branch to error
	
	add x1, x1, #1	// increment x1
	
	ldr x0, =iFD	// Load iFDs address into x0
	ldrb w0, [x0]	// Reload the File descriptor byte into w0
	b top			// branch to top

newLine:
	ldr x0,=iSp		// Load x0 with space address
	bl putch		// print space character
	b back			// branch back to main loop to output string with space

EOLINE:
	add x1, x1, #1	// make fileBuf into c-string
	mov w2, #0		// store null at the end of fileBuf (i.e. "Cat in the hat.\0"
	strb w2, [x1]	// store w2 into x1
	b skip			// branch to skip
	
EOF:
	ldr x0, =szEOF	// Load szEOFs address into x0
	mov x0, x19		// copy x19 into x0
	b skip			// branch to skip
	
ERROR:
	mov x19, x0			// copy x0 into x19
	ldr x0, =szERROR	// load x0 with szErrors address
	bl putstring		// Output error string
	mov x0, x19			// copy x19 back into x0
	b skip				// branch to skip
	
skip:
	ldr x30, [sp], #16	// reload LR from stack
	RET					// return getline

// End of program parameters
	mov X0, #0  		// 0 to return
	mov X8, #NR_exit    // Linux code to terminate
	svc 0	    	    // Call Linux to execute


	
// Andrew Gharios
// Lab13 :	
// Purpose: This program will output the string "cat in the hat" to text file "output.txt"
// 


.equ O_RDONLY, 0	// Read only code
.equ O_WRONLY, 1	// Write only code
.equ O_CREAT,  0101	// Create & write code
.equ S_RDWR,   0660 // chmod permissions
.equ AT_FDCWD, -100	// local directory (file descriptor)
.equ NR_openat, 56  // Openat code
.equ NR_close,	57	// close code
.equ NR_write,	64	// writing code
.equ NR_exit,	93	// exit code

	.data // Data section
szMsg:	.asciz "cat in the hat.\n"	// c-string to write to file
szFile: .asciz "output.txt"			// c-string of files name
iFD:	.byte 0						// byte to store file 

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

	ldr x1,=iFD
	strb w0,[x1]

// Write "cat in the hat" into output.txt
	mov x8, #NR_write	 // mov into x8 write code 
	ldr x1,=szMsg		 // Load x1 with the messages address
	mov x2, #16		     // num bytes to write
	svc 0				 // Write msg to file.

// Close output.txt	
	ldr x0,=iFD			 // Load x0 with iFDs address
	ldrb w0,[x0]		 // Load byte in address of x0 in w0.
	mov x8, #NR_close 	 // mov into x8 exit code
	svc 0				 // Close the file

// End of program parameters
	mov X0, #0  		// 0 to return
	mov X8, #NR_exit    // Linux code to terminate
	svc 0	    	    // Call Linux to execute


	
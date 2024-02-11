// Andrew Gharios
// Lab1 :
// Purpose: Assembler program to print "Hello World"


.global _start // Provides program starting address

_start: mov X0, #1   // 1 - StdOut
	ldr X1, =helloworld // string to print
	mov X2, #15  // length of our string 
	mov X8, #64 // Linux write system call
	svc 0       // Call Linux to execute

// End of program parameters
	mov X0, #0  // 0 to return
	mov X8, #93 // Linux code 93 terminates
	svc 0	    // Call Linux to execute


.data // Data section
helloworld:   .ascii "Andrew Gharios\n"

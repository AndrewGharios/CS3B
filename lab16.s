// Andrew Gharios
// Lab16 :	
// Purpose: 
// 

	.data // Data section
// Given data segment
str1:  .asciz "The Cat in the Hat\n"
str2:  .asciz "\n"
str3:  .asciz  "By Dr. Seuss\n"
str4:  .asciz  "\n"
str5:  .asciz "The sun did not shine.\n"
headPtr:  .quad  0		// Head pointer
tailPtr:  .quad  0		// Tail pointer
dbLength: .quad  0 		// Storage to store string length
szTemp:	  .skip 22		// Temporary string storage
chCr:	  .byte 10		// Carriage return

.global _start
.text

_start: 
	// Appending Strings 1 through 5 into the linked list
	ldr x0,=str1 		// Load x0 with strings address
	ldr x1,=szTemp		// Load x1 with szTemps address
	bl String_copy		// Branch to string copy to make a copy of the string
	
	ldr x0,=szTemp
	bl String_length	// branch to determine the length of the string
	
	ldr x1,=dbLength	// Load String length address into x1
	str x0,[x1]			// Store returned stringlen in x0 into x1s address
	bl malloc			// Branch to malloc to allocate heap memory for this string
	
	mov x11,#0			// Index for traversing the strings
	
fstindex:
	ldr x1,=szTemp		// Load x1 with copied string address
	ldrb w2,[x1,x11]	// Load byte in x1 + x11 offset into w2
	strb w2,[x0,x11]	// Store byte into new malloced space
	
	add x11,x11,#1		// Increment index
	
	ldr x12,=dbLength	// Load lengths address into x12
	ldr x12,[x12]		// Load value inside address of x12
	cmp x11,x12			// Compare index with strlength
	bne fstindex		// Jump back to 1stindex until full string has been copied
	
	mov x19,x0			// Copy mallocd address into x19
	
	mov x0,#16			// Malloc 16 bytes for pointers
	bl malloc			// branch to malloc
	
	str x19,[x0]		// Store the address of the mallocd string into the new mallocd node
	
	ldr x1,=headPtr		// Load Headptrs address into x1
	str x0,[x1]			// Point headPtr to the new node
	mov x0,#0			// Move a 0 into x0
	str x0,[x1,#8]		// Store 0 into the 8 right most bytes of the node
	
	ldr x1,=tailPtr		// Load x1 with tailPtrs address
	ldr x0,=headPtr		// Load Headptrs address into x0
	ldr x0,[x0]			// Load Headptrs stored value in x0
	str x0,[x1]			// Point tailPtr to the same address as Headptr.
	
	
//**2nd string**
	mov x0,#0			// Move a 0 into x0
	ldr x1,=szTemp		// Load x1 with szTemps address
	str x0,[x1]			// Store the 0 into szTemp to reset it

	ldr x0,=str2 		// Load x0 with strings address
	ldr x1,=szTemp		// Load x1 with szTemps address
	bl String_copy		// Branch to string copy to make a copy of the string
	
	ldr x0,=szTemp
	bl String_length	// branch to determine the length of the string
	
	ldr x1,=dbLength	// Load String length address into x1
	str x0,[x1]			// Store returned stringlen in x0 into x1s address
	bl malloc			// Branch to malloc to allocate heap memory for this string
	
	mov x11,#0			// Index for traversing the strings
	
sndindex:
	ldr x1,=szTemp		// Load x1 with copied string address
	ldrb w2,[x1,x11]	// Load byte in x1 + x11 offset into w2
	strb w2,[x0,x11]	// Store byte into new malloced space
	
	add x11,x11,#1		// Increment index
	
	ldr x12,=dbLength	// Load lengths address into x12
	ldr x12,[x12]		// Load value inside address of x12
	cmp x11,x12			// Compare index with strlength
	bne sndindex		// Jump back to 2ndindex until full string has been copied
	
	
	mov x19,x0			// Copy mallocd address into x19
	
	mov x0,#16			// Malloc 16 bytes for pointers
	bl malloc			// branch to malloc
	
	str x19,[x0]		// Store the address of the mallocd string into the new mallocd node
	
	ldr x1,=tailPtr		// Load x1 with tailPtrs address
	ldr x1,[x1]			// Load value tha tailPtr is pointing to
	str x0,[x1,#8]		// Point new node
	ldr x1,=tailPtr		// Load x1 with tailPtrs address
	str x0,[x1]			// Make the new node the current tailPtr
	
//**3rd string**
	mov x0,#0			// Move a 0 into x0
	ldr x1,=szTemp		// Load x1 with szTemps address
	str x0,[x1]			// Store the 0 into szTemp to reset it

	mov x0,#0			// Move a 0 into x0
	ldr x1,=dbLength	// Load x1 with szTemps address
	str x0,[x1]			// Store the 0 into szTemp to reset it

	ldr x0,=str3 		// Load x0 with strings address
	ldr x1,=szTemp		// Load x1 with szTemps address
	bl String_copy		// Branch to string copy to make a copy of the string
	
	ldr x0,=szTemp
	bl String_length	// branch to determine the length of the string
	
	ldr x1,=dbLength	// Load String length address into x1
	str x0,[x1]			// Store returned stringlen in x0 into x1s address
	bl malloc			// Branch to malloc to allocate heap memory for this string
	
	mov x11,#0			// Index for traversing the strings
	
index3:
	ldr x1,=szTemp		// Load x1 with copied string address
	ldrb w2,[x1,x11]	// Load byte in x1 + x11 offset into w2
	strb w2,[x0,x11]	// Store byte into new malloced space
	
	add x11,x11,#1		// Increment index
	
	ldr x12,=dbLength	// Load lengths address into x12
	ldr x12,[x12]		// Load value inside address of x12
	cmp x11,#13	   // Compare index with strlength
	bne index3		// Jump back to 3rdindex until full string has been copied
	
	
	mov x19,x0			// Copy mallocd address into x19
	
	mov x0,#16			// Malloc 16 bytes for pointers
	bl malloc			// branch to malloc
	
	str x19,[x0]		// Store the address of the mallocd string into the new mallocd node
	
	ldr x1,=tailPtr		// Load x1 with tailPtrs address
	ldr x1,[x1]			// Load value tha tailPtr is pointing to
	str x0,[x1,#8]		// Point new node
	ldr x1,=tailPtr		// Load x1 with tailPtrs address
	str x0,[x1]			// Make the new node the current tailPtr
	
//**4th string**
	mov x0,#0			// Move a 0 into x0
	ldr x1,=szTemp		// Load x1 with szTemps address
	str x0,[x1]			// Store the 0 into szTemp to reset it

	ldr x0,=str4 		// Load x0 with strings address
	ldr x1,=szTemp		// Load x1 with szTemps address
	bl String_copy		// Branch to string copy to make a copy of the string
	
	ldr x0,=szTemp
	bl String_length	// branch to determine the length of the string
	
	ldr x1,=dbLength	// Load String length address into x1
	str x0,[x1]			// Store returned stringlen in x0 into x1s address
	bl malloc			// Branch to malloc to allocate heap memory for this string
	
	mov x11,#0			// Index for traversing the strings
	
index4:
	ldr x1,=szTemp		// Load x1 with copied string address
	ldrb w2,[x1,x11]	// Load byte in x1 + x11 offset into w2
	strb w2,[x0,x11]	// Store byte into new malloced space
	
	add x11,x11,#1		// Increment index
	
	ldr x12,=dbLength	// Load lengths address into x12
	ldr x12,[x12]		// Load value inside address of x12
	cmp x11,x12			// Compare index with strlength
	bne index4		// Jump back to 4thindex until full string has been copied
	
	
	mov x19,x0			// Copy mallocd address into x19
	
	mov x0,#16			// Malloc 16 bytes for pointers
	bl malloc			// branch to malloc
	
	str x19,[x0]		// Store the address of the mallocd string into the new mallocd node
	
	ldr x1,=tailPtr		// Load x1 with tailPtrs address
	ldr x1,[x1]			// Load value tha tailPtr is pointing to
	str x0,[x1,#8]		// Point new node
	ldr x1,=tailPtr		// Load x1 with tailPtrs address
	str x0,[x1]			// Make the new node the current tailPtr

//**5th string**
	mov x0,#0			// Move a 0 into x0
	ldr x1,=szTemp		// Load x1 with szTemps address
	str x0,[x1]			// Store the 0 into szTemp to reset it

	ldr x0,=str5 		// Load x0 with strings address
	ldr x1,=szTemp		// Load x1 with szTemps address
	bl String_copy		// Branch to string copy to make a copy of the string
	
	ldr x0,=szTemp
	bl String_length	// branch to determine the length of the string
	
	ldr x1,=dbLength	// Load String length address into x1
	str x0,[x1]			// Store returned stringlen in x0 into x1s address
	bl malloc			// Branch to malloc to allocate heap memory for this string
	
	mov x11,#0			// Index for traversing the strings
	
index5:
	ldr x1,=szTemp		// Load x1 with copied string address
	ldrb w2,[x1,x11]	// Load byte in x1 + x11 offset into w2
	strb w2,[x0,x11]	// Store byte into new malloced space
	
	add x11,x11,#1		// Increment index
	
	ldr x12,=dbLength	// Load lengths address into x12
	ldr x12,[x12]		// Load value inside address of x12
	cmp x11,x12			// Compare index with strlength
	bne index5		// Jump back to 5thindex until full string has been copied
	
	
	mov x19,x0			// Copy mallocd address into x19
	
	mov x0,#16			// Malloc 16 bytes for pointers
	bl malloc			// branch to malloc
	
	str x19,[x0]		// Store the address of the mallocd string into the new mallocd node
	
	ldr x1,=tailPtr		// Load x1 with tailPtrs address
	ldr x1,[x1]			// Load value tha tailPtr is pointing to
	str x0,[x1,#8]		// Point new node
	ldr x1,=tailPtr		// Load x1 with tailPtrs address
	str x0,[x1]			// Make the new node the current tailPtr

// PrintAll
	ldr	x0, =headPtr	// Load x0 with headPointer
	ldr	x0, [x0]		// Load address x0 is pointing to
	ldr	x0, [x0, #0]	// x0 holds address of current string
	bl	putstring
	
	//2nd node
	ldr	x0, =headPtr	// Load x0 with headPointer
	ldr	x0, [x0]		// Load address x0 is pointing to
	ldr	x0, [x0, #8]	// Load the next node in x0
	ldr	x0, [x0, #0]	// x0 holds address of current string
	bl	putstring		// Branch to putstring

	//3rd node
	ldr	x0, =headPtr	// Load x0 with headPointer
	ldr	x0, [x0]		// Load address x0 is pointing to
	ldr	x0, [x0, #8]	// Load the next node in x0
	ldr	x0, [x0, #8]	// Load the next node in x0
	ldr	x0, [x0, #0]	// x0 holds address of current string
	bl	putstring		// Branch to putstring
	
	//4th node
	ldr	x0, =headPtr	// Load x0 with headPointer
	ldr	x0, [x0]		// Load address x0 is pointing to
	ldr	x0, [x0, #8]	// Load the next node in x0
	ldr	x0, [x0, #8]	// Load the next node in x0
	ldr	x0, [x0, #8]	// Load the next node in x0
	ldr	x0, [x0, #0]	// x0 holds address of current string
	bl	putstring		// Branch to putstring
	
	//last node
	ldr	x0, =tailPtr	// Load x0 with tailPtrs address
	ldr	x0, [x0]		// Load current address tailPtr is pointing at
	ldr	x0, [x0, #0]	// x0 holds address of current string in tailPtr
	bl	putstring

// End of program parameters
	mov X0, #0  	  // 0 to return
	mov X8, #93		  // Linux code to terminate
	svc 0	    	  // Call Linux to execute


// Andrew Gharios & Natasha Wu
// RASM-3:
// Purpose: Get three strings from user input and perform a series of manipulations to
//			those strings using a list of functions
// 			
// Date: 10/19/2023

.global _start // Provides program starting address

	.equ MAX_BYTES, 21
	.data 		// Data section
//The main three strings used for all functions
szS1:				.skip	MAX_BYTES
szS2:				.skip	MAX_BYTES
szS3:				.skip	MAX_BYTES
szS4:				.skip	MAX_BYTES


//Strings for output format
szHeader:			.asciz	"Names: Natasha Wu & Andrew Gharios\nProgram: rasm3.asm\nClass: CS 3B\nDate: 9/29/2023\n"
szPrompt1:			.asciz	"Enter 1st string: "
szPrompt2:			.asciz	"Enter 2nd string: "
szPrompt3:			.asciz	"Enter 3rd string: "
szSQuote:			.asciz "\'"
szDQuote:			.asciz "\""
szS1Length:			.asciz "\ns1.length() = "
szS2Length:			.asciz "\ns2.length() = "
szS3Length:			.asciz "\ns3.length() = "
szCopyLine1:		.asciz "\ns4 = String_copy(s1)"
szCopyLine2:		.asciz "\ns1 = "
szCopyLine3:		.asciz "\ns4 = "
szS1S3Equals:		.asciz "\nString_equals(s1,s3) = "
szS1S1Equals:		.asciz "\nString_equals(s1,s1) = "
szS1S3EqualsIgn:	.asciz "\nString_equalsIgnoreCase(s1,s3) = "
szS1S2EqualsIgn:	.asciz "\nString_equalsIgnoreCase(s1,s2) = "
szCharAt:			.asciz "\nString_charAt(s2,4) = \'"
szSubstring1:		.asciz "\nString_substring_1(s3,4,14) = \""
szSubstring2:		.asciz "\nString_substring_2(s3,7) = \""
szStartsWith1:		.asciz "\nString_startsWith_1(s1,11,\"hat.\") = "
szStartsWith2:		.asciz "\nString_startsWith_1(s1,\"Cat\") = "
szEndsWith:			.asciz "\nString_endsWith(s1,\"in the hat.\") = "
szIO1:				.asciz	"String_indexOf_1(s2,\'g\') = "
szIO2:				.asciz	"String_indexOf_2(s2,\'g\',9) = "
szIO3:				.asciz	"String_indexOf_3(s2,\"eggs\")= "
szLIO1:				.asciz	"String_lastIndexOf_1(s2,\'g\') = "
szLIO2:				.asciz	"String_lastIndexOf_2(s2,\'g\',6) = "
szLIO3:				.asciz	"String_lastIndexOf_3(s2,\"egg\") = "
szReplace:			.asciz	"String_replace(s1,\'a\',\'o\') = \""
szLower:			.asciz	"String_toLowerCase(s1) = \""
szUpper:			.asciz	"String_toUpperCase(s1) = \""
szConcat1:			.asciz	"String_concat(s1, \" \") = \""
szConcat2:			.asciz	"String_concat(s1, s2) = \""

//Values to pass as parameters for functions
szOutput: 			.skip 22
szSkip:				.skip 20
chEndl:				.byte 10
szOut:				.asciz "String length = "
szChar:				.skip 1
szRes:				.skip 21
dbIndex: 			.skip 4	
chIndex1:	    	.byte 'g'
chReplace:			.byte 'a'
chReplaceWith:		.byte 'o'
szHat:				.asciz "hat."
szCat:				.asciz "Cat"
szInTheHat:			.asciz "in the hat."
szEggs:				.asciz	"eggs"
szSpace:			.asciz	" "
iLimitNum: 		 	.word 21 		   

	.text
_start: 
// ========================== Class Header ========================== //
	ldr x0,=szHeader  // Loads x0 with szHeaders address.
	bl putstring 	  // Call putstring to print header.
	
	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch
	
// ========================== User input ========================== //
// -------------------------- 	  S1	-------------------------- //
	ldr x0, =szPrompt1		// loads address of szPrompt1 into x0
	bl	putstring			// branch and link function putstring
	
	ldr x0, =szS1			// loads address of szS1 into x0
	mov x1, MAX_BYTES		// moves the value 21 into x1
	bl	getstring			// branch and link function putstring
	
// -------------------------- 	  S2	-------------------------- //
	ldr x0, =szPrompt2		// loads address of szPrompt2 into x0
	bl	putstring			// branch and link function putstring
	
	ldr x0, =szS2			// loads address of szS2 into x0
	mov x1, MAX_BYTES		// moves the value 21 into x1
	bl	getstring			// branch and link function putstring
	
// -------------------------- 	  S3	-------------------------- //
	ldr x0, =szPrompt3		// loads address of szPrompt3 into x0
	bl	putstring			// branch and link function putstring
	
	ldr x0, =szS3			// loads address of szS3 into x0
	mov x1, MAX_BYTES		// moves the value 21 into x1
	bl	getstring			// branch and link function putstring

// ========================== String_length ========================== //
// -------------------------- 	  szS1		-------------------------- //
	ldr x0, =szS1Length		// loads address of szS1Length into x0
	bl	putstring			// branch and link function putstring

	ldr x0, =szS1			// loads address of szS1 into x0
	bl	String_length		// branch and link function String_length
	
	ldr x1, =szSkip			// loads address of szSkip into x1
	bl	int64asc			// branch and link function int64asc
	
	ldr x0, =szSkip			// loads address of szSkip into x0
	bl	putstring			// branch and link function putstring
	
// -------------------------- 	  szS2		-------------------------- //
	ldr x0, =szS2Length		// loads address of szS2Length into x0
	bl	putstring			// branch and link function putstring

	ldr x0, =szS2			// loads address of szS2 into x0
	bl	String_length		// branch and link function String_length
	
	ldr x1, =szSkip			// loads address of szSkip into x1
	bl	int64asc			// branch and link function int64asc
	
	ldr x0, =szSkip			// loads address of szSkip into x0
	bl	putstring			// branch and link function putstring
	
// -------------------------- 	  szS3		-------------------------- //
	ldr x0, =szS3Length		// loads address of szS3Length into x0
	bl	putstring			// branch and link function putstring

	ldr x0, =szS3			// loads address of szS3 into x0
	bl	String_length		// branch and link function String_length
	
	ldr x1, =szSkip			// loads address of szSkip into x1
	bl	int64asc			// branch and link function int64asc
	
	ldr x0, =szSkip			// loads address of szSkip into x0
	bl	putstring			// branch and link function putstring
	
	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch
	
// ========================== String_equals ========================== //
// -------------------- 	  szS1 and szS3		-------------------- //
	ldr x0, =szS1S3Equals	// loads address of szS1S3Equals into x0
	bl	putstring			// branch and link function putstring

	ldr x1,	=szS1			// loads address of szS1 into x1
	ldr x2, =szS3			// loads address of szS3 into x2
	bl	String_equals		// branch and link function String_equals
	
// -------------------- 	  szS1 and szS1		-------------------- //
	ldr x0, =szS1S1Equals	// loads address of szS1S3Equals into x0
	bl	putstring			// branch and link function putstring

	ldr x1,	=szS1			// loads address of szS1 into x1
	ldr x2, =szS1			// loads address of szS3 into x2
	bl	String_equals		// branch and link function String_equals
	
	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch
	
// ========================== String_equalsIgnoreCase ========================== //
// -------------------------- 	  szS1 and szS3		-------------------------- //
	ldr x0, =szS1S3EqualsIgn	// loads address of szS1S3EqualsIgn into x0
	bl	putstring				// branch and link function putstring
	
	ldr x1,	=szS1				// loads address of szS1 into x0
	ldr x2, =szS3				// loads address of szS3 into x0
	bl	String_equalsIgnoreCase	// branch and link to function String_equalsIgnoreCase
	
// -------------------------- 	  szS1 and szS2		-------------------------- //
	ldr x0, =szS1S2EqualsIgn	// loads address of szS1S2EqualsIgn into x0
	bl	putstring				// branch and link function putstring
	
	ldr x1,	=szS1				// loads address of szS1 into x0
	ldr x2, =szS2				// loads address of szS2 into x0
	bl	String_equalsIgnoreCase // branch and link to function String_equalsIgnoreCase
	
	ldr x0, =chEndl				// loads address of chEndl into x0
	bl  putch					// branch and link function putch
	
// ========================== String_copy ========================== //
	ldr x0, =szCopyLine1	// loads address of szCopyLine1 into x0
	bl	putstring			// branch and link to function putstring
	ldr x0, =szS1			// loads address of szS1 into x0
	ldr x1, =szS4			// loads address of szS4 into x0
	bl	String_copy			// branch and link to function String_copy
	
	ldr x0, =szCopyLine2	// loads address of szCopyLine2 into x0
	bl	putstring			// branch and link to function putstring
	ldr x0, =szS1			// loads address of szS1 into x0
	bl 	putstring			// branch and link to function putstring

	ldr x0, =szCopyLine3	// loads address of szCopyLine3 into x0
	bl	putstring			// branch and link to function putstring
	ldr x0, =szS4			// loads address of szS1 into x0
	bl 	putstring			// branch and link to function putstring
	
	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch
	
// ========================== String_substring_1 ========================== //
	ldr x0, =szSubstring1	// loads address of szSubstring1 into x0
	bl	putstring			// branch and link to function putstring
	
	ldr x0, =szS3			// loads address of szS3 into x0
	mov x1, #4				// moves the value 7 into x1
	mov x2, #14				// moves the value 14 into x2
	bl	String_substring_1	// branch and link to function String_substring_2
	
	ldr x0, =szDQuote		// loads address of szDQuote into x0
	bl	putch				// branch and link to function putch
	
// ========================== String_substring_2 ========================== //
	ldr x0, =szSubstring2	// loads address of szSubstring2 into x0
	bl	putstring			// branch and link to function putstring
	
	ldr x0, =szS3			// loads address of szS3 into x0
	mov x1, #7				// moves the value 7 into x1
	bl	String_substring_2	// branch and link to function String_substring_2
	
	ldr x0, =szDQuote		// loads address of szDQuote into x0
	bl	putch				// branch and link to function putch
	
	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch
	
// ========================== String_charAt ========================== //
	ldr x0, =szCharAt		// loads address of szCharAt into x0
	bl	putstring			// branch and link to function putstring
	
	ldr x0, =szS2			// loads address of szS2 into x0
	mov x1, #4				// moves the value 4 into x1
	bl	String_charAt		// branch and link to function String_charAt
	
	// THANK YOU ANDREW <33333 ALL HAIL KING ANDREW
	ldr  x1, =szChar		// loads address of szChar into x1
	strb w0, [x1]			// stores byte in w0 into address in x1
	
	ldr x0, =szChar			// loads address of szChar into x0
	bl	putch				// branch and link to function putch
	
	ldr x0, =szSQuote		// loads address of szSQuote into x0
	bl	putch				// branch and link to function putch
	
	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch
	
// ========================== String_startsWith_1 ========================== //
	ldr x0, =szStartsWith1	// loads address of szStartsWith1 into x0
	bl	putstring			// branch and link to function putstring
	
	ldr x0, =szS1			// loads address of szS1 into x0
	mov x1, #11				// moves the value 11 ito x1
	ldr x2,	=szHat			// loads address of szHat into x2
	
	bl	String_startsWith_1	// branch and link to function String_startsWith_1

// ========================== String_startsWith_2 ========================== //
	ldr x0, =szStartsWith2	// loads address of szStartsWith2 into x0
	bl	putstring			// branch and link to function putstring
	
	ldr x0, =szS1			// loads address of szS1 into x0
	ldr x1,	=szCat			// loads address of szCat into x1
	
	bl String_startsWith_2	// branch and link to function String_startsWith_2
	
	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch

// ========================== String_endsWith ========================== //
	ldr x0, =szEndsWith		// loads address of szEndsWith into x0
	bl	putstring			// branch and link to function putstring
	
	ldr x0, =szS1			// loads address of szS1 into x0
	ldr x1,	=szInTheHat		// loads address of szInTheHat into x1
	
	bl String_endsWith		// branch and link to function String_endsWith
	
	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch

	ldr	x0, =chEndl			// loads address of chEndl into x0
	bl	putch				// branch to putch

// ========================== String_indexOf_1 ========================== //
	ldr	x0, =szIO1			// loads address of szIO1 into x0
	bl	putstring			// branch to putstring

	ldr	x0, =szS2			// loads address of szS2 into x0
	ldr	x1, =chIndex1		// loads address of chIndex1 into x1
	bl	String_indexOf_1	// branch to String_indexOf_1

	ldr	x1, =dbIndex		// loads address of dbIndex into x1
	bl	int64asc			// branch and link function int64asc
	ldr	x0, =dbIndex		// loads address of dbIndex into x0
	bl	putstring			// branch to putstring

	ldr	x0, =chEndl			// loads address of chEndl into x0
	bl	putch				// branch to putch

// ========================== String_indexOf_2 ========================== //
	ldr	x0, =szIO2			// loads address of szIO2 into x0
	bl	putstring			// branch to putstring

	ldr	x0, =szS2			// loads address of szS2 into x0
	ldr	x1, =chIndex1		// loads address of chIndex1 into x1
	mov	x2, #9				// Mov 9 into x2 to pass into function
	bl	String_indexOf_2	// branch to String_indexOf_2

	ldr	x1, =dbIndex		// loads address of dbIndex into x1
	bl	int64asc			// branch and link function int64asc
	ldr	x0, =dbIndex		// loads address of dbIndex into x0
	bl	putstring			// branch to putstring

	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch

// ========================== String_indexOf_3 ========================== //
	ldr	x0, =szIO3			// loads address of szIO3 into x0
	bl	putstring			// branch to putstring

	ldr	x0, =szS2			// loads address of szS2 into x0
	ldr	x1, =szEggs			// loads address of szEggs into x1
	bl	String_indexOf_3

	ldr	x1, =dbIndex		// loads address of dbIndex into x1
	bl	int64asc			// branch and link function int64asc
	ldr	x0, =dbIndex		// loads address of dbIndex into x0
	bl	putstring			// branch to putstring

	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch
	
	ldr	x0, =chEndl			// loads address of chEndl into x0
	bl	putch				// branch to putch

// ========================== String_lastIndexOf_1 ========================== //
	ldr	x0, =szLIO1			// loads address of szLIO1 into x0
	bl	putstring			// branch to putstring

	ldr	x0, =szS2			// loads address of szS2 into x0
	ldr	x1, =chIndex1		// loads address of chIndex1 into x1
	bl	String_lastIndexOf_1// branch to

	ldr	x1, =dbIndex		// loads address of dbIndex into x1
	bl	int64asc			// branch and link function int64asc
	ldr	x0, =dbIndex		// loads address of dbIndex into x0
	bl	putstring			// branch to putstring

	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch

// ========================== String_lastIndexOf_2 ========================== //
	ldr	x0, =szLIO2			// loads address of szLIO2 into x0
	bl	putstring			// branch to putstring

	ldr	x0, =szS2			// loads address of szS2 into x0
	ldr	x1, =chIndex1		// loads address of chIndex1 into x1
	mov	x2, #6				// Move 6 into x2 to pass into function
	bl	String_lastIndexOf_2 // branch to String_lastIndexOf_2

	// Print
	ldr	x1, =dbIndex		// loads address of dbIndex into x1
	bl	int64asc			// branch and link function int64asc
	ldr	x0, =dbIndex		// loads address of dbIndex into x0
	bl	putstring			// branch to putstring

	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch

// ========================== String_lastIndexOf_3 ========================== //
	ldr	x0, =szLIO3			// loads address of szLIO3 into x0
	bl	putstring			// branch to putstring

	ldr	x0, =szS2			// loads address of szS2 into x0
	ldr	x1, =szEggs			// loads address of szSpace into x1
	bl	String_lastIndexOf_3 // branch to String_lastIndexOf_3

	// Print the index
	ldr	x1, =dbIndex		// loads address of dbIndex into x1
	bl	int64asc			// branch and link function int64asc
	ldr	x0, =dbIndex		// loads address of dbIndex into x0
	bl	putstring			// branch to putstring

	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch
	
	ldr	x0, =chEndl			// loads address of chEndl into x0
	bl	putch				// branch to putch
	
// ========================== String_replace ========================== //
	ldr	x0, =szReplace		// loads address of szReplace into x0
	bl	putstring			// branch to putstring

	ldr	x0, =szS1			// loads address of szS1 into x0
	ldr	x1, =chReplace		// loads address of chReplace into x1
	ldr	x2, =chReplaceWith	// loads address of chReplaceWith into x2
	bl	String_replace		// branch to String_replace

	//S/O NATASHA for the beautiful String_copy function!!!
 	ldr	x1, =szS1			// loads address of szS1 into x0
	bl	String_copy			// branch and link to function String_copy

	ldr	x0, =szS1			// loads address of szS1 into x0
	bl	putstring			// branch to putstring
	
	ldr x0, =szDQuote		// loads address of szDQuote into x0
	bl	putch				// branch and link to function putch

	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch
	
	ldr	x0, =chEndl			// loads address of chEndl into x0
	bl	putch				// branch to putch

// ========================== String_toLowerCase ========================== //
	ldr	x0, =szLower		// loads address of szLower into x0
	bl	putstring			// branch to putstring

	ldr	x0, =szS1			// loads address of szS1 into x0
	bl	String_toLowerCase  // branch to String_toLowerCase
	bl  putstring			// branch to putstring
	
	ldr x0, =szDQuote		// loads address of szDQuote into x0
	bl	putch				// branch and link to function putch

	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch

// ========================== String_toUpperCase ========================== //
	ldr	x0, =szUpper		// loads address of szUpper into x0
	bl	putstring			// branch to putstring

	ldr	x0, =szS1			// loads address of szS1 into x0
	bl	String_toUpperCase	// branch to String_toUpperCase	
	ldr x1, =szS1			// loads address of szS1 into x1
	bl 	String_copy			// branch to String_copy
	
	ldr x0,=szS1			// loads address of szS1 into x0
	bl putstring			// branch to putstring
	
	ldr x0, =szDQuote		// loads address of szDQuote into x0
	bl	putch				// branch and link to function putch

	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch
	
	ldr	x0, =chEndl			// loads address of chEndl into x0
	bl	putch				// branch to putch
	
// ========================== String_concat ========================== //
	ldr	x0, =szConcat1		// loads address of szConcat1 into x0
	bl	putstring			// branch to putstring

	ldr	x0, =szS1			// loads address of szS1 into x0
	ldr	x1, =szSpace		// loads address of szSpace into x1
	bl	String_concat
	bl  putstring			// branch to putstring
	
	ldr x0, =szDQuote		// loads address of szDQuote into x0
	bl	putch				// branch and link to function putch
	
	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch

	ldr	x0, =szConcat2
	bl	putstring			// branch to putstring

	ldr x0, =szS1			// loads address of szS1 into x0
	ldr	x1, =szS2			// loads address of szS2 into x1
	bl	String_concat		// branch to String_concat
	bl	putstring			// branch to putstring
	
	ldr x0, =szDQuote		// loads address of szDQuote into x0
	bl	putch				// branch and link to function putch

	ldr x0, =chEndl			// loads address of chEndl into x0
	bl  putch				// branch and link function putch

// ========================== _end ========================== //
_end:
// End of program parameters
	mov X0, #0  			// 0 to return
	mov X8, #93 			// Linux code 93 terminates
	svc 0	    			// Call Linux to execute




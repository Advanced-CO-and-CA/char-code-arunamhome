
/******************************************************************************
* file: substring.s
* author: Arun A. M. : CS18M510
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/
/*Given two strings, check whether the second string is a substring of the First one. 
The starting addresses of two strings are defined by the STRING and SUBSTR  variables,  respectively.  
If  the  string  defined  by  SUBSTR  is  not present  in  the  string  defined  by  STRING,  clear  the  PRESENT  variable; 
otherwise set the variable with the position of the first occurrence of the second string in the first string.
*/


@BSS SECTION
  .bss
  PRESENT: .word 0   @Variable to store the PRESENT variable     

  @ DATA SECTION
      .data
	STRING:  .asciz "CS6620"     @First String defined by address STRING, asciz used to terminate the string with null char
	SUBSTR:  .asciz "620"        @Second String defined by address SUBSTR, asciz used to terminate the string with null char
  
   
	
  @ TEXT section
      .text

.globl _main

_main:
    @Load the addresses of STRING, and SUBSTR to r0 and r1 respectively
    LDR r0, =STRING
    LDR r1, =SUBSTR
    MOV r5, r0            @Save the address of r1 in r5 for getting the start of string
    MOV r6, #0x00000000   @Set default value for temp holder of PRESENT variable r6 as 0x0 


LOOP1:
    @Loop1 for iterating through the STRING using r2, 
    LDRB r2, [r0], #1
    CMP r2, #0            @Check for Null char for end of string, if end of string then jump to exit
    BEQ EXIT
    MOV r4, r0            @Save the current index of STRING in r0 to r4 for iterating in LOOP2
    LDR r1, =SUBSTR

LOOP2:
    @Loop2 for iterating the SUBSTR using r3 in case char matches with r2 char of STRING 
    LDRB r3, [r1], #1
    CMP r3, #0            @Check for Null char for end of SUBSTR, if end of substring then substring is present in STRING 
    BEQ SUBSTR_PRESENT

    CMP r2,r3             @Check if r2 char of STRING matches with r3 char of SUBSTR, if not then jump to main loop LOOP1
    BNE LOOP1
    @Match found so iterate within the LOOP2 till mismatch found or null string found
    LDRB r2, [r4], #1     
    CMP r2, #0            @Check for Null char for end of STRING, if end of STRING then jump to CHECK_SUBSTR to see if SUBSTR also has next char as NULL
    BEQ CHECK_SUBSTR

    B LOOP2
  
CHECK_SUBSTR:
    @CHECK_SUBSTR to see if SUBSTR also has next char as NULL, if not then SUBSTR match is not found so EXIT
    LDRB r3, [r1], #1
    CMP r3, #0
    BNE EXIT

SUBSTR_PRESENT:
    @IF SUBSTR present in STRING then find the position of start of SUBSTR in STRING
    SUB r6, r0, r5         @Here r0 points to the saved index of starting of the first char match of STRING and SUBSTR
                           @So subtract r5 - current STRING index from match index r0 of STRING to get the start of SUBSTR in STRING to get r6 (PRESENT)

EXIT:
    @Save the value of r6 in PRESENT
    LDR r7, =PRESENT
    STR r6, [r7]
    SWI 0x11
    .end


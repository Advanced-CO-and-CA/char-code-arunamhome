
/******************************************************************************
* file: string_compare.s
* author: Arun A. M. : CS18M510
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/
/*Compare two strings of ASCII characters to see which is larger (i.e., which follows  the  other  in  alphabetical  ordering).  
Both  strings  have  the  same length as deNined by the LENGTH variable. 
The strings’ starting addresses are defined by the START1 and START2 variables. 
If the string defined by START1  is  greater  than  or  equal  to  the  other  string,  clear  the  GREATER variable; 
otherwise set the variable to all ones (0xFFFFFFFF). 
*/


@BSS SECTION
  .bss
  GREATER: .word 0   @Variable to store the GREATER     

  @ DATA SECTION
      .data
	START1:  .asciz "BUT"  @String1 defined by address START1
	START2:  .asciz "CAT"  @String2 defined by address START2
  LENGTH: .word 3        @Length of the Given string
   
	
  @ TEXT section
      .text

.globl _main

_main:
    @Load the addresses of START1, START2 and LENGTH to r0, r1 and r2 respectively
    LDR r0, =START1
    LDR r1, =START2
    LDR r2, =LENGTH 
    LDR r3, [R2] @Get the Length from R2 and save in r3

LOOP:
    @Condition to check for end of string, and if 0 jump to clear the GREATER variable
    CMP r3, #0
    BEQ CLEAR_GREATER

    @Get the char to r4 and r5 from START1 and START2 respectively for comparison
    LDRB r4, [r0], #1
    LDRB r5, [r1], #1
    CMP r4, r5            @Compare the chars and if r4(START1) is less than r5(START2), then START2 is greater so jump to set the GREATER variable
    BLT SET_GREATER
    SUB r3, r3, #1        @If not GREATER, then substract the length for next iteration and LOOP
    B LOOP

SET_GREATER:
    @Set the GREATER variable r6 as 0xFFFFFFFF and EXIT
    MOV r6, #0xFFFFFFFF
    B EXIT

CLEAR_GREATER:
    @Clear the GREATER variable r6 i.e 0x00000000 and EXIT
    MOV r6, #0x00000000
    B EXIT

EXIT:
    @Store the value of r6 to GREATER variable
    LDR r7, =GREATER
    STR r6, [r7]
    SWI 0x11
    .end

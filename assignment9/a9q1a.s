# check character using logical var
# if ((r1 >= 0x41 && r1 =< 0x5a) || (r1 >= 0x61 && r1 =< 0x7a)) {...}
# This is part 1a.

.global main
main:
	# push stack
	SUB sp, sp, #4
	STR lr, [sp]
	# print f for single char
	LDR r0, =prompt
	BL printf
	
	# scanf
	LDR r0, =format
	LDR r1, =char
	BL scanf
	# load char in r1
	LDR r1, =char
	LDR r1, [r1]

	# This is basically the same as n lecture
	# compare w/41
	MOV r2, #0 // All bits are 0
	CMP r1, #0x41
 	ADDGE r2, #1 // if true, bit 0 is changed to 1
 	
	# compare w/ 5a and store logical var in r3 if less
	MOV r3, #0
 	CMP r1, #0x5A
 	ADDLE r3, #1
 	
	AND r2, r2, r3 // Results from first AND, if true r1 is uppercase
 	

	# compare to 61 for lower case
	# if greater, r0 == 1
	MOV r0, #0
 	CMP r1, #0x61
 	ADDGE r0, #1
	# same as above, compare upper bound (7a)
 	MOV r3, #0
 	CMP r1, #0x7A
 	ADDLE r3, #1
 	
	# yield resulting logical var in r2
	AND r3, r3, r0 // Results from second AND, if true r1 is lowercase
 	ORR r2, r2, r3 // Results from OR, if true r1 is a letter
	# move to r1 for printing
	MOV r1, r2
	
	# if r1 = 0, then not a character
	# branch to not_char in this case
	CMP r1, #0
	BEQ not_char

	# if r1!=0, is char and print message
	LDR r0, =char_msg
	BL printf
	# goto end
	B end

not_char:
	# if not a char, print a message
	LDR r0, =not_char_msg
	BL printf

end:
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
	output: .asciz "Output is: %d\n"
	prompt: .asciz "Please input a single character:\n"
	format: .asciz "%c"
	char: .space 40
	not_char_msg: .asciz "This is NOT a character! :( \n"
	char_msg: .asciz "This IS a character! :) \n"
	

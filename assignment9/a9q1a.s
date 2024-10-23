# check character using logical var
# if ((r1 >= 0x41 && r1 =< 0x5a) || (r1 >= 0x61 && r1 =< 0x7a)) {...}
# This is part 1a.

.global main
main:
	SUB sp, sp, #4
	STR lr, [sp]
	LDR r0, =prompt
	BL printf
	
	LDR r0, =format
	LDR r1, =char
	BL scanf

	LDR r1, =char
	LDR r1, [r1]

	MOV r2, #0 // All bits are 0
	CMP r1, #0x41
 	ADDGE r2, #1 // if true, bit 0 is changed to 1
 	
	MOV r3, #0
 	CMP r1, #0x5A
 	ADDLT r3, #1
 	
	AND r2, r2, r3 // Results from first AND, if true r1 is uppercase
 	
	MOV r0, #0
 	CMP r1, #0x61
 	ADDGE r0, #1
	
 	MOV r3, #0
 	CMP r1, #0x7A
 	ADDLT r3, #1
 	
	AND r3, r3, r0 // Results from second AND, if true r1 is lowercase
 	ORR r2, r2, r3 // Results from OR, if true r1 is a letter

	MOV r1, r2
	
	# old print that prints the number
	#LDR r0, =output
	#BL printf 	
	
	#this will print a message based on different r1 value
	CMP r1, #0
	BEQ not_char

	CMP r1, #1
	BEQ is_char

	B end

not_char:
	LDR r0, =not_char_msg
	BL printf
	B end

is_char:
	LDR r0, =char_msg
	BL printf
	B end 
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
	

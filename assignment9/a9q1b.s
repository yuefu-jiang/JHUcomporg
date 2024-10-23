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
	
	# these are definitly not characters
	CMP r1, #0x41
	BLT not_char
	CMP r1, #0x7A
	BGT not_char
	
	# consider interval values now...
 	CMP r1, #0x5A
	BGT check_between
	
	B is_char
	
check_between:
	CMP r1, #0x61
	BLT not_char

	CMP r1, #0x7A
	BGT not_char
	
	B is_char
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
	

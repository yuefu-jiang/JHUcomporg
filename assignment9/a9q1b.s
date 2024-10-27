# check character using logical var
# if ((r1 >= 0x41 && r1 =< 0x5a) || (r1 >= 0x61 && r1 =< 0x7a)) {...}
# This is part 1a.

.global main
main:
	SUB sp, sp, #4
	STR lr, [sp]
	#printf
	LDR r0, =prompt
	BL printf
	
	#scanf to r1
	LDR r0, =format
	LDR r1, =char
	BL scanf
	# now r1 has the character
	LDR r1, =char
	LDR r1, [r1]
	
	# if r1 < 41 OR r1 > 7a
	# definitly not characters
	CMP r1, #0x41
	BLT not_char
	CMP r1, #0x7A
	BGT not_char
	
	# consider interval values now...
	# if r1 > 5a:
	# 	if less than 61, not a char; else is_char
	# else if r1 < 5a, then r1 MUST > 41, therefore is char
 	CMP r1, #0x5A
	BGT check_between
	
	B is_char
	
check_between:
	# this code check if less than 61
	# if so, not a char
	# else branch to is_char
	CMP r1, #0x61
	BLT not_char

	B is_char
not_char:
	# this prints message that this is not a char, then B to end
	LDR r0, =not_char_msg
	BL printf
	B end

is_char:
	# this prints message that this IS a char
	# don't have to B end since end is right below
	LDR r0, =char_msg
	BL printf
end:
	# pop stack in end
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
	output: .asciz "Output is: %d\n"
	prompt: .asciz "Please input a single character:\n"
	format: .asciz "%c"
	char: .word 0
	not_char_msg: .asciz "This is NOT a character! :( \n"
	char_msg: .asciz "This IS a character! :) \n"
	

.text 
.global main
main:
	# create the work space
	SUB sp, sp, #4
	STR lr, [sp, #0]
	# input
	LDR r0, =prompt
	BL printf
	# load input scanf
	LDR r0, =userInput
	LDR r1, =userString
	BL scanf

	# printf
	LDR r0, =format
	LDR r1, =userString
	BL printf

	# return to os
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	prompt: .asciz "I'm about to quote you now - say something interesting:\n" 
	format: .asciz "\"%s\"\n"
	userString: .space 40
	userInput: .asciz "%[^\n]"

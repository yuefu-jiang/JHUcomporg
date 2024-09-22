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
	LDR r1, =num
	BL scanf
	# printf
	LDR r0, =format
	LDR r1, =num
	LDR r1, [r1, #0]
	BL printf

	# return to os
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	prompt: .asciz "How many dollars do you have in your pocket?:\n" 
	format: .asciz "I have\t%d\tdollars in my pocket!\n" 
	num: .word 0 
	userInput: .asciz "%d" 


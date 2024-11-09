.text
.global main

main:
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# recursive summation
	LDR r0, =prompt
	BL printf

	LDR r0, =format
	LDR r1, =num
	BL scanf

	LDR r0, =num
	LDR r0, [r0]
	
	BL sum
	MOV r1, r0
	LDR r0, =output
	BL printf

	# Return to the OS
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr
.data
	prompt: .asciz "Input integer: \n"
	format: .asciz "%d"
	num: .word 0
	output: .asciz "Summation is %d\n"
# end main
.text
sum:
	SUB sp, sp, #8
	STR lr, [sp, #0]
	STR r4, [sp, #4]
	MOV r4, r0

	# if r0 is 0, return 0
	MOV r1, #0
	CMP r1, r4
	BEQ return //return 0 in r0

	ADD r0, r4, #-1
	BL sum //return value in r0
	ADD r0, r4, r0 //return summation in r0
	B return //not really needed


	return:
		LDR lr, [sp, #0]
		LDR r4, [sp, #4]
		ADD sp, sp, #8
		MOV pc, lr

.data
# end sum

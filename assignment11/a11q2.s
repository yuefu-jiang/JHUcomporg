.text
.global main

main:
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# recursive fibonacci
	LDR r0, =prompt
	BL printf

	LDR r0, =format
	LDR r1, =num
	BL scanf

	LDR r0, =num
	LDR r0, [r0]

	BL Fibonacci
	MOV r1, r0
	LDR r0, =output
	BL printf

	# Return to the OS
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr
.data
	prompt: .asciz "Input an integer to calculate Fibonacci:\n"
	format: .asciz "%d"
	num: .word 0
	output: .asciz "Fibonacci is %d\n"
# end main
.text
Fibonacci:
	SUB sp, sp, #16
	STR lr, [sp, #0]
	STR r4, [sp, #4]
	STR r5, [sp, #8]
	MOV r4, r0

	# if r0 is 0, return 0
	MOV r1, #1
	CMP r1, r4
	BEQ return //return 0 in r0

	# if r0 is 1, return 1
	MOV r1, #0
	CMP r1, r4
	BEQ return //return 0 in r0

	ADD r0, r4, #-1
	BL Fibonacci //return value in r0
	MOV r5, r0 //store F(n-1) in r5
	ADD r0, r4, #-2
	BL Fibonacci //return value in r0
	ADD r0, r5, r0 //return summation in r0
	B return //not really needed


	return:
		LDR lr, [sp, #0]
		LDR r4, [sp, #4]
		LDR r5, [sp, #8]
		ADD sp, sp, #16
		MOV pc, lr

.data
# end sum

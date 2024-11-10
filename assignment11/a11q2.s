.text
.global main

main:
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# recursive fibonacci
	# laod prompt for a integer
	LDR r0, =prompt
	BL printf
	# scanf into r0
	LDR r0, =format
	LDR r1, =num
	BL scanf
	LDR r0, =num
	LDR r0, [r0]
	
	# call recursive function, returns result in r0
	BL Fibonacci
	# move into r1 and printf result
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
	# in Fibonacci, we uses r4 and r5, so stroring them in stack first
	SUB sp, sp, #16
	STR lr, [sp, #0]
	STR r4, [sp, #4]
	STR r5, [sp, #8]
	# move r0 in to r4. This is the n value in F(n)
	MOV r4, r0

	# if n is 0, return 0
	MOV r1, #1
	CMP r1, r4
	BEQ return //return 0 in r0

	# if n is 1, return 1
	MOV r1, #0
	CMP r1, r4
	BEQ return //return 0 in r0
	
	# now we subtract r0 by 1
	ADD r0, r4, #-1
	BL Fibonacci //call F(n-1)
	MOV r5, r0 // store F(n-1) in r5
	ADD r0, r4, #-2 // get n-2
	BL Fibonacci // call F(n-2), stored in r0
	ADD r0, r5, r0 // add f(n-2) and F(n-2)
	B return //not really needed


	return:
		LDR lr, [sp, #0]
		LDR r4, [sp, #4]
		LDR r5, [sp, #8]
		ADD sp, sp, #16
		MOV pc, lr

.data
# end Fibonacci

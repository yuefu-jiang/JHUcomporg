.text
.global main

main:
	SUB sp, sp, #4
	STR lr, [sp, #0]
	
	LDR r0, =promptm
	BL printf
	
	LDR r0, =format
	LDR r1, =num_m
	BL scanf

	LDR r6, =num_m
	LDR r6, [r6]

	LDR r0, =promptn
	BL printf

	LDR r0, =format
	LDR r1, =num_n
	BL scanf

	LDR r7, =num_n
	LDR r7, [r7]


	# recursive mult
	# r0: m
	# r1, n
	# MOV r0, #10
	# MOV r1, #5

	MOV r0, r6
	MOV r1, r7
	BL Mult
	MOV r1, r0
	LDR r0, =output
	BL printf

	# Return to the OS
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr
.data
	format: .asciz "%d"
	num_m: .word 0
	num_n: .word 0
	promptm: .asciz "Input m: \n"
	promptn: .asciz "input n: \n"
	output: .asciz "m*n is %d\n"
# end main
.text
Mult:
	SUB sp, sp, #16
	STR lr, [sp, #0]
	STR r4, [sp, #4]
	STR r5, [sp, #8]
	# move m to r4 and n to r5
	MOV r4, r0
	MOV r5, r1

	# if r5 (n) is 1, return m
	CMP r5, #0
	BEQ return0 //return 0 in r0

	ADD r1, r5, #-1 //(n-1)
	BL Mult //return value in r0
	ADD r0, r4, r0 //return mult in r0
	B return //not really needed


	return0:
		MOV r0, #0
	return:
		LDR lr, [sp, #0]
		LDR r4, [sp, #4]
		LDR r5, [sp, #8]
		ADD sp, sp, #16
		MOV pc, lr

.data
# end sum

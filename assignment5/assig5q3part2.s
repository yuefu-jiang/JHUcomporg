.text
.global main
main:
	SUB sp, sp, #4
	STR lr, [sp]

	LDR r0, =prompt
	BL printf
	LDR r0, =formatStr
	LDR r1, =inch
	BL scanf

	# load inches to r0
	LDR r0, =inch
	LDR r0, [r0]
	# assign r1=12
	MOV r1, #12
	# execute division, r0 = int(r0/r1)
	BL __aeabi_idiv
	# store int value (which is the #of feet) in r4 for now
	MOV r4, r0
	
	# assign r1=12
	MOV r1, #12
	# move #feet to r0
	MOV r0, r4
	# multiply to get the inches represented by #feets
	MUL r0, r1, r4 //r0=12*r4
	
	# load the input total inches to r1
	LDR r1, =inch
	LDR r1, [r1]
	# subtract so that we get the remainder of inches that does not fit into feets
	SUB r1, r1, r0

	MOV r2, r1 //second number (remainder inches) from r1 to r2
	MOV r1, r4 //first number (feets) from r4 to r0
	
	# printf
	LDR r0, =output
	BL printf


	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
output: .asciz "Feet and inches are: %d\'%d\" \n"
prompt: .asciz "Input inches here: \n"
inch: .word 0
formatStr: .asciz "%d"

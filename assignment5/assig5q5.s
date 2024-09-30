.text
.global main
main:
	SUB sp, sp, #4
	STR lr, [sp]


	# load, print prompt and load val 1 and 2 to r4 and r5
	LDR r0, =prompt1
	BL printf
	LDR r0, =formatStr
	LDR r1, =val1
	BL scanf

	LDR r4, =val1
	LDR r4, [r4]

	LDR r0, =prompt2
	BL printf
	LDR r0, =formatStr
	LDR r1, =val2
	BL scanf

	LDR r5, =val2
	LDR r5, [r5]


	# xor swap r4 and r5's value
	# store result of eor into r4 
	# for example, xor 4 & 5 == 1, now r4 =1
	EOR r4, r4, r5
	# now xor 5 and 1 getting 4 and store into r5
	EOR r5, r5, r4
	# now that r5 = 4, xor 1 and 4 and get 5
	EOR r4, r5, r4

	# move swapped r4 and r5 to r1 and r2 for printing
	MOV r1, r4
	MOV r2, r5

	# printf
	LDR r0, =output
	BL printf

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
output: .asciz "The swapped values are: %d and %d\n"
prompt1: .asciz "Input the value of register 1: \n"
prompt2: .asciz "Input the value of register 2: \n"
val1: .word 0
val2: .word 0
formatStr: .asciz "%d"

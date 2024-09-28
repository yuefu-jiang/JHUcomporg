.text
.global main
main:
	SUB sp, sp, #4
	STR lr, [sp]

	LDR r0, =prompt
	BL printf
	LDR r0, =formatStr
	LDR r1, =num
	BL scanf
	# load the input number into r4
	LDR r4, =num
	LDR r4, [r4]

	# LSL num by 3 + LSL num by 1
	LSL r2, r4, #3 // r2 = Num * 2^3
	LSL r3, r4, #1 // r3 = num * 2^1
	# r1 = num*(2^3+2^1) = num*10
	ADD r1, r2, r3
	
	#printf
	LDR r0, =output
	BL printf


	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
output: .asciz "Your number * 10 is: %d \n"
prompt: .asciz "Input an integer here: \n"
num: .word 0
formatStr: .asciz "%d"

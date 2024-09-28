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
	
	# load num to r0
	LDR r0 ,=num
	LDR r0, [r0]
	# move not r0, this is the 1's complement
	MVN r0, r0
	# add 1 to become 2's complement
	ADD r0, r0, #1
	
	# move the value to r1 and load output to r0
	MOV r1, r0
	LDR r0, =output
	BL printf


	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
output: .asciz "The negative of the input int is: %d\n"
prompt: .asciz "Input a int here:\n"
num: .word 0
formatStr: .asciz "%d"

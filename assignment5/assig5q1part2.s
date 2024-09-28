.text
.global main
main:
	SUB sp, sp, #4
	STR lr, [sp]

	LDR r0, =prompt
	BL printf
	LDR r0, =formatStr
	LDR r1, =F
	BL scanf

	LDR r0, =F
	LDR r0, [r0]

	MOV r1, #32
	# this means r0 = r0-r1 (val)
	SUB r0, r0, r1
	# assign r1 = 5
	MOV r1, #5
	# r0=(F-32)<- r0 *5 <- r1
	MUL r0, r0, r1

	# actual division
	MOV r1, #9
	BL __aeabi_idiv

	# move r0 to r1 then load r0 w/ prompt
	MOV r1, r0
	LDR r0, =output
	BL printf


	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
output: .asciz "The converted temp in degree Fahrenheit is: %d degree Celsius\n"
prompt: .asciz "Input temp (degree Fahrenheit) here:\n"
F: .word 0
formatStr: .asciz "%d"

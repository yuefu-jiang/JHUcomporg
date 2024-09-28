.text
.global main
main:
	SUB sp, sp, #4
	STR lr, [sp]
	
	LDR r0, =prompt
	BL printf
	LDR r0, =formatStr
	LDR r1, =C
	BL scanf
	
	LDR r0, =C
	LDR r0, [r0]
	MOV r1, #9
	# this means r0 = r0*r1 (val)
	MUL r0, r0, r1
	# assign r1 = 5
	MOV r1, #5
	# division: r0 = C*9/5
	BL __aeabi_idiv

	# assign r1 =32
	MOV r1, #32
	# r0 = r0+r1 <-32
	ADD r0, r0, r1

	# move r0 to r1 then load r0 w/ prompt
	MOV r1, r0
	LDR r0, =output
	BL printf


	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
output: .asciz "The converted temp degree Celsius is: %d degree Fahrenheit\n"
prompt: .asciz "Input temp (degree Celcius) here:\n"
C: .word 0
formatStr: .asciz "%d"

.text 
.global main
main:
	# create the work space
	SUB sp, sp, #4
	STR lr, [sp, #0]
	# input
	LDR r0, =prompt
	BL printf
	# load input scanf
	LDR r0, =userInput
	LDR r1, =num
	# move r1 to sp so that vload is possible
	MOV r1, sp
	BL scanf
	
	# vector load s0 and then vector convert from float to double
	VLDR s0, [sp]
	VCVT.F64.F32 d0, s0
	# load out format and vector move the double converted above
	LDR r0, =format
	VMOV r1, r2, d0
	BL printf


	# return to os
	# somehow throws seg fault here??
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	num: .word 0
	prompt: .asciz "Enter a float:\n"
	userInput: .asciz "%f"
	format: .asciz "Your float is %f \n"


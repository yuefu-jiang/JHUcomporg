.text
.global main
main:
	SUB sp, sp, #4
	STR lr, [sp]
	
	# load prompt1, get feet input
	LDR r0, =prompt1
	BL printf
	LDR r0, =formatStr
	LDR r1, =ft
	BL scanf
	
	# store in r4
	LDR r4, =ft
	LDR r4, [r4]
	
	# get inches input
	LDR r0, =prompt2
	BL printf
	LDR r0, =formatStr
	LDR r1, =inch
	BL scanf
	
	# store in r5
	LDR r5, =inch
	LDR r5, [r5]
	
	# assign r1=12
	MOV r1, #12
	# multiply r4=feet*12
	MUL r4, r4, r1
	
	# add r4 = feet*12 + inches
	ADD r4, r4, r5
	# move the final inches to r1 for printf
	MOV r1, r4

	LDR r0, =output
	BL printf


	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
output: .asciz "The inches are: %d \n"
prompt1: .asciz "Input feet here: \n"
prompt2: .asciz "Input inches here: \n"
ft: .word 0
inch: .word 0
formatStr: .asciz "%d"

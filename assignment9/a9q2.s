.text
.global main
main:
	# create the work space
	SUB sp, sp, #4
	STR lr, [sp]
	
	# input1, name
	LDR r0, =prompt1
	BL printf

	# scanf
	# this will store first name and last name
	LDR r0, =nameFormat
	LDR r1, =fn
	LDR r2, =ln
	BL scanf
	
	
	# input2, score
	LDR r0, =prompt2
	BL printf
	
	# scanf for score
	LDR r0, =scoreInput
	LDR r1, =score
	BL scanf

	# store score int in r4 for comparison
	LDR r4, =score
	LDR r4, [r4]
	
	# if block
	# check invalid input first
		CMP r4, #0
		BLT invalidScore
		CMP r4, #100
		BGT invalidScore
		
		# after ruling out instances <0 or >100, goto grade A
		B gradeA
	
	# block for invalid error	
	# B end after print
	invalidScore:		
		LDR r0, =errorMsg
		BL printf
		B endif
	
	# print grade A, if not > 90, goto B
	gradeA:
		MOV r0, #90
 		CMP r4, r0
 		BLT gradeB

		LDR r0, =msg_A
		LDR r1, =fn
		LDR r2, =ln
		BL printf
		B endif

	# print B, if not>80 goto C
	gradeB:
		MOV r0, #80
		CMP r4, r0
		BLT gradeC

		LDR r0, =msg_B
		LDR r1, =fn
		LDR r2, =ln
		BL printf

		B endif
	# simillarly for C
	gradeC:
		MOV r0, #70
		CMP r4, r0
		BLT gradeD

		LDR r0, =msg_C
		LDR r1, =fn
		LDR r2, =ln
		BL printf

		B endif
	# same for D
	gradeD:
		MOV r0, #60
		CMP r4, r0
		BLT gradeF

		LDR r0, =msg_D
		LDR r1, =fn
		LDR r2, =ln
		BL printf

		B endif
	# for F, just print and exit since there's no grade lower than F
	gradeF:

		LDR r0, =msg_F
		LDR r1, =fn
		LDR r2, =ln
		BL printf

		B endif
	# end and pop stack
	endif:
		LDR lr, [sp]
		ADD sp, sp, #4
		MOV pc, lr
	
	
.data
	prompt1: .asciz "Please input student's name(first AND last): \n"
	prompt2: .asciz "Please input student's score (0-100): \n"
	errorMsg: .asciz "Input grade out of range!\n"
	msg_A: .asciz "%s %s's grade is A\n"
	msg_B: .asciz "%s %s's grade is B\n"
	msg_C: .asciz "%s %s's grade is C\n"
	msg_D: .asciz "%s %s's grade is D\n"
	msg_F: .asciz "%s %s's grade is F\n"
	fn: .space 40
	ln: .space 40
	score: .word 0
	scoreInput: .asciz "%d"
	nameFormat: .asciz "%s %s"


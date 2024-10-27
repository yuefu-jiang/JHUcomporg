.global findMaxOf3
.global main

.text 
	main:
		# push stack
		SUB sp, sp, #4
		STR lr, [sp, #0]

		# printf number1
		LDR r0, =prompt1
		BL printf

		# scanf number1
		LDR r0, =format
		LDR r1, =num1
		BL scanf

		# store num1 in r5 for now
		LDR r5, =num1
		LDR r5, [r5]

		# printf number2
		LDR r0, =prompt2
		BL printf

		# scanf number2
		LDR r0, =format
		LDR r1, =num2
		BL scanf

		# store num2 in r6 for now
		LDR r6, =num2
		LDR r6, [r6]

		# printf number3
		LDR r0, =prompt3
		BL printf

		# scanf number3
		LDR r0, =format
		LDR r1, =num3
		BL scanf

		# store num3 in r7 for now
		LDR r7, =num3
		LDR r7, [r7]

		# Move to r1, r2, and r3
		MOV r1, r5
		MOV r2, r6
		MOV r3, r7

		# call findMaxOf3(r1, r2, r3) 
		BL findMaxOf3
		
		# since find Max of 3 will have return val in r1, printf directly
		LDR r0, =output
		BL printf


		# pop stack
		LDR lr, [sp, #0]
		ADD sp, sp, #4
		MOV pc, lr

	findMaxOf3:
		# push stack
		SUB sp, sp, #4
		STR lr, [sp, #0]

		# compare r1 and r2
		# if r1 <= r2: r1 = r2 else do nothing
		CMP r1, r2
		ADDLT r1, r2, #0 //add r2+0 if r1 <r2

		# now r1 have the greater of the 2 values in r1 and r2

		# compare (now) r1 and r3
		# same logic to above
		CMP r1, r3
		ADDLT r1, r3, #0 // add r3+0 and assign to r1 if r1<r3

		# now r1 should have the greatest of 3 numbers

		# pop stack
		LDR lr, [sp, #0]
		ADD sp, sp, #4
		MOV pc, lr

#END findMaxOf3

.data
	prompt1: .asciz "input first number: \n"
	prompt2: .asciz "input second number: \n"
	prompt3: .asciz "input third number: \n"
	format: .asciz "%d"
	num1: .word 0
	num2: .word 0
	num3: .word 0
	output: .asciz "The largest of the 3 is: %d\n"

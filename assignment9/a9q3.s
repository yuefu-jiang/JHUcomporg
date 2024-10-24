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

		# 3 numbers are stored in r1, r2, and r3
		# Compare pairs r1r2 => store large in r4
		# compare r3r4 => store large in r4
		# return whatever val in r4
		# always store the largest in r4
		# init r4 @0
		MOV r4, #0

		# if block
		# if r1 >= r2, BGE => MOV r4, r1
		CMP r1, r2
		BGE GreaterOrEqualFirst
		# elif r1 < r2, BLT => MOV r4, r2
		MOV r4, r2
		B secondCompare

		# r1 is greater
		GreaterOrEqualFirst:
			MOV r4, r1
			B secondCompare
		
		secondCompare:

			# 2nd if block, r3 vs r4
			# if r3 >= r4, BGE => MOV r5, r3
			# store largest in r5
			CMP r3, r4
			BGE GreaterOrEqualSecond
			# elif r3 < r4, BLT => MOV r5, r4
			MOV r5, r4
			B end
			GreaterOrEqualSecond:
				MOV r5, r3
				B end

		end:
			# return in r1
			MOV r1, r5


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

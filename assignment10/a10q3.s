.global main
.global rand

.text 
	main:
		# push stack
		SUB sp, sp, #4
		STR lr, [sp, #0]

		# printf
		LDR r0, =prompt1
		BL printf

		# scanf for maximum value
		LDR r0, =format
		LDR r1, =max
		BL scanf
		# load value in r1 for max
		LDR r1, =max
		LDR r1, [r1, #0]

		# check for invalid value
		CMP r1, #1
		BLE error

		MOV r6, r1 // store max in r6

		BL rand // run random function, have result in r0
		MOV r7, r0 // move to r7 (see dict)
		
		MOV r0, r7
		MOV r1, r0
		LDR r0, =format
		BL printf
		# starting the loop from here;
		# register dict
		# r4: counter
		# r5: current user input 
		# r6: Designated maximum of the range from user
		# r7: correct number genrated by rand function

		# this loops until user get the correct number
		# init r4 with 0
		MOV r4, #0
		start_q3:
			# printf for prompt2, guess
			LDR r0, =prompt2
			BL printf

			# scanf for guessed value
			LDR r0, =format
			LDR r1, =guess
			BL scanf


			LDR r5, =guess
			LDR r5, [r5, #0] // now r5 has the value

			CMP r5, #-1 //provide an excape if one get bored
			BEQ exitq3

			ADD r4, r4, #1

			CMP r5, r7
			BEQ correctGuess
			CMP r5, r7
			BNE wrongGuess


		error: 
			LDR r0, =error_msg
			BL printf
			B exitq3

		correctGuess:
			# move r4 (the counter) to r1 and print message
			MOV r1, r4
			LDR r0, =correct
			BL printf
			B endq3loop

		wrongGuess:
			# print wrong guess message
			LDR r0, =wrong
			BL printf
			# loop back to start loop
			B start_q3

		exitq3:
			LDR r0, =exit
			BL printf

		endq3loop:
			# pop stack
			LDR lr, [sp, #0]
			ADD sp, sp, #4
			MOV pc, lr

.data
prompt1: .asciz "Enter the upper bound of the number range: \n"
prompt2: .asciz "Enter your guess here:\n"
correct: .asciz "You got it! It took you %d guess to get it.\n"
wrong: .asciz "Nope!\n"
exit: .asciz "Exiting...\n"
error_msg: .asciz "Error: Invalid number!\n"
format: .asciz "%d"
max: .word 0
guess: .word 0
# end main
.text
	# a pseudo random num generator
	# algorithm LCG: https://en.wikipedia.org/wiki/Linear_congruential_generator
	# input r1 has the maximum, returns the random number in r0
	rand:
		# push stack
		SUB sp, sp, #4
		STR lr, [sp, #0]

		LDR r2, =seed		 @ Load the address of the seed
		LDR r3, [r2]		  @ Load the current seed value (16-bit)

		# LFSR feedback with polynomial x^16 + x^14 + 1
		MOV r0, r3, LSR #1	@ Shift seed right by 1
		EOR r0, r0, r3, LSR #2   @ XOR feedback from bit 14

		STR r0, [r2]		  @ Store the updated seed back in memory

		ADD r0, r0, #1		@ Ensure result is non-zero by adding 1
		CMP r1, #1			@ Check if max range (r1) <= 1
		BLE done			  @ If max range <= 1, return 1

		# Scale to range 1 to r1 by using simple masking (for small ranges)
        scale_loop:
		CMP r0, r1			@ Check if r0 < max range
		BLT done			  @ If r0 < r1, we're done
		SUB r0, r0, r1		@ Wrap around if r0 >= r1
		B scale_loop		  @ Repeat until r0 is within range

	done:
		LDR lr, [sp, #0]
		ADD sp, sp, #4
		MOV pc, lr
.data
	seed: .word 233
# end rand

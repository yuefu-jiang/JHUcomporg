.global main
.global remainder

.text 
	main:
		# push stack
		SUB sp, sp, #12
		STR lr, [sp, #0]
		STR r4, [sp, #4]
		STR r5, [sp, #8]
		STR r6, [sp, #12]
		start:
			# printf
			LDR r0, =prompt
			BL printf

			# scanf
			LDR r0, =format
			LDR r1, =num
			BL scanf

			# starting the loop from here;
			# register dict
			# r4: counter. this will start from 2 as it also served as the starting number of the divisor
			# r5: maximum val to stop, should == num /2
			# r6: the input num

			LDR r5, =num
			LDR r5, [r5, #0]

			CMP r5, #3
			BLT invalidOrExit

			MOV r6, r5 //for now r5 and r6 have the same value at start
			MOV r4, #2 //assign 2 to r4, the counter

			# calculate the propose maximum value of the counter
			# r5 = num /2
			# still store in r5
			MOV r0, r5
			MOV r1, #2
			BL __aeabi_idiv
			MOV r5, r0


			# this loops until counter equals maximum, i.e. num/2
		start_inner:
			CMP r6, #3
			BEQ isPrime // edge case where 1st comparison will not be equal since division inaccuracy
			CMP r6, #4
			BEQ notPrime //this is a edge case where the first comparison will equal.
			CMP r4, r5
			BEQ isPrime //if counter == maximum, this is a prime

			# if not prime yet, check if remainder is 0
			MOV r0, r6
			MOV r1, r4
			BL remainder // implemented remainder function below
			CMP r0, #0
			BEQ notPrime

			ADD r4, r4, #1 // counter += 1
			B start_inner

		invalidOrExit: 
		# only if something is less than 3, 
		# exit if -1 else invalid
			CMP r5, #-1
			BGT invalid
			CMP r5, #-1
			BEQ exitmain
			CMP r5, #-1
			BLT invalid

		isPrime:
			# move r6 (the num) to r1 and print message
			MOV r1, r6
			LDR r0, =is_prime
			BL printf
			B start

		notPrime:
			# move r6 (the num) to r1 and print message
			MOV r1, r6
			LDR r0, =not_prime
			BL printf
			B start
		invalid:
			LDR r0, =error_msg
			BL printf
			B start

		exitmain:
			LDR r0, =exit
			BL printf

		endmain:
			# pop stack
			LDR lr, [sp, #0]
			LDR r4, [sp, #4]
			LDR r5, [sp, #5]
			LDR r6, [sp, #6]
			ADD sp, sp, #12
			MOV pc, lr

.data
prompt: .asciz "Enter a number greater than 3 (-1 to exit): \n"
is_prime: .asciz "Number %d is prime\n"
not_prime: .asciz "Number %d is not prime\n"
error_msg: .asciz "Error: Invalid number\n"
exit: .asciz "Exiting...\n"
format: .asciz "%d"
num: .word 0

# end main

.text 
remainder:
	# push stack
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# expect r0: dividend r1: divisor
	# return remainder; if error return -1
	CMP r1, #0
	BEQ error // divisior cannot be 0

	loop:
		CMP r0, r1
		BLT end //if r1 > r0, remainder is in r0 already
		SUB r0, r0, r1 // r0=r0-r1 until r1>r0
		B loop

	error:
		MOV r0, #-1
	end:
		# pop stack
		LDR lr, [sp, #0]
		ADD sp, sp, #4
		MOV pc, lr

.data
# end remainder

.global remainder

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

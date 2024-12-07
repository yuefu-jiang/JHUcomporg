# total_num = 0
# counter = 0
# status = True
# while status==true:
# 	counter += 1
# 	curr_num = userinput
# 	total_num += curr_num
# 	average = total_num/counter
# 	print(curr_num, total_num, average)
# 	if curr_num == -1:
# 		status = false

.global main
.text
main:
# push stack
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# r5: current number
	# r6: counter
	# r7: total
	# r8: average
	MOV r5, #0
	MOV r6, #0
	MOV r7, #0
	MOV r8, #0

	while_loop:
		# printf
		LDR r0, =prompt
		BL printf

		# scanf
		LDR r0, =format
		LDR r1, =num
		BL scanf

		# Load num to r5
		LDR r5, =num
		LDR r5, [r5]
		
		# if r5 == -1, end program
		CMP r5, #-1
		BEQ end

		# add 1 to counter
		ADD r6, r6, #1
		# add previous total with current number
		ADD r7, r7, r5

		# r0/r1, store in r0
		MOV r0, r7
		MOV r1, r6
		BL __aeabi_idiv
		# store average in r8
		MOV r8, r0

		# print results

		# print current number in r5
		MOV r1, r5
		LDR r0, =out_cur
		BL printf

		# print current number in r5
		MOV r1, r7
		LDR r0, =out_tot
		BL printf

		# print current number in r5
		MOV r1, r8
		LDR r0, =out_ave
		BL printf

		B while_loop
	end:
		# pop stack
		LDR lr, [sp, #0]
		ADD sp, sp, #4
		MOV pc, lr


.data
	prompt: .asciz "---- Enter -1 to stop loop ----\nPlease enter a positive integer: \n"
	format: .asciz "%d"
	num: .word 0
	out_cur: .asciz "The current input is %d. \n"
	out_tot: .asciz "The total of all inputs is %d. \n"
	out_ave: .asciz "The average of all inputs is %d. \n"

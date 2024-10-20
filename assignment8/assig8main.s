.text
.global main

main:
	# push stack
	SUB sp, sp, #4
	STR lr, [sp, #0]
	# print welcome message
	LDR r0, =welcome
	BL printf
	
	# part1, calling miles2 kilometer
	# load miles from prompt
	LDR r0, =prompt_m2k
	BL printf
	
	# scanf
	LDR r0, =formatStr
	LDR r1, =mi	
	BL scanf
	
	# move miles to r0 and BL method in lib
	LDR r0, =mi
	LDR r0, [r0, #0]
	BL miles2kilometer
	MOV r1, r0

	LDR r0, =output_m2k
	BL printf

	LDR r0, =divider
	BL printf
	
	#part2, calling kph
	LDR r0, =prompt1_kph
	BL printf

	LDR r0, =formatStr
	LDR r1, =mi2
	BL scanf
	
	#Store mile2 in r4 for now
	LDR r4, =mi2
	LDR r4, [r4]

	LDR r0, =prompt2_kph
	BL printf
	
	LDR r0, =formatStr
	LDR r1, =hr
	BL scanf

	#move r4's mile to r0 for KPH to BL miles3kilos within
	MOV r0, r4
	LDR r1, =hr
	LDR r1, [r1]


	# now input values in r0 and r1
	# BL kph
	BL kph
	MOV r1, r0
	
	# print results
	LDR r0, =output_kph
	BL printf
	
	LDR r0, =divider
	BL printf
	
	# part3, calling c2f
	LDR r0, =prompt_c2f
	BL printf
	#scanf
	LDR r0, =formatStr
	LDR r1, =celsius
	BL scanf

	# load c to r0
	LDR r0, =celsius
	LDR r0, [r0]
	# call method
	BL CToF
	MOV r1, r0

	LDR r0, =output_c2f
	BL printf

	LDR r0, =divider
	BL printf

	# part4, calling inches to Feet

	LDR r0, =prompt_i2f
	BL printf

	LDR r0, =formatStr
	LDR r1, =inches
	BL scanf

	# load inches to r0
	LDR r0, =inches
	LDR r0, [r0]
	
	BL InchesToFt
	MOV r1, r0

	LDR r0, =output_i2f
	BL printf 	

	# push stack
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
output_m2k: .asciz "kilometer is: %d\n"
prompt_m2k: .asciz "Part 1: convert miles to kilometers. \nInput the value of miles: \n"
mi: .word 0
formatStr: .asciz "%d"

output_kph: .asciz "KPH is: %d \n"
prompt1_kph: .asciz "Part 2: input miles and hours and calculate KPH.\nInput miles: \n"
prompt2_kph: .asciz "input hours: \n"
mi2: .word 0
hr: .word 0

output_c2f: .asciz "Degree F is: %d\n"
prompt_c2f: .asciz "Part 3: convert degree C to F.\nInput degree C: \n"
celsius: .word 0

output_i2f: .asciz "Converted Feets are: %d\n"
prompt_i2f: .asciz "Part 4: convert inches to feets.\nInput inches: \n"
inches: .word 0

divider: .asciz "\n================================\n\n"
welcome: .asciz "\n\t Welcome to Assignment 8! \n Each part will prompt you for a integer input.\n ==========================\n"

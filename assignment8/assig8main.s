.text
.global main

main:
	# push stack
	SUB sp, sp, #4
	STR lr, [sp, #0]
	
	# part1, calling miles2 kilometer
	# load miles from prompt
	LDR r0, =prompt_m2k
	BL printf

	LDR r0, =formatStr
	LDR r1, =mi	
	BL scanf
	
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

	# store hour in r5
	LDR r5, =hr
	LDR r5, [r5]
	#move r4's mile to r0 for KPH to BL miles3kilos within
	MOV r0, r4

	BL kph
	MOV r1, r0

	LDR r0, =output_kph
	BL printf
	
	LDR r0, =divider
	BL printf
	
	# part3, calling c2f
	LDR r0, =prompt_c2f
	BL printf

	LDR r0, =formatStr
	LDR r1, =celsius
	BL scanf

	# load c to r0
	LDR r0, =celsius
	LDR r0, [r0]

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
prompt_m2k: .asciz "Input the value of miles: \n"
mi: .word 0
formatStr: .asciz "%d"

output_kph: .asciz "KPH is: %d \n"
prompt1_kph: .asciz "Input miles: \n"
prompt2_kph: .asciz "input hours: \n"
mi2: .word 0
hr: .word 0

output_c2f: .asciz "Degree F is: %d\n"
prompt_c2f: .asciz "Input degree C: \n"
celsius: .word 0

output_i2f: .asciz "Converted Feets are: %d\n"
prompt_i2f: .asciz "Input inches: \n"
inches: .word 0

divider: .asciz "\n================================\n\n"

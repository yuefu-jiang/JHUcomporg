.global miles2kilometer
.global kph
.global CToF
.global InchesToFt

.text
	miles2kilometer:
	# push stack
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# miles = kilo*161/100
	# r0 = r0*161/100
	# the reason for multiplying 161 then dividing by 100 is that
	# 1. for integer operations like these, we apparently cannot just multiply by 1.61
	# 2. by multiplying first, we gain better accuracy since there should be less bits thrown away by the dividing step. 
	# say that we divide by 100 first then multiply by 161, it would render a lot of the cases be 0 unless the input is very large
	# or, if we multiply by 16 instead by 161, we lose that 1% precision.

	MOV r1, #161
	MUL r0, r0, r1
	MOV r1, #100
	# r0/r1
	BL __aeabi_idiv

	# push stack
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr
.data
#END miles2kilometer

.text
	kph:
	# push stack
	SUB sp, sp, #4
	STR lr, [sp]

	# r0 is miles and r1 is hours
	# move r1 to r3 to free up r1 for now
	MOV r4, r1
	BL miles2kilometer
	# hours is stored in r3
	# move it to r1 to complete the division
	MOV r1, r4
	# now r0 has km; r0/r1
	BL __aeabi_idiv

	# push stack
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
#END kph

.text
	CToF:
	# push stack
	SUB sp, sp, #4
	STR lr, [sp]

	# r0 has C
	# F = c*9/5 + 32
	# r0 = r0*9
	MOV r1, #9
	MUL r0, r0, r1

	# r0 = r0/5
	MOV r1, #5
	BL __aeabi_idiv

	# +32
	MOV r1, #32
	ADD r0, r0, r1

	# push stack
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
#END CToF

.text
	InchesToFt:
	# push stack
	SUB sp, sp, #4
	STR lr, [sp]

	# ft = ince/12

	MOV r1, #12
	BL __aeabi_idiv

	# push stack
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
#END InchesToFt

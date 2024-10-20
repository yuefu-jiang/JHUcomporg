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
	#MOV r0, #3
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

	# r0 is miles, r1 is hours
	BL miles2kilometer
	# hours is stored in r5
	# move it to r1 to complete the division
	MOV r1, r5
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

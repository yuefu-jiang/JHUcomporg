      .global main

main:
      PUSH    {LR}
      SUB     SP,    SP,    #8
      LDR     R0, =prompt1
      BL      printf

      LDR     R0, =scantype
      MOV     R1,    SP
      BL      scanf

      VLDR    S0,   [SP]
      VCVT.F64.F32   D0,    S0

      LDR     R0, =result
      VMOV    R1,    R2,   D0
      BL      printf

      ADD     SP,    SP,   #8
      POP     {PC}

      MOV     PC,    LR

     .data
prompt1:            .asciz "Enter first number: "
scantype:           .asciz "%f"
result:             .asciz "YOur entered number is %f.\n"

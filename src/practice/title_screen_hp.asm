TextTableHp:
  .db $EF, $DA, $E7, $E2, $E5, $E5, $DA, $FF, $FF, $FF, $FF, $FF ; Vanilla
  .db $E0, $E5, $E8, $DB, $DA, $E5, $FA, $ED, $E2, $E6, $DE, $EB ; Global Timer
  .db $EC, $EE, $DB, $FA, $E9, $E2, $F1, $DE, $E5, $FA, $F1, $FA ; Sub pixel X
  .db $EC, $EE, $DB, $FA, $E9, $E2, $F1, $DE, $E5, $FA, $F2, $FA ; Sub pixel Y
  .db $E5, $DA, $E0, $FA, $DF, $EB, $DA, $E6, $DE, $FA, $FA, $FA ; Lag Frame
  .db $EF, $DE, $E0, $E0, $C9, $FA, $E0, $E5, $E2, $ED, $DC, $E1 ; Vegg. Glitch
  .db $DC, $DA, $E7, $FA, $E3, $EE, $E6, $E9, $FA, $FA, $FA, $FA ; Can Jump
  .db $DC, $EE, $EC, $ED, $E8, $E6, $FA, $CB, $D0, $D0, $D0, $D0 ; CUSTOM $0000

IndexTableHp:
  .db $00, $0C, $18, $24, $30, $3C, $48, $54

HpAddressPointerLo:
  .db <byte_RAM_0
  .db <byte_RAM_10
  .db <PlayerXSubpixel
  .db <PlayerYSubpixel
  .db <DroppedFrames
  .db <byte_RAM_0
  .db <byte_RAM_0
  .db <byte_RAM_0

HpAddressPointerHi:
  .db >byte_RAM_0
  .db >byte_RAM_10
  .db >PlayerXSubpixel
  .db >PlayerYSubpixel
  .db >DroppedFrames
  .db >byte_RAM_0
  .db >byte_RAM_0
  .db >byte_RAM_0

HpFuncPointerLoTable:
  .db <AreaSecondaryRoutine_HealthBar
  .db <DrawHpPointer
  .db <DrawHpPointer
  .db <DrawHpPointer
  .db <DrawHpPointer
  .db <Sand
  .db <CanJump
  .db <DrawHpPointer

HpFuncPointerHiTable:
  .db >AreaSecondaryRoutine_HealthBar
  .db >DrawHpPointer
  .db >DrawHpPointer
  .db >DrawHpPointer
  .db >DrawHpPointer
  .db >Sand
  .db >CanJump
  .db >DrawHpPointer

HpOption:
  LDA Player1JoypadPress
  CMP #ControllerInput_Left
  BEQ DecreaseHpIndex

IncreaseHpIndex:
  LDX HpBarIndex
  INX
  CPX #$08
  BNE UpdateHpIndex
  LDX #$00
  BEQ UpdateHpIndex

DecreaseHpIndex:
  LDX HpBarIndex
  DEX
  BPL UpdateHpIndex
  LDX #$07

UpdateHpIndex:
  STX HpBarIndex
  LDA IndexTableHp, X
  TAX
  LDY #$00 ; Index for loop

LoopDumpDataHpOption:
  LDA TextTableHp, X
  STA PPUBuffer_TitleScreen_Hp_Option, Y
  INX
  INY
  CPY #$0C
  BNE LoopDumpDataHpOption

SetFuncPointer:
  LDX HpBarIndex
  LDA HpFuncPointerLoTable, X
  STA HpFuncPointerLo
  LDA HpFuncPointerHiTable, X
  STA HpFuncPointerHi

CheckIfCustomIndex:
  LDA HpBarIndex
  CMP #$07
  BEQ UpdateCustomHp

SetAdressPointerHp:
  LDX HpBarIndex
  LDA HpAddressPointerLo, X
  STA HpAddressLo
  LDA HpAddressPointerHi, X
  STA HpAddressHi

LeaveHp:
  JMP WaitThenJmpToLoop

; Logic here used to add carry like a 16 bit number, but since I added select I ended removing it.
HandleAB:
  LDX HpBarIndex
  CPX #$07
  BNE LeaveAB ; Check if our cursor index for the option is on custom
  AND #ControllerInput_B
  BNE DecreaseCustomHp

IncreaseCustomHp:
  LDA Player1JoypadHeld
  AND #ControllerInput_Select
  BNE IncHi

IncLo:
  INC CustomHpLo
  JMP UpdateCustomHp

IncHi:
  INC CustomHpHi
  LDA CustomHpHi
  CMP #$80
  BNE UpdateCustomHp
  LDA #$00
  STA CustomHpHi
  JMP UpdateCustomHp

DecreaseCustomHp:
  LDA Player1JoypadHeld
  AND #ControllerInput_Select
  BNE DecHi

DecLo:
  DEC CustomHpLo
  JMP UpdateCustomHp

DecHi:
  DEC CustomHpHi
  BPL UpdateCustomHp
  LDA #$7F
  STA CustomHpHi

UpdateCustomHp:
  LDX CustomHpHi
  STX HpAddressHi
  JSR SplitDigits
  STY PPUBuffer_Hp_Option_Hi
  STA PPUBuffer_Hp_Option_Hi + 1
  LDX CustomHpLo
  STX HpAddressLo
  JSR SplitDigits
  STY PPUBuffer_Hp_Option_Lo
  STA PPUBuffer_Hp_Option_Lo + 1

LeaveAB:
  JMP WaitThenJmpToLoop

; Value in X
; Tens Y
; Digits A
SplitDigits:
  TXA
  LSR A
  LSR A
  LSR A
  LSR A
  CLC
  ADC #$D0
  TAY
  TXA
  AND #$0F
  CLC
  ADC #$D0
  RTS

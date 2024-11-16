TextTableHp:
  .db $EF, $DA, $E7, $E2, $E5, $E5, $DA, $FF, $FF, $FF, $FF, $FF ; Vanilla
  .db $E0, $E5, $E8, $DB, $DA, $E5, $FA, $ED, $E2, $E6, $DE, $EB ; Global Timer
  .db $EC, $EE, $DB, $FA, $E9, $E2, $F1, $DE, $E5, $FA, $F1, $FA ; Sub pixel X
  .db $EC, $EE, $DB, $FA, $E9, $E2, $F1, $DE, $E5, $FA, $F2, $FA ; Sub pixel Y
  .db $E5, $DA, $E0, $FA, $DF, $EB, $DA, $E6, $DE, $FA, $FA, $FA ; Lag Frame
  .db $EF, $DE, $E0, $E0, $F9, $FA, $E0, $E5, $E2, $ED, $DC, $E1 ; Vegg. Glitch
  .db $DC, $DA, $E7, $FA, $E3, $EE, $E6, $E9, $FA, $FA, $FA, $FA ; Can Jump

IndexTableHp:
  .db $00, $0C, $18, $24, $30, $3C, $48

HpAddressPointerLo:
  .db <byte_RAM_0
  .db <byte_RAM_10
  .db <PlayerXSubpixel
  .db <PlayerYSubpixel
  .db <DroppedFrames
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

HpFuncPointerLoTable:
  .db <AreaSecondaryRoutine_HealthBar
  .db <DrawHpPointer
  .db <DrawHpPointer
  .db <DrawHpPointer
  .db <DrawHpPointer
  .db <CanJump
  .db <CanJump

HpFuncPointerHiTable:
  .db >AreaSecondaryRoutine_HealthBar
  .db >DrawHpPointer
  .db >DrawHpPointer
  .db >DrawHpPointer
  .db >DrawHpPointer
  .db >CanJump
  .db >CanJump

HpOption:
  LDA Player1JoypadPress
  CMP #ControllerInput_Left
  BEQ DecreaseHpIndex
IncreaseHpIndex:
  LDX HpBarIndex
  INX
  CPX #$07
  BNE UpdateHpIndex
  LDX #$00
  BEQ UpdateHpIndex
DecreaseHpIndex:
  LDX HpBarIndex
  DEX
  BPL UpdateHpIndex
  LDX #$06
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
SetAdressPointerHp:
  LDX HpBarIndex
  LDA HpAddressPointerLo, X
  STA HpAddressLo
  LDA HpAddressPointerHi, X
  STA HpAddressHi
LeaveHp:
  JMP WaitThenJmpToLoop

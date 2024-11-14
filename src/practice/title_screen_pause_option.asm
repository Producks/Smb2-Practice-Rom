PauseOptionTextTable:
  .db $DF, $E2, $F1, $DE, $DD, $FA ; Fixed
  .db $EE, $E9, $DD, $DA, $ED, $DE ; Update

LazyIndexTable:
  .db $00, $06

PauseSelect:
  LDA BoolDynamicPause
  EOR #$01
  STA BoolDynamicPause

FindIndexPauseSelect: ; LOL
  TAY
  LDA LazyIndexTable, Y
  TAY
  LDX #$00

DumpPauseSelectTextLoop:
  LDA PauseOptionTextTable, Y
  STA PPUBuffer_TitleScreen_Pause_Text, X
  INX
  INY
  CPX #$06
  BNE DumpPauseSelectTextLoop

LeavePauseOptionSelect:
  JMP WaitThenJmpToLoop

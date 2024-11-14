; Vanilla
; Global Timer
; Sub pixel X
; Sub pixel Y
; Lag Frame
; Vegg. Glitch

TextTableHp:
  .db $EF, $DA, $E7, $E2, $E5, $E5, $DA, $FF, $FF, $FF, $FF, $FF ; Vanilla
  .db $E0, $E5, $E8, $DB, $DA, $E5, $FA, $ED, $E2, $E6, $DE, $EB ; Global Timer
  .db $EC, $EE, $DB, $FA, $E9, $E2, $F1, $DE, $E5, $FA, $F1, $FA ; Sub pixel X
  .db $EC, $EE, $DB, $FA, $E9, $E2, $F1, $DE, $E5, $FA, $F2, $FA ; Sub pixel Y
  .db $E5, $DA, $E0, $FA, $DF, $EB, $DA, $E6, $DE, $FA, $FA, $FA ; Lag Frame
  .db $EF, $DE, $E0, $E0, $FA, $FA, $E0, $E5, $E2, $ED, $DC, $E1 ; Vegg. Glitch

HpPointerLo:
  .db <AreaInitialization_SetEnemyData

HpPointerHi:
  .db >AreaInitialization_SetEnemyData

HpOption:
  JMP WaitThenJmpToLoop

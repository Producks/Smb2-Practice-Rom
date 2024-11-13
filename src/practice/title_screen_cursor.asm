CursorYPosition:
  .db $AE, $BE, $CE

MoveCursor:
  CMP #ControllerInput_Up
  BEQ MoveCursorUp
MoveCursorDown: ; Default to moving down if up and down are being pressed at the same time
  INC CursorPosition
  LDY CursorPosition
  CPY #$03
  BNE UpdateCursor ; If no overflow, update the cursor directly
  LDY #$00
  STY CursorPosition
  JMP UpdateCursor

MoveCursorUp:
  DEC CursorPosition
  LDY CursorPosition
  BMI HandleUnderFlow
  JMP UpdateCursor
HandleUnderFlow:
  LDY #$02
  STY CursorPosition

UpdateCursor:
  LDA CursorYPosition, Y
  STA SpriteDMAArea
  STA SpriteDMAArea + 4
LeaveMoveCursor:
  JMP WaitThenJmpToLoop

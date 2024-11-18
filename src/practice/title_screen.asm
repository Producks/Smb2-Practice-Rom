.include "src/practice/init_title_screen.asm"

;- Loop of the title screen -; 
TitleScreenLoop:
ReadInput:
CheckStart:
	LDA Player1JoypadPress
	CMP #ControllerInput_Start
	BNE CheckUpDown
  JMP QuitTitleScreen

CheckUpDown:
  AND #ControllerInput_Up | ControllerInput_Down
  BNE MoveCursor

CheckLeftRight:
  LDA Player1JoypadPress
  AND #ControllerInput_Left | ControllerInput_Right
  BEQ CheckHeldLeftRight
  JMP HandleSideInputSingleTap

CheckHeldLeftRight:
  LDA Player1JoypadHeld
  AND #ControllerInput_Left | ControllerInput_Right
  BEQ CheckAB
  JMP HandleHeldInput

CheckAB:
  LDA Player1JoypadPress
  AND #ControllerInput_A | ControllerInput_B
  BEQ CheckHeldAB
  JMP HandleABInput

CheckHeldAB:
  LDA Player1JoypadHeld
  AND #ControllerInput_A | ControllerInput_B
  BEQ ResetHold
  JMP HandleHeldInputAB

ResetHold:
  LDA #$00 ; Reset held variables
  STA SideInputBuildUp
  STA SideInputCoolDown

WaitThenJmpToLoop:
  JSR AnimationTitleScreen
	JSR WaitForNMI_TitleScreen
  JMP ReadInput

;- Loop of the title screen end -; 

.include "src/practice/title_screen_cursor.asm"

SideInputFuncPointerLo:
	.db <LevelSelect
	.db <HpOption
	.db <PauseSelect

SideInputFuncPointerHi:
	.db >LevelSelect
	.db >HpOption
	.db >PauseSelect

HandleHeldInput:
  LDY CursorPosition
  BNE CheckAB ; Leave if we are not on the first option

  LDA SideInputBuildUp
  CMP #$20 ; Cooldown for how many frames we need to hold
  BEQ CooldownMatchHeldInput
  INC SideInputBuildUp
  JMP WaitThenJmpToLoop

CooldownMatchHeldInput:
  LDA SideInputCoolDown ; Add a cooldown of how many frames until it register
  BEQ RegisterInputHeld ; If cooldown is 0, branch and do the action
  DEC SideInputCoolDown
  JMP WaitThenJmpToLoop

RegisterInputHeld:
  LDA #$03 ; Constant for how many frames to wait for cooldown
  STA SideInputCoolDown
  LDA Player1JoypadHeld
  ORA Player1JoypadPress
  STA Player1JoypadPress
  JMP HandleSideInput

HandleSideInputSingleTap:
  LDA #$00 ; Reset held variables
  STA SideInputBuildUp
HandleSideInput:
  LDY CursorPosition
  LDA SideInputFuncPointerLo, Y
  STA SideInputLo
  LDA SideInputFuncPointerHi, Y
  STA SideInputHi
  JMP (SideInputLo)

HandleHeldInputAB:
  LDA SideInputBuildUp
  CMP #$10 ; Cooldown for how many frames we need to hold
  BEQ RegisterInputHeldx
  INC SideInputBuildUp
  JMP WaitThenJmpToLoop

CooldownMatchHeldInputx:
  LDA SideInputCoolDown ; Add a cooldown of how many frames until it register
  BEQ RegisterInputHeldx ; If cooldown is 0, branch and do the action
  DEC SideInputCoolDown
  JMP WaitThenJmpToLoop

RegisterInputHeldx:
  LDA #$01 ; Constant for how many frames to wait for cooldown
  STA SideInputCoolDown
  LDA Player1JoypadHeld
  ORA Player1JoypadPress
  STA Player1JoypadPress

HandleABInput:
  JMP HandleAB

.include "src/practice/title_screen_level_select.asm"

.include "src/practice/title_screen_hp.asm"

.include "src/practice/title_screen_pause_option.asm"

;- Leave title screen start -;

QuitTitleScreen:
;	LDA #$D0
;	JSR WaitTitleScreenTimer

	LDA #$00 ; ???
	TAY

ZeroMemoryAfterTitleScreen: ; CREATED MASSIVE BUG IF AUDIO WAS GOING, MADE ME LOSE 2 HOURS
	STA byte_RAM_0, Y
	INY
	CPY #$F0
	BCC ZeroMemoryAfterTitleScreen

  INC BoolWorld
	JMP HideAllSprites

PaletteTimerTable:
  .db $24, $08, $08, $08

PaletteColorTable:
  .db $27, $17, $07, $17

AnimationTitleScreen:
  INC byte_RAM_10 ; Increase global timer
  LDA byte_RAM_10
  CMP #$06
  BNE PaletteTitleScreen
  LDA #$00
  STA byte_RAM_10
ShyGuyAnimation:
  LDA ShyGuy_Left_GFX
  EOR #$04
  STA ShyGuy_Left_GFX
  LDA ShyGuy_Right_GFX
  EOR #$04
  STA ShyGuy_Right_GFX
  DEC ShyGuy_Left_X
  DEC ShyGuy_Right_X

PaletteTitleScreen:
  LDA PaletteTimerTitleScreen
  BNE DecreasePaletteTimerTitleScreen
  INC PaletteIndexTitleScreen
  LDA PaletteIndexTitleScreen
  CMP #$04
  BNE SetNewPaletteIndex
  LDA #$00

SetNewPaletteIndex:
  STA PaletteIndexTitleScreen

SetNewColorPalette:
  TAX
  LDA PaletteTimerTable, X
  STA PaletteTimerTitleScreen
  LDA PaletteColorTable, X
  STA PPUBuffer_TitleScreen_Palette

DecreasePaletteTimerTitleScreen:
  DEC PaletteTimerTitleScreen

ScreenUpdateTitleScreenLoop:
  LDA #$02 ; Screen update
  STA ScreenUpdateIndex
  RTS

;- Leave title screen end -;

; End of function TitleScreen

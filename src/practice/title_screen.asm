.include "src/practice/init_title_screen.asm"

;- Loop of the title screen -; 
TitleScreenLoop:
ReadInput:
	LDA Player1JoypadPress
	CMP #ControllerInput_Start
	BEQ QuitTrampoline
  AND #ControllerInput_Up | ControllerInput_Down
  BNE MoveCursor
  LDA Player1JoypadPress
  AND #ControllerInput_Left | ControllerInput_Right
  BNE HandleSideInput

WaitThenJmpToLoop:
  JSR AnimationTitleScreen
	JSR WaitForNMI_TitleScreen
  JMP ReadInput

QuitTrampoline:
  JMP QuitTitleScreen ; Address is too far to branch out, so let's do it this way

;- Loop of the title screen end -; 

.include "src/practice/title_screen_cursor.asm"

SideInputFuncPointerLo:
	.db <LevelSelect
	.db <PlaceHolder
	.db <PauseSelect

SideInputFuncPointerHi:
	.db >LevelSelect
	.db >PlaceHolder
	.db >PauseSelect

HandleSideInput:
  LDY CursorPosition
  LDA SideInputFuncPointerLo, Y
  STA SideInputLo
  LDA SideInputFuncPointerHi, Y
  STA SideInputHi
  JMP (SideInputLo)
PlaceHolder:
PlaceHolder01:
  JMP WaitThenJmpToLoop

.include "src/practice/title_screen_level_select.asm"

.include "src/practice/title_screen_pause_option.asm"

;- Leave title screen start -;

QuitTitleScreen:
;	LDA #$D0
;	JSR WaitTitleScreenTimer

	LDA #$00
	TAY

ZeroMemoryAfterTitleScreen: ; CREATED MASSIVE BUG IF AUDIO WAS GOING, MADE ME LOSE 2 HOURS
	STA byte_RAM_0, Y
	INY
	CPY #$F0
	BCC ZeroMemoryAfterTitleScreen

	JMP HideAllSprites


AnimationTitleScreen:
  INC byte_RAM_10 ; Increase global timer
  LDA byte_RAM_10
  CMP #$06
  BNE ScreenUpdateTitleScreenLoop
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
ScreenUpdateTitleScreenLoop:
  LDA #$02 ; Screen update
  STA ScreenUpdateIndex
  RTS

;- Leave title screen end -;

; End of function TitleScreen

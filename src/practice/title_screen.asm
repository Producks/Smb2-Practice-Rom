.include "src/practice/init_title_screen.asm"

;- Loop of the title screen -; 
TitleScreenLoop:
ReadInput:
	LDA Player1JoypadPress
	AND #ControllerInput_Start
	BNE QuitTitleScreen

WaitThenJmpToLoop:
  INC SpriteDMAArea
  INC SpriteDMAArea + 3
  INC SpriteDMAArea + 4
  INC SpriteDMAArea + 7
	JSR WaitForNMI_TitleScreen
  JMP ReadInput

;- Loop of the title screen end -; 

;- Leave title screen start -;

QuitTitleScreen:
	LDA #SoundEffect1_1UP
	STA SoundEffectQueue1
  LDA #Music2_StopMusic
	STA MusicQueue2
	LDA #$D0
;	JSR WaitTitleScreenTimer

	LDA #$00
	TAY

ZeroMemoryAfterTitleScreen: ; CREATED MASSIVE BUG IF AUDIO WAS GOING, MADE ME LOSE 2 HOURS
	STA byte_RAM_0, Y
	INY
	CPY #$F0
	BCC ZeroMemoryAfterTitleScreen

	JMP HideAllSprites

;- Leave title screen end -;

; End of function TitleScreen

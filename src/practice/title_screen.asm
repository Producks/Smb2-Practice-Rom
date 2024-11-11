TitleScreenPPUDataPointers:
	.dw PPUBuffer_301
	.dw TitleLayout
  .dw PPUBuffer_TitleScreenLevelSelect
  .dw PPUBuffer_TitleScreenHpBar


WaitForNMI_TitleScreen_TurnOnPPU:
	LDA #PPUMask_ShowLeft8Pixels_BG | PPUMask_ShowLeft8Pixels_SPR | PPUMask_ShowBackground | PPUMask_ShowSprites
	STA PPUMaskMirror

WaitForNMI_TitleScreen:
	LDA ScreenUpdateIndex
	ASL A
	TAX
	LDA TitleScreenPPUDataPointers, X
	STA RAM_PPUDataBufferPointer
	LDA TitleScreenPPUDataPointers + 1, X
	STA RAM_PPUDataBufferPointer + 1

	LDA #$00
	STA NMIWaitFlag
WaitForNMI_TitleScreenLoop:
	LDA NMIWaitFlag
	BPL WaitForNMI_TitleScreenLoop

	RTS


;- Initilization of the title screen and rendering -;
TitleScreen:

  LDY #$07 ; Does initialization of RAM.
	STY byte_RAM_1 ; This clears $200 to $7FF.
	LDY #$00
	STY byte_RAM_0
	TYA

InitMemoryLoop:
	STA (byte_RAM_0), Y ; I'm not sure if a different method of initializing memory
; would work better in this case.
	DEY
	BNE InitMemoryLoop

	DEC byte_RAM_1
	LDX byte_RAM_1
	CPX #$02
	BCS InitMemoryLoop ; Stop initialization after we hit $200.

loc_BANK0_9A53:
	LDA #$00
	TAY

InitMemoryLoop2:
	; Clear $0000-$00FF.
	; Notably, this leaves the stack area $0100-$01FF uninitialized.
	; This is not super important, but you might want to do it yourself to
	; track stack corruption or whatever.
	STA byte_RAM_0, Y
	INY
	BNE InitMemoryLoop2

	JSR LoadTitleScreenCHRBanks

	JSR ClearNametablesAndSprites

	LDA PPUSTATUS
	LDA #$3F
	LDY #$00
	STA PPUADDR
	STY PPUADDR

InitTitleBackgroundPalettesLoop:
	LDA TitleBackgroundPalettes, Y
	STA PPUDATA
	INY
	CPY #$20
	BCC InitTitleBackgroundPalettesLoop

	LDA #$01
	STA RAM_PPUDataBufferPointer
	LDA #$03
	STA RAM_PPUDataBufferPointer + 1
	LDA #Stack100_Menu
	STA StackArea
	LDA #PPUCtrl_Base2000 | PPUCtrl_WriteHorizontal | PPUCtrl_Sprite0000 | PPUCtrl_Background1000 | PPUCtrl_SpriteSize8x8 | PPUCtrl_NMIEnabled
	STA PPUCtrlMirror
	STA PPUCTRL
	JSR WaitForNMI_TitleScreen

DrawTitleScreen:
  ; Draw the title screen (ScreenUpdateIndex is using TitleScreenPPUDataPointers)
	LDA #$01 ; TitleLayout
	STA ScreenUpdateIndex
	JSR WaitForNMI_TitleScreen

  LDA #$02 ; Level update
  STA ScreenUpdateIndex
  JSR LoadDigitsLevelSelect
  JSR WaitForNMI_TitleScreen

	; Cue the music!
	LDA #Music1_Subspace
	STA MusicQueue1
	JSR WaitForNMI_TitleScreen_TurnOnPPU

 ;- End of initilization of the title screen and rendering -; 

;- Loop of the title screen -; 
TitleScreenLoop:
ReadInput:
	LDA Player1JoypadPress
	AND #ControllerInput_Start
	BNE QuitTitleScreen

WaitThenJmpToLoop:
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


LoadDigitsLevelSelect:
  LDY #$00
LoopLoadDigitsLevelSelect:
  LDA LevelSelectDigits, Y
  STA PPUBuffer_TitleScreenLevelSelect, Y
  INY
  CPY #$06
  BNE LoopLoadDigitsLevelSelect
Exitdigits:
  RTS

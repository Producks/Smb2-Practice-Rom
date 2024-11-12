TitleScreenPPUDataPointers:
	.dw PPUBuffer_301
	.dw TitleLayout
  .dw PPUBuffer_TitleScreenLevelSelect
  .dw PPUBuffer_TitleScreenHpBar

InitBufferLevelSelect:
  LDY #$00
LoopInitBufferLevelSelect:
  LDA LevelSelectDigits, Y
  STA PPUBuffer_TitleScreenLevelSelect, Y
  INY
  CPY #$07
  BNE LoopInitBufferLevelSelect
ExitInitBufferLevelSelect:
  RTS

InitBufferHp:
  LDY #$00
LoopInitBufferHp:
  LDA HpOption, Y
  STA PPUBuffer_TitleScreenHpBar, Y
  INY
  CPY #$10
  BNE LoopInitBufferHp
ExitInitBufferHp:
  RTS


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
	LDA #PPUCtrl_Base2000 | PPUCtrl_WriteHorizontal | PPUCtrl_Sprite0000 | PPUCtrl_Background1000 | PPUCtrl_SpriteSize8x16 | PPUCtrl_NMIEnabled
	STA PPUCtrlMirror
	STA PPUCTRL
	JSR WaitForNMI_TitleScreen

DrawTitleScreen:
  ; Draw the title screen (ScreenUpdateIndex is using TitleScreenPPUDataPointers)
	LDA #$01 ; TitleLayout
	STA ScreenUpdateIndex
	JSR WaitForNMI_TitleScreen

  ; Setup PPU buffer in ram for level select
  LDA #$02 ; Level update
  STA ScreenUpdateIndex
  JSR InitBufferLevelSelect
  JSR WaitForNMI_TitleScreen

  LDA #$03
  STA ScreenUpdateIndex
  JSR InitBufferHp
  JSR WaitForNMI_TitleScreen

	; Cue the music!
	LDA #Music1_Subspace
	STA MusicQueue1
	JSR WaitForNMI_TitleScreen_TurnOnPPU

CursorFirstPart:
  LDA #$B0
  STA SpriteDMAArea
  LDA #$C1
  STA SpriteDMAArea + 1
  LDA #$00
  STA SpriteDMAArea + 2
  LDA #$30
  STA SpriteDMAArea + 3
CursorSecondPart:
  LDA #$B0
  STA SpriteDMAArea + 4
  LDA #$C3
  STA SpriteDMAArea + 5
  LDA #$00
  STA SpriteDMAArea + 6
  LDA #$38
  STA SpriteDMAArea + 7

 ;- End of initilization of the title screen and rendering -;

LevelSelect:
  AND #ControllerInput_Right
  BNE IncreaseLevelSelect
DecreaseLevelSelect:
  LDX CurrentLevel
  DEX
  BPL UpdateLevelSelect
  LDX #$13
  JMP UpdateLevelSelect ; change
IncreaseLevelSelect:
  LDX CurrentLevel
  INX
  CPX #$14
  BNE UpdateLevelSelect
  LDX #$00
UpdateLevelSelect:
  STX CurrentLevel
AdjustWorldLevelSelect:
  TXA
  LDY #$00
LoopFindCurrentNewWorld:
  INY
  CMP WorldStartingLevel, Y
	BCS LoopFindCurrentNewWorld ; If CurrrentLevel >= WorldStartingIndex branch
	DEY
	STY CurrentWorld
SetWorldNumberTitleScreen:
	LDA CurrentWorld
	TAY
	CLC
	ADC #$D1
	STA PPUBuffer_TitleScreen_World

SetCurrentLevelTitleScreen:
	LDA CurrentLevel
	SEC
	SBC WorldStartingLevel, Y
	CLC
	ADC #$D1
	STA PPUBuffer_TitleScreen_Level

  JMP WaitThenJmpToLoop

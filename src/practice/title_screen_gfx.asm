	TitleLayout:
  ; SUPER
	;                  SSSSSSSS  UUUUUUUU  PPPPPPPP  EEEEEEEE  RRRRRRRR
	.db $20, $4B, $0A, $00, $01, $08, $08, $FC, $01, $FC, $08, $FC, $01
	.db $20, $6B, $0A, $02, $03, $08, $08, $0A, $05, $0B, $0C, $0A, $0D
	.db $20, $8B, $0A, $04, $05, $04, $05, $0E, $07, $FC, $08, $0E, $08
	.db $21, $2B, $05, $06, $07, $06, $07, $09
	.db $21, $31, $04, $76, $09, $09, $09

	; MARIO
	;                  MMMMMMMMMMMMM  AAAAAAAA  RRRRRRRR  III  OOOOOOOO
	.db $20, $C6, $0A, $00, $0F, $01, $00, $01, $FC, $01, $08, $00, $01
	.db $20, $E6, $0A, $10, $10, $08, $10, $08, $10, $08, $08, $10, $08
	.db $21, $06, $0A, $08, $08, $08, $08, $08, $13, $0D, $08, $08, $08
	.db $21, $26, $0A, $08, $08, $08, $FC, $08, $0E, $08, $08, $08, $08
	.db $21, $46, $0A, $08, $08, $08, $10, $08, $08, $08, $08, $04, $05
	.db $21, $66, $0A, $09, $09, $09, $09, $09, $09, $09, $09, $06, $07

	; BROS
	;                  BBBBBBBB  RRRRRRRR  OOOOOOOO  SSSSSSSS
	.db $20, $D1, $08, $FC, $01, $FC, $01, $00, $01, $00, $01 ; BROS
	.db $20, $F1, $08, $10, $08, $10, $08, $10, $08, $10, $08
	.db $21, $11, $08, $13, $0D, $13, $0D, $08, $08, $77, $03
	.db $21, $31, $08, $0E, $08, $0E, $08, $08, $08, $12, $08
	.db $21, $51, $09, $13, $05, $08, $08, $04, $05, $04, $05, $08
	.db $21, $71, $09, $11, $07, $09, $09, $06, $07, $06, $07, $09

	; 2
	;             22222222222222222222222
	.db $21, $8E, $04, $14, $15, $16, $17
	.db $21, $AE, $04, $18, $19, $1A, $1B
	.db $21, $CE, $04, $1C, $1D, $1E, $1F
	.db $21, $EE, $04, $FC, $FC, $FC, $20
	.db $22, $0E, $04, $76, $76, $76, $21

  ; Practice rom Ver 0.1
  .db $22, $46, $14, $E9, $EB, $DA, $DC, $ED, $E2, $DC, $DE, $FA, $EB, $E8, $E6, $FA, $EF, $DE, $EB, $FA, $D0, $CF, $D1

  ; Level Select 1-1
  .db $22, $E8, $0C, $E5, $DE, $EF, $DE, $E5, $FB, $EC, $DE, $E5, $DE, $DC, $ED
;
; Delete save file
; Hp bar: Regular
DrawHpBar:
  .db $23, $28, $07, $E1, $E9, $FA, $DB, $DA, $EB, $CE

; Regular
; Global Timer
; Sub pixel X
; Sub pixel Y
; Lag Frame
; Vegg. Glitch

AttributeTitleScreen:
	.db $23, $CA, $04, $80, $A0, $A0, $20
	.db $23, $D1, $0E, $80, $A8, $AA, $AA, $A2, $22, $00, $00, $88, $AA, $AA, $AA, $AA, $22
	.db $23, $E3, $02, $88, $22
	.db $23, $EA, $04, $F0, $F8, $F2, $F0
	.db $00

IFDEF PAD_TITLE_SCREEN_PPU_DATA
	.pad TitleLayout + $300, $00
ENDIF

TitleBackgroundPalettes:
	.db $0F, $37, $16, $07 ; Most of screen, outline, etc.
	.db $22, $30, $31, $0F ; Unused
	.db $22, $30, $0F, $0F ; Logo
	.db $22, $30, $0F, $0F ; Copyright, Story

TitleSpritePalettes:
	.db $0F, $30, $28, $0F ; Unused DDP character palettes
	.db $22, $30, $25, $0F ; There are no sprites on the title screen,
	.db $22, $30, $12, $0F ; so these are totally unused
	.db $22, $30, $23, $0F

TitleAttributeData1:
	.db $23, $CB, $42, $FF
	.db $23, $D1, $01, $CC
	.db $23, $D2, $44, $FF
	.db $23, $D6, $01, $33
	.db $23, $D9, $01, $CC
	.db $23, $DA, $44, $FF

TitleAttributeData2:
	.db $23, $DE, $01, $33
	.db $23, $E1, $01, $CC
	.db $23, $E2, $44, $FF
	.db $23, $E6, $01, $33
	.db $23, $EA, $44, $FF
	.db $23, $E9, $01, $CC
	.db $23, $EE, $01, $33


LevelSelectDigits:
  .db $22, $F5, $03, $D1, $F4, $D1
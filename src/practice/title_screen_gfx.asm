	TitleLayout:
    .db $20, $84, $01, $B6
    .db $20, $85, $57, $B8
    .db $20, $9C, $01, $BA
    .db $20, $A4, $C9, $B4
    .db $20, $BC, $C9, $B5
    .db $20, $AF, $4D, $FD
    .db $20, $CF, $4D, $FD
    .db $20, $EF, $4D, $FD
    .db $21, $0F, $4D, $FD
    .db $20, $A5, $0A, $64, $66, $68, $68, $6A, $66, $64, $6C, $6A, $66
    .db $20, $C5, $0A, $84, $86, $88, $88, $88, $8A, $88, $8C, $88, $8E
    .db $20, $E5, $0A, $45, $47, $45, $49, $88, $4B, $45, $6C, $88, $4D
    .db $21, $05, $0A, $8F, $91, $8F, $91, $93, $FD, $8F, $8D, $93, $93
  
    .db $21, $25, $17, $64, $6E, $66, $64, $66, $6A, $66, $68, $64, $66, $FD, $6A, $66, $6A, $66, $64, $66, $64, $66, $FD, $FD, $64, $66

    .db $21, $45, $17, $88, $44, $44, $88, $44, $88, $44, $88, $88, $44, $FD, $88, $44, $88, $44, $88, $44, $88, $44, $FD, $FD, $88, $44

    .db $21, $65, $17, $88, $88, $88, $88, $88, $88, $8E, $88, $88, $88, $FD, $88, $8E, $88, $8E, $88, $88, $84, $46, $FD, $FD, $48, $4A
  
    .db $21, $85, $17, $88, $88, $88, $25, $27, $88, $29, $88, $88, $88, $FD, $88, $6F, $88, $4F, $88, $88, $8B, $89, $FD, $FD, $87, $85

    .db $21, $A5, $17, $88, $88, $88, $88, $65, $88, $88, $88, $45, $49, $FD, $88, $49, $88, $88, $45, $49, $45, $49, $67, $FD, $6B, $6D

    .db $21, $C4, $19, $B7, $9B, $9B, $9B, $9B, $9B, $9B, $9B, $9B, $95, $97, $B9, $9B, $97, $9B, $9B, $95, $97, $95, $97, $9B, $B9, $9B, $99, $BB
   ; .db $24, $C4, $0F, $


	; MARIO
	;                  MMMMMMMMMMMMM  AAAAAAAA  RRRRRRRR  III  OOOOOOOO
;	.db $20, $C6, $0A, $00, $0F, $01, $00, $01, $FC, $01, $08, $00, $01
;	.db $20, $E6, $0A, $10, $10, $08, $10, $08, $10, $08, $08, $10, $08
;	.db $21, $06, $0A, $08, $08, $08, $08, $08, $13, $0D, $08, $08, $08
;	.db $21, $26, $0A, $08, $08, $08, $FC, $08, $0E, $08, $08, $08, $08
;	.db $21, $46, $0A, $08, $08, $08, $10, $08, $08, $08, $08, $04, $05
;	.db $21, $66, $0A, $09, $09, $09, $09, $09, $09, $09, $09, $06, $07

	; BROS
	;                  BBBBBBBB  RRRRRRRR  OOOOOOOO  SSSSSSSS
;	.db $20, $D1, $08, $FC, $01, $FC, $01, $00, $01, $00, $01 ; BROS
;	.db $20, $F1, $08, $10, $08, $10, $08, $10, $08, $10, $08
;	.db $21, $11, $08, $13, $0D, $13, $0D, $08, $08, $77, $03
;	.db $21, $31, $08, $0E, $08, $0E, $08, $08, $08, $12, $08
;	.db $21, $51, $09, $13, $05, $08, $08, $04, $05, $04, $05, $08
;	.db $21, $71, $09, $11, $07, $09, $09, $06, $07, $06, $07, $09

	; 2
	;             22222222222222222222222
;	.db $21, $8E, $04, $14, $15, $16, $17
;	.db $21, $AE, $04, $18, $19, $1A, $1B
;	.db $21, $CE, $04, $1C, $1D, $1E, $1F
;	.db $21, $EE, $04, $FC, $FC, $FC, $20
;	.db $22, $0E, $04, $76, $76, $76, $21

  ; Practice rom Ver 0.1
  .db $22, $46, $14, $E9, $EB, $DA, $DC, $ED, $E2, $DC, $DE, $FA, $EB, $E8, $E6, $FA, $EF, $DE, $EB, $FA, $D0, $CF, $D1

  ; Level Select 1-1
  .db $22, $C8, $0C, $E5, $DE, $EF, $DE, $E5, $FB, $EC, $DE, $E5, $DE, $DC, $ED
;
; Delete save file
; Hp bar: Regular
DrawHpBar:
  .db $23, $08, $07, $E1, $E9, $FA, $DB, $DA, $EB, $CE

; Regular
; Global Timer
; Sub pixel X
; Sub pixel Y
; Lag Frame
; Vegg. Glitch

AttributeTitleScreen:
  .db $23, $F0, $48, $55
  .db $23, $F8, $48, $55
;	.db $23, $CA, $04, $20, $A0, $A0, $20
;	.db $23, $D1, $0E, $80, $A8, $AA, $AA, $A2, $22, $00, $00, $88, $AA, $AA, $AA, $AA, $22
;	.db $23, $E3, $02, $88, $22
;	.db $23, $EA, $04, $F0, $F8, $F2, $F0
	.db $00

IFDEF PAD_TITLE_SCREEN_PPU_DATA
	.pad TitleLayout + $300, $00
ENDIF

TitleBackgroundPalettes:
	.db $22, $29, $1A, $0F ; Most of screen, outline, etc.
	.db $0F, $36, $17, $0F ; Unused
	.db $22, $30, $0F, $0F ; Logo
	.db $22, $30, $0F, $0F ; Copyright, Story

TitleSpritePalettes:
	.db $22, $00, $10, $30 ; Unused DDP character palettes
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

UpdateTitleScreen:
  .db $22, $D5, $03, $D1, $F4, $D1 ; Level Select
  .db $23, $10, $0C, $E0, $E5, $E8, $DB, $DA, $E5, $FA, $ED, $E2, $E6, $DE, $EB ; Hp bar option
  .db $00

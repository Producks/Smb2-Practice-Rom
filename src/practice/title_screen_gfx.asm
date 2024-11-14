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

  ; Mario
  .db $20, $43, $05, $E6, $DA, $EB, $E2, $E8

  ; World Time
  .db $20, $52, $0B, $F0, $E8, $EB, $E5, $DD, $FA, $FA, $ED, $E2, $E6, $DE

  ; Score digits and coins
  .db $20, $63, $0C, $D0, $D0, $D0, $D0, $D0, $D0, $FF, $FF, $CC, $CD, $D0, $D0

  ; Practice rom Ver 0.1
  .db $21, $E9, $14, $E9, $EB, $DA, $DC, $ED, $E2, $DC, $DE, $FA, $EB, $E8, $E6, $FA, $EF, $DE, $EB, $FA, $1A, $1C, $1E

  ; Level Select 1-1
  .db $22, $4D, $0C, $E5, $DE, $EF, $DE, $E5, $FB, $EC, $DE, $E5, $DE, $DC, $ED

  ; Cloud
  .db $20, $C2, $02, $04, $06
  .db $20, $E1, $03, $03, $05, $07
  .db $21, $01, $03, $22, $24, $26

  ; Mushroom background
  .db $23, $1C, $04, $7C, $7E, $7C, $7E
  .db $23, $3C, $04, $7D, $7F, $7D, $7F

  ;treessss
  .db $22, $D6, $84, $59, $79, $98, $98
  .db $22, $D7, $84, $5B, $7B, $9A, $9A
  .db $22, $9A, $86, $59, $78, $78, $79, $98, $98
  .db $22, $9B, $86, $5B, $7A, $7A, $7B, $9A, $9A

; Hp bar: Regular
DrawHpBar:
  .db $22, $8D, $07, $E1, $E9, $FA, $DB, $DA, $EB, $CE

; Regular
; Global Timer
; Sub pixel X
; Sub pixel Y
; Lag Frame
; Vegg. Glitch

AttributeTitleScreen:
  .db $23, $C0, $48, $AA
  .db $23, $F0, $48, $55
  .db $23, $F8, $48, $55
  .db $23, $C9, $47, $55
  .db $23, $D1, $47, $55
  .db $23, $D9, $47, $55
  .db $23, $D6, $01, $DD
  .db $23, $DE, $01, $5D
  .db $23, $C2, $01, $EA
  .db $23, $C8, $01, $AA
  .db $23, $D0, $01, $AA
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
	.db $0F, $30, $21, $0F ; Logo
	.db $0F, $27, $17, $0F ; Copyright, Story

TitleSpritePalettes:
	.db $22, $16, $27, $18 ; Unused DDP character palettes
	.db $0F, $1A, $30, $27 ; There are no sprites on the title screen,
	.db $0F, $16, $30, $27 ; so these are totally unused
	.db $0F, $0F, $36, $17

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
  .db $20, $73, $03, $D1, $F4, $D1 ; Level Select
;  .db $23, $10, $0C, $E0, $E5, $E8, $DB, $DA, $E5, $FA, $ED, $E2, $E6, $DE, $EB ; Hp bar option
  .db $00

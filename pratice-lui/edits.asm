@include

; EndOfLevelSlotMachine
%org($0F, $E7EA)
		; always skip bonus
		jmp $E920
		
; BonusChanceLayout
; clean up bonus chance screen
%org($0A, $82AF)
		db $21, $6A, $0C, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB
		db $21, $8A, $0C, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB
		db $21, $AA, $0C, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB
		db $21, $CA, $0C, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB
		db $22, $0D, $02, $FB, $FB
		db $22, $2D, $02, $FB, $FB

; DoWorldWarp
; remove warp text
%org($0F, $E78E)
		nop
		nop
		nop
		nop
		
; LoseALife
; infinite lives
%org($00, $8A7D)
		inc !dont_reset_level_timer
		
; StartLevel
%org($0F, $E467)
		nop
		nop
		nop
		
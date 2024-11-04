@include

; NMI_Exit
%org($0F, $EC65)
		jmp nmi_exit
		
; NMI_AfterBackgroundAttributesUpdate
%org($0F, $EC22)
		jmp nmi_sprite_size_fix

; WaitForNMILoop
%org($0F, $EABD)
		jmp every_frame

; PreStartLevel
%org($0F, $E270)
		jsr pre_level_start

; AreaInitialization
%org($02, $801E)
		jsr level_init

; AreaSecondaryRoutine
%org($03, $BE0B)
		jsr level_tick
		
; PauseScreenLoop
%org($0F, $E51D)
		jsr pause_init
		nop
%org($0F, $E539)
		jmp pause_tick

; StartLevel
%org($0F, $E43B)
		jsr level_load_hijack
		lda #$90
		
%org($0F, $E470)
		lda #$90
		
; HorizontalLevel_Loop
%org($0F, $E48E)
		jsr level_load_finished
		
; VerticalLevel_Loop
%org($0F, $E4E2)
		jsr level_load_finished
		
; EndOfLevel
%org($0F, $E7B1)
		jmp pre_ending_scene
		
; EndOfLevelSlotMachine
%org($0F, $E7C0)
		jsr bonus_chance_load
%org($0F, $E7D4)
		jsr enable_nmi_8x8
%org($0F, $E7DF)
		jsr disable_nmi_8x8
%org($0F, $EA68)
		lda #$40
		sta !game_mode_0100
		jsr enable_nmi_8x8
		jmp $EAAB
	
; DoWorldWarp	
%org($0F, $E788)
		jsr warp_load
		
; InitializeSubArea
%org($0F, $E5A0)
		jsr sub_area_load

; loc_BANKF_E606
%org($0F, $E606)
		jsr sub_area_init
		
; loc_BANKF_E627
%org($0F, $E635)
		jsr sub_area_begin_exit
		nop
		nop
		nop
		
; ExitSubArea_Loop
%org($0F, $E65F)
		jsr sub_area_finish_exit
		
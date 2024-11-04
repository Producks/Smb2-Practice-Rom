@include

pause_init:
		; draw PAUSE text which will be static
		lda #$0D
		sta !vram_update_index
		; initalize selected level
		lda !current_world
		sta $0E
		lda !current_level
		sta $0F
		; initialize up/down hold counters
		lda #!level_select_holdoff
		sta $0C
		sta $0D
		rts
		
		
pause_tick:
		jsr update_timers
		
		; press up/down to select a level
		lda #$08
		bit !input_abetudlr_hold
		beq .not_holding_up
		bit !input_abetudlr_frame
		bne .inc_level
		; increase level every so often when holding up
		dec $0C
		bpl .not_holding_down
		lda #!level_select_speed
		sta $0C
	.inc_level:
		ldx $0F
		inx
		cpx #$14
		bcc +
		ldx #0
	+	stx $0F
		lda world_number_by_level,x
		sta $0E
		jmp .selected_level_changed
		
	.not_holding_up:
		lda #!level_select_holdoff
		sta $0C
		
		lda #$04
		bit !input_abetudlr_hold
		beq .not_holding_down
		bit !input_abetudlr_frame
		bne .dec_level
		; decrease level every so often when holding down
		dec $0D
		bpl .check_warp
		lda #!level_select_speed
		sta $0D
	.dec_level:
		ldx $0F
		dex
		bpl +
		ldx #$13
	+	stx $0F
		lda world_number_by_level,x
		sta $0E
		
	.selected_level_changed:
		jsr update_level_text
		bne .check_warp
		
	.not_holding_down:
		lda #!level_select_holdoff
		sta $0D
		
		; press select to warp to selected level
	.check_warp
		lda !input_abetudlr_frame
		and #$20
		bne .warp
		jmp $E521
		
	.warp:
		; see ResetAreaAndProcessGameMode
		jsr do_area_reset
		ldy #$0
		sty !game_mode
		sty !star_timer
		sty !big_veggies_pulled
		sty !cherry_count
		sty !stopwatch_timer
		sty !player_max_health
		sty !is_lock_open
		sty !is_1up_obtained
		sty !is_mushroom_1_obtained
		sty !is_mushroom_2_obtained
		sty !subspace_visit_count
		sty !player_lock
		sty !player_holding_item
		sty !carried_sprite_index
		sty !carried_over_sprite_index
		sty !player_x_velocity
		sty !player_y_velocity
		sty !player_y_velocity_init
		sty !is_player_in_rocket
		sty !veggie_thrower_counter
		sty !player_state_init
		sty !current_room_init
		sty !current_entry_page_init
		sty !transition_type_init
		sty !current_room
		sty !current_entry_page
		sty !transition_type
		sty !door_animation_timer
		sty !player_riding_carpet
		lda #$1F
		sta !player_health
		jsr level_initialization
		
		; set world and level numbers
		ldx $0E
		stx !current_world
		ldy $0F
		sty !current_level
		sty !current_level_init
		tya
		sec
		sbc world_starting_level,y
		sta !current_level_relative
				
		; destroy all sprites
		ldx #$08
		lda #0
	-	sta !sprite_id,x
		sta !sprite_state,x
		sta !sprite_grab_timer,x
		sta !sprite_projectile_timer,x
		dex
		bpl -
		
		lda #$C0
		sta !game_mode_0100
		jmp character_select_menu


; $0E: selected world number
; $0F: selected level number
; uses $03 and $0B
update_level_text:
		; world number
		ldx $0E
		inx
		txa
		ora #$D0
		sta !titlecard_world
		
		; clear level dots
		ldy #$06
		lda #$FB
	-	sta !titlecard_level_dots,y
		dey
		bpl -
		
		; level number
		ldy $0E
		lda $0F
		sec
		sbc world_starting_level,y
		sta $0B
		clc
		adc #$D1
		sta !titlecard_level
		
		; level dots
		lda world_starting_level+1,y
		sec
		sbc world_starting_level,y
		sta $03
		ldx #0
		ldy #0
	-	lda #$FD
		cpx $0B
		bne +
		lda #$F6
	+	sta !titlecard_level_dots,y
		iny
		iny
		inx
		cpx $03
		bcc -
		
		; screen update
		lda #$08
		sta !vram_update_index
		rts

		
world_number_by_level:
		db 0, 0, 0, 1, 1, 1, 2, 2
		db 2, 3, 3, 3, 4, 4, 4, 5
		db 5, 5, 6, 6
		
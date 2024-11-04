@include

pre_level_start:
		lda !dont_reset_level_timer
		bne +
		inc !reset_level_timer
	+	jmp $E1F4


level_init:
		sta !dropped_frames
		sta !room_timer_frames
		sta !room_timer_seconds
		sta !room_timer_minutes
		sta !dont_reset_level_timer
		inc !is_first_frame_of_room
		
		ldy !reset_level_timer
		beq +
		sta !real_frames_elapsed
		sta !level_timer_frames
		sta !level_timer_seconds
		sta !level_timer_minutes
		sta !reset_level_timer
	+
		inc !is_area_initialized
		rts
		
		
level_load_hijack:
		jsr hide_all_sprites
		lda !reset_level_timer
		bne .skip_timer_display
		inc !force_8x8_sprite_size
		jsr draw_sprite_timers
	.skip_timer_display:
		; jmp turn_off_ppu_except_sprites
		
		
turn_off_ppu_except_sprites:
		lda #$10
		jmp $EAA9
		
		
sub_area_load:
		lda #$10
		; rest of ClearNametablesAndSprites
		jsr $EC8C
		lda #$90
		sta !ppu_ctrl
		sta !ppu_ctrl_mirror
		inc !force_8x8_sprite_size
		jmp draw_sprite_timers
		

sub_area_begin_exit:
		jsr hide_all_sprites
		inc !force_8x8_sprite_size
		jsr draw_sprite_timers
		jmp turn_off_ppu_except_sprites
		
		
sub_area_finish_exit:
sub_area_init:
level_load_finished:
		jsr load_world_chr_banks
		lda #0
		sta !force_8x8_sprite_size
		jsr hide_all_sprites
		jmp wait_for_nmi_turn_on_ppu


warp_load:
		jsr draw_sprite_timers
		inc !force_8x8_sprite_size
		; jmp enable_nmi_8x8
		
		
enable_nmi_8x8:
		lda #$90
		sta !ppu_ctrl
		sta !ppu_ctrl_mirror
		rts


disable_nmi_8x8:
		lda #$10
		sta !ppu_ctrl
		sta !ppu_ctrl_mirror
		rts

		
bonus_chance_load:
		; jmp draw_sprite_timers


draw_sprite_timers:
		lda #$3B
		sta $06FA
		
		ldy #$00
		lda #!level_timer_y_pos
		sta $00
		lda #!level_timer_x_pos
		sta $01
		lda #!counters_attributes
		sta $02
		lda !level_timer_minutes
		jsr draw_decimal_counter
		lda !level_timer_seconds
		jsr draw_decimal_counter
		lda !level_timer_frames
		jsr draw_decimal_counter
		
		lda #!room_timer_y_pos
		sta $00
		lda #!room_timer_x_pos
		sta $01
		lda !room_timer_minutes
		jsr draw_decimal_counter
		lda !room_timer_seconds
		jsr draw_decimal_counter
		lda !room_timer_frames
		jsr draw_decimal_counter
		
		lda #!dropped_frames_y_pos
		sta $00
		lda #!dropped_frames_x_pos
		sta $01
		lda !dropped_frames
		; jmp draw_hex_counter
		
; input:
; $00 = y pos
; $01 = x pos
; $02 = attributes
; Y = oam index
draw_hex_counter:
		tax
		lsr
		lsr
		lsr
		lsr
		ora #$50
		sta $0201,y
		txa
		and #$0F
		ora #$50
		sta $0205,y
		
		lda $00
		sta $0200,y
		sta $0204,y
		
		lda $01
		sta $0203,y
		clc
		adc #8
		sta $0207,y
		adc #8
		sta $01
		
		lda $02
		sta $0202,y
		sta $0206,y
		
		tya
		adc #8
		tay
		rts

		
; input:
; $00 = y pos
; $01 = x pos
; $02 = attributes
; Y = oam index
draw_decimal_counter:
		%hex2dec(x)
		ora #$50
		sta $0205,y
		txa
		ora #$50
		sta $0201,y
		
		lda $00
		sta $0200,y
		sta $0204,y
		
		lda $01
		sta $0203,y
		adc #8
		sta $0207,y
		adc #8
		sta $01
		
		lda $02
		sta $0202,y
		sta $0206,y
		
		tya
		adc #8
		tay
		rts
		
		
pre_ending_scene:
		jsr hide_all_sprites
		inc !force_8x8_sprite_size
		jsr draw_sprite_timers
		; play jingle
		lda #$01
		sta !music_queue_2
		jsr delay_160_frames
		lda #0
		sta !force_8x8_sprite_size
		jmp $E956
		
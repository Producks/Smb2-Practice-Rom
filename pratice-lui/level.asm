@include

level_tick:
		jsr update_timers
		lda !sky_flash_timer
		rts

update_timers:
	.level_timer_tick:
		lda !level_timer_frames
		clc
		adc !real_frames_elapsed
		sta !level_timer_frames
		cmp #60
		bcc ..done
	..tick_seconds:
		sbc #60
		sta !level_timer_frames
		lda !level_timer_seconds
		adc #0
		sta !level_timer_seconds
		cmp #60
		bcc ..check_if_done
		
		sbc #60
		sta !level_timer_seconds
		lda !level_timer_minutes
		adc #0
		cmp #10
		bcc ..no_cap
		lda #59
		sta !level_timer_frames
		sta !level_timer_seconds
		lda #9
	..no_cap:
		sta !level_timer_minutes
		
	..check_if_done:
		lda !level_timer_frames
		cmp #60
		bcs ..tick_seconds
		
	..done:
			
	.room_timer_tick:
		lda !is_first_frame_of_room
		bne ..done
		lda !room_timer_frames
		clc
		adc !real_frames_elapsed
		sta !room_timer_frames
		cmp #60
		bcc ..done
		
		sbc #60
		sta !room_timer_frames
		lda !room_timer_seconds
		adc #0
		sta !room_timer_seconds
		cmp #60
		bcc ..done
		
		sbc #60
		sta !room_timer_seconds
		lda !room_timer_minutes
		adc #0
		cmp #10
		bcc ..no_cap
		lda #59
		sta !room_timer_frames
		sta !room_timer_seconds
		lda #9
	..no_cap:
		sta !room_timer_minutes
	..done:
	
		lda #0
		sta !real_frames_elapsed
		sta !is_first_frame_of_room
		rts
		
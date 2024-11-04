@include

every_frame:
		lda !counter_60hz
		sec
		sbc !previous_60hz
		beq .wait_for_nmi
		tay
		
		clc
		adc !real_frames_elapsed
		sta !real_frames_elapsed
		
		dey
		tya
		adc !dropped_frames
		bcc +
		lda #$FF
	+	sta !dropped_frames
		
		lda !counter_60hz
		sta !previous_60hz
		
	.wait_for_nmi:
		lda !nmi_flag
		bpl .wait_for_nmi
		rts

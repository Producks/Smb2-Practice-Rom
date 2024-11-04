@include

nmi_exit:
		inc !counter_60hz
		pla
		plp
		rti
		
nmi_sprite_size_fix:
		jsr $EC68
		lda !force_8x8_sprite_size
		bne +
		jmp $EC25
	+
		lda #$90
		jmp $EC27
		
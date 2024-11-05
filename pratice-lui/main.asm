norom

incsrc "defines.asm"

incsrc "edits.asm"
incsrc "hijacks.asm"

%org($0F, $ED4D)
print pc
warnpc $F000

%org($0F, $FB36)
incsrc "pause.asm"
print pc
warnpc $FE00

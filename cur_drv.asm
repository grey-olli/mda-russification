; This programm printed currency drive & directory
;Lust addition at 08-2-96
.MODEL tiny
.CODE
org 100h
begin:
push cs
pop ds
INCLUDE show.mac
mov ah,47h    ;DOS  function ,
xor dx,dx     ;search for default drive
lea si,my_name    ;this wood return error code in ax [if any]
int 21h
mov [my_name+66],'$'
show mess
int 20h
mess db 'This is current path :  '   ; macros
my_name db 64 dup(0)	; buffer for default drive&path must be 64 byte
dw 0			; this closed above string
end begin
;This programm make fool MDA screen pointing 1 symbol
;workable
c segment byte 'code'
assume cs:c,ds:c,es:c
org 100h
begin:
mov bx,0b000h ;(MDA)        ;*
mov ds,bx                   ;* 
mov cx,2000
xor bx,bx
cicl_:
mov ds:[bx],0f83h
add bx,2
loop cicl_

int 20h
c ends
end begin 

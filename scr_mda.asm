; This programm load symbols on screen (rubbish) on MDA adapter.
;
c segment byte 'code'
assume cs:c,ds:c,es:c
org 100h
begin:
mov bx,0b000h ;(MDA)        ;*
mov ds,bx                   ;* 
mov cx,2000
xor bx,bx
mov ax,10101011b
cicl_:
add ax,101b
mov ds:[bx],ax
add bx,2
loop cicl_
int 20h
c ends
end begin 

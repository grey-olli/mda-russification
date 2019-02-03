; This programm sets mda-mono 80825 mode via int 10h
cod segment para public
assume cs:cod,ds:cod,es:cod
org 100h
begin:
push cs
pop ds
lea dx,string
mov ah,9h
int 21h
mov ax,7h
int 10h
int 20h
;-----------
string db 'This sets MDA-mono 80*25 mode','$'
cod ends
end begin
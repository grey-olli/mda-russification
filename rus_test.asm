; This programm makes russian text string on MDA monitor

code_ segment byte public 'code'
assume cs:code_,ds:code_,es:code_
org 100h
begin:
push cs
pop ds
push cs
pop es
mov ah,9h
lea dx,mark
int 21h 
mov al,128
mov ah,9h
mov bx,0
mov cx,23
mov bl,15
int 10h
;! only AT-function !
;mov ah,0fh
;lea bp,mark1
;mov cx,17
;mov dx,0
;mov bh,0
;mov bl,15
;mov al,0
;int 10h
int 20h
;___________________________data_structure___________________________________
mark db 'Testing russian symbols',10,13,'Copyright Olli <olli@no.such.addr.anywhere> ,1995',10,13,'$'
mark1 db 10,129,129,129,128,128,128,130,130,130,131,131,131,132,132,132,10,'$'
code_ ends
end begin



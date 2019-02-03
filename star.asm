text SEGMENT BYTE PUBLIC 'CODE'
assume cs:text,ds:text,es:text
org 100h
begin:
;---------------------------define macros---------------------------------
INCLUDE star.mac
INCLUDE display.mac
;-------------------------------------------------------------------------
push cs
pop ds
mov ah,02h ;--set cursor plase
mov bh,0h  ;
mov dx,10100000000b  ;--to 10,0
int 10h    ;

;---output to screen
display string_
;----------- call macros
mov ah,attr
mov bx,0fh
mov di,0

push MDA
pop es

STAR 

;----------- 
mov ah,02h   ;--set cursor plase
mov bh,0h    ;
mov dx,1920  ;--to 12,0
int 10h      ;

int 20h  ;--exit to DOS

;---------------------------data_structure--------------------------------
MDA =0b000h                            ; MDA video RAM
attr=07h                               ;scr.attr., visible, white on black

string_ db ' This  programm writing  '
        db ' star  of the screen  ',10,13,'$'
text ENDS
END begin
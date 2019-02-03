;            Not-MDA version
;---------------------------------------------------------------------
;This program must be resident & it'll make russian symbols emulation.
;p.s.: I need to write hot-key procedure, because this programm conflicts whith telix
;---------------------------------------------------------------------
.8086                                                                 
MODEL TINY
CODE_ SEGMENT BYTE PUBLIC 'CODE'
ASSUME CS:CODE_,DS:CODE_,ES:CODE_
ORG 100H
BEGIN:                                                             ;LABEL!
JMP NEAR PTR INIT                                                  ;LABEL!
;-----------------TSR-data_structure-----------------------------------
OLD_09   DD 0
OLD_08   DD 0
ASCII  DB 'A','6','B',244,'D','E',15,'3','U','U','K','L','M','H','O',20,'P'
										;
		 DB 'C','T','Y',216,'X',191,3,1,2,39,'"',39,'>',17,184,'a','b'
		 db 'v','r'   ;*
		 db 'g','e',42,184,'u','u','k','l','m','#','o','n'
ASCII_ DB 'p','c',194,'y',216,'x',191,3,1,2,39,'"',39,'>',17,184,'E','e'
;------------------------------
process proc near
;*************************************
;* INPUT IN AL SYMBOL TO TRUNSLATE   *
;* OUTPUT IN AL KVASI-RUSSIAN SYMBOL *
;*************************************
;al-128=offset in eq_data
push bp
push bx
mov bh,ah
push bx

xor ah,ah
cmp al,224
jae p2
sub al,128
mov  bp,ax
mov al,cs:[ascii][bp]
jmp short exit_pr
p2:
sub al,224
mov bp,ax
mov al,cs:[ascii_][bp] 

EXIT_PR:
pop bx
mov ah,bh
pop bx
pop bp
ret
process endp
;------------------------------

NEW_08:                                                              ;LABEL!
;            NEW INT 8H  (TIMER)
; set to timer functions change-screen function
cli
PUSHF
push ax
push bx
push dx
push cx
push ds

mov bx,0b800h             ;not MDA
mov ds,bx                  
xor bx,bx
mov cx,1900
cicl:
mov ax,ds:[bx]
; sorting symbols
CMP AL,128        
JB SHORT skip_cicl                                             ;LABEL!
CMP AL,175
JBE SHORT processing1                                           ;LABEL!
CMP AL,224                          
JB SHORT  skip_cicl                                            ;LABEL!
CMP AL,241
JA SHORT  skip_cicl                                            ;LABEL!
processing1:
call process
mov ds:[bx],ax
skip_cicl:
add bx,2
loop cicl

skip8:
pop ds
pop cx
pop dx
pop bx
pop ax
POPF   
sti
JMP cs:[OLD_08]                                              ;LABEL!
;-------------------------------

;#############^^^^^^^!^^^^^INITIALISING PROGRAMM^^^^^!^^^^^^################
INIT:                                                                 ;LABEL!
; DS=CS (becouse .com programm)
push cs 
pop  ds
				 ; !  CHANGE BIOS INT 8H  (timer) !
;TAKE OLD ADDRESS OF INTERRUPT
CLI
MOV AX,3508H
INT 21H
MOV WORD PTR [OLD_08],BX
MOV WORD PTR [OLD_08+2],ES
;MAKE NEW ADDRESS OF INTERRUPT
LEA DX,NEW_08
MOV AX,2508H
INT 21H
push cs
pop ds
push cs
pop es
STI
;output information about programm
lea dx,info
mov ah,9h
int 21h
;============MAKE_TSR===============================
TSR:
; find size
LEA AX,INIT
PUSHF
MOV CL,4
SAR AX,CL
INC AX
POPF
MOV DX,AX
; make TSR
MOV AX,3100H
INT 21H
int 20h
;===================================================

;---------------------data_structure----------------------------------
info    db 'èêàÇÖí!',10,13
        db 'This program make russian symbols emulation on Your computer.',10,13
        db 'It can be useful if Your video-card is non-russificated ,',10,13
        db 'and you have''t graphic''s on your monitor (such as MDA) ',10,13
	db 'If it so,this program can solve Your problems',10,13
        DB 'Copyright by Olli <olli@NOthisadderss>,13-11-95',10,13
Call_me db 'Author don''t carry any responsibility for this programm,',10,13
        db 'write me to olli@NOthisaddress',10,13,'$'
;---------------------------------------------------------------------
CODE_ ENDS
END BEGIN

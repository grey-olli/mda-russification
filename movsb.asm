.MODEL TINY
.CODE
ORG 100H 
START:
;========
;Here i'll check work of instruction "movsb"
push cs 
pop ds
push ds
pop es
mov ah,9h
lea dx,testin
int 21h
lea dx,testout
int 21h
cld
lea cx,testin + length testin
lea si,testin
lea di,testout
repnz movsb
mov ah,9h
lea dx,message
int 21h
lea dx,testin
int 21h
lea dx,testout
int 21h
int 20h
message  db 'this changed by movsb to:',10,13,'$'
testin   db 'fucked_instruction!',10,13,'$'
testout  db '*******************',10,13,'$'
;========
END START

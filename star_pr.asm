;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This procedure print to screen in segm:offset stars (as screean-saver)    ;
;                       [text_mode !!!]                                     ;
;         Befor using this procedure set text screen mode     		    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; input:   
;  ah -> attribute of star-synbol [such as 07h - white on black]
;  bx -> how long star lighting
;  di -> plase of star [symbol offset]
;  es -> VIDEO RAM segment
;;;;; output : NONE
NAME stars
text segment byte public
assume cs:text,ds:text,es:text
PUBLIC star 
star proc near
aca: 
mov cx,0fffh
aba:
mov byte ptr  es:[di+1],ah
mov byte ptr  es:[di],'|'
mov byte ptr  es:[di],'/'
mov byte ptr  es:[di],'ö'
mov byte ptr  es:[di],'-'
mov byte ptr  es:[di],'|'
mov byte ptr  es:[di],'-'
mov byte ptr  es:[di],'ö'
mov byte ptr  es:[di],'\'
mov byte ptr  es:[di],'*'
mov byte ptr  es:[di],''
mov byte ptr  es:[di],''
mov byte ptr  es:[di],' '
loop aba
dec bx
jnz aca

star endp
text ends
END
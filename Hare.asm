TITLE Program Template     (template.asm)

; Program Description:
; Author:
; Date Created:
; Last Modification Date:

INCLUDE Irvine32.inc
	

; (insert symbol definitions here)
emptyMap PROTO
putNodes PROTO
moveCursor PROTO,X:BYTE, Y:BYTE
write_Node PROTO,X:BYTE, Y:BYTE,T:BYTE,Point:PTR DWORD
PlayHore PROTO,Aim:byte;
PlayWolf PROTO,Aim:word;
CheckInput PROTO,Input:PTR DWORD,Tip:BYTE;
CheckFinish PROTO;
ClearScreen PROTO;
ComputerWolfCalculate PROTO,T:BYTE,Axis:BYTE



.data
;186║
;185╣
;201╔
;200╚
;204╠
;187╗
;188╝
;205═
;203╦
;202╩
;201,205,187,0;╔═╗
;186,' ',186,0;║ ║
;200,205,188,0;╚═╝
;185,' ',204,0;╣ ╠
;201,202,187,0;╔╩╗
;200,203,188,0;╚╦╝
;186,' ',204,0;║ ╠
;185,' ',186,0;╣ ║
;205,205,205,0;═══
;186,0;║

str0 BYTE  '	    A    	  B    	      C    	    D      	  E ',10
str1 BYTE  ' 	                            ',10
str2 BYTE  '	               ',201,205,205,205,205,205,187,'      ',201,205,205,205,205,205,187,'      ',201,205,205,205,205,205,187,'      ',10
str3 BYTE  '1	               ',186,'     ',204,205,205,205,205,205,205,185,'     ',204,205,205,205,205,205,205,185,'     ',186,'      ',10
str4 BYTE  '	               ',200,205,205,203,205,205,188,'      ',200,205,205,203,205,205,188,'      ',200,205,205,203,205,205,188,'      ',10
str5 BYTE  '	             /    ',186,'    \       ',186,'       /    ',186,'    \     ',10
str6 BYTE  '	            /     ',186,'     \      ',186,'      /     ',186,'     \    ',10
str7 BYTE  '	           /      ',186,'      \     ',186,'     /      ',186,'      \   ',10
str71 BYTE '	          /       ',186,'       \    ',186,'    /       ',186,'       \   ',10
str8 BYTE  '	  ',201,205,205,205,205,205,187,'      ',201,205,205,202,205,205,187,'      ',201,205,205,202,205,205,187,'      ',201,205,205,202,205,205,187,'      ',201,205,205,205,205,205,187,10
str9 BYTE  '2	  ',186,' 2A  ',204,205,205,205,205,205,205,185,' 2B  ',204,205,205,205,205,205,205,185,'  2C ',204,205,205,205,205,205,205,185,' 2D  ',204,205,205,205,205,205,205,185,' 2E  ',186,10
str10 BYTE '	  ',200,205,205,205,205,205,188,'      ',200,205,205,203,205,205,188,'      ',200,205,205,203,205,205,188,'      ',200,205,205,203,205,205,188,'      ',200,205,205,205,205,205,188,10
str11 BYTE '	          \       ',186,'       /    ',186,'    \       ',186,'       /   ',10
str12 BYTE '	           \      ',186,'      /     ',186,'     \      ',186,'      /    ',10
str13 BYTE '	            \     ',186,'     /      ',186,'      \     ',186,'     /     ',10
str132 BYTE'	             \    ',186,'    /       ',186,'       \    ',186,'    /      ',10
str14 BYTE '	               ',201,205,205,202,205,205,187,'      ',201,205,205,202,205,205,187,'      ',201,205,205,202,205,205,187,'      ',10
str15 BYTE '3	               ',186,'     ',204,205,205,205,205,205,205,185,'     ',204,205,205,205,205,205,205,185,'     ',186,'      ',10
str16 BYTE '	               ',200,205,205,205,205,205,188,'      ',200,205,205,205,205,205,188,'      ',200,205,205,205,205,205,188,'      ',0
str17 BYTE 'Ff',0










W1 BYTE ' W1 ',0
W2 BYTE ' W2 ',0
W3 BYTE ' W3 ',0
H BYTE '  H  ',0
SPACE BYTE '     ',0
B1 BYTE 3,24,-1,0B1h;
C1 BYTE 3,37,0,0C1h;
D1 BYTE 3,50,0,0D1h;


A2 BYTE 10,11,-2,0A2h;
B2 BYTE 10,24,0,0B2h;
C2 BYTE 10,37,0,0C2h;
D2 BYTE 10,50,0,0D2h;
E2 BYTE 10,63,1,0E2h;

B3 BYTE 17,24,-3,0B3h;
C3 BYTE 17,37,0,0C3h;
D3 BYTE 17,50,0,0D3h;

Hp  DWORD 00000000h;
W1p DWORD 00000000h;
W2p DWORD 00000000h;
W3p DWORD 00000000h;

Eror byte 0;

msgH byte "enter next move of Hare  (eg:d1)       : ",0
msgW byte "enter next move of Hound (eg:1b2)         : ",0
err1 byte "You can't go there  ",0
okey byte "Ha boyle oyna            ",0
succesH byte 10,10,"			Hare Win		  ",10,10,0
succesW byte 10,10,"			Hound  Win		  ",10,10,0
err2 byte "Target plasce is full  ",0
err3 byte " There is no path      ",0
err4 byte "There is no place in map        ",0
err5 byte "Please Choose correct Wolf1                  ",0
err6 byte "not yet                    ",0


mov1 byte "mov Wolf1         ",0
mov2 byte "mov Wolf2                   ",0
mov3 byte "mov Wolf3                  ",0
mov4 byte "mov Hare                 ",0




check byte "continue                   ",0
start byte "Hound or  Hare ?(type for hound 1,otherwise 0)  :",0
Spa byte "																																										                  ",10,0





.code
main PROC
Local inputH:BYTE
Local inputW:WORD
mov inputH,0;
mov inputW,0;



call clrscr
INVOKE emptyMap
call crlf;
INVOKE putNodes
call crlf;
mov eax,white+(black*15);
call setTextColor




mov edx,offset start
call writeString;
call readInt;
;call dumpregs
cmp al,1
jne GameLooopHare

GameLooopHound:


	
	INVOKE CheckFinish;

	mov eax,white+(black*15);
	call setTextColor
	mov inputH,0;
	mov inputW,0;
	mov Eror,0;

	
LW:	call crlf
	mov eax,white+(black*15);
	call setTextColor
	mov  edx,offset msgW;
	call writestring;
	;call dumpregs
	call readHex;
	;call dumpregs
	mov inputW,ax;
	INVOKE CheckInput,ADDR inputW,0
	mov eax,white+(black*15);
	call setTextColor
	INVOKE PlayWolf,inputW
	
	cmp Eror,1
	je LW
	call clrscr
	call ClearScreen;
	call clrscr

	mov eax,white+(black*15);
	call setTextColor
	INVOKE emptyMap
	call crlf;
	mov eax,white+(black*15);
	call setTextColor
	INVOKE putNodes
	call crlf;
	mov Eror,0;
	mov eax,0;	
	INVOKE CheckFinish;
	

	call ComputerHareplay
	

	call clrscr
	call ClearScreen;
	call clrscr
	;INVOKE ClearScreen;
	mov eax,white+(black*15);
	call setTextColor
	INVOKE emptyMap
	call crlf;
	mov eax,white+(black*15);
	call setTextColor
	INVOKE putNodes
	call crlf;
	mov Eror,0;
	mov eax,0;	
	INVOKE CheckFinish;
	
	jmp GameLooopHound;
	
	
GameLooopHare:





	mov eax,white+(black*15);
	call setTextColor
	INVOKE CheckFinish;
	call ComputerWolf;

	mov inputH,0;
	mov inputW,0;
	mov Eror,0;

	;mov eax,0;	
	;INVOKE CheckFinish;
	;call readHex;
	call ClearScreen;
	call clrscr
	;INVOKE ClearScreen;
	mov eax,white+(black*15);
	call setTextColor
	INVOKE emptyMap
	call crlf;
	mov eax,white+(black*15);
	call setTextColor
	INVOKE putNodes
	call crlf;
	mov Eror,0;
	mov eax,0;	
	INVOKE CheckFinish;
	
	
LH:	
	call crlf;
	mov eax,white+(black*15);
	call setTextColor
	mov  edx,offset msgH;
	call writestring;
	call readHex;
	mov inputH,al;
	INVOKE CheckInput,ADDR inputH,1
	
	INVOKE PlayHore,inputH
	cmp Eror,1
	je LH
	call ClearScreen;
	call clrscr
	;INVOKE ClearScreen;
	mov eax,white+(black*15);
	call setTextColor
	INVOKE emptyMap
	call crlf;
	mov eax,white+(black*15);
	call setTextColor
	INVOKE putNodes
	call crlf;
	
	

	

	jmp GameLooopHare;

Ex:
	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

emptyMap PROC
mov edx,OFFSET str0

call writeString

call crlf

ret
emptyMap ENDP

moveCursor PROC,
	X:BYTE, Y:BYTE
	mov dl,Y
	mov dh,X
	call Gotoxy
	ret
moveCursor ENDP


putNodes PROC,
	
	call crlf
	mov edx,0;
	mov ecx,11;
	
	L1:
	
		mov eax,00000000h;
	
		push edx
		INVOKE write_Node,B1[edx],B1[edx+1],B1[edx+2],ADDR B1[edx]
		pop edx
		mov eax,0;
		
		call crlf;
		add edx,4;
		loop L1;
	ret
putNodes ENDP

write_Node PROC,
	X:BYTE, Y:BYTE,T:BYTE,Point:ptr DWORD
	mov dl,Y
	mov dh,X
	call Gotoxy
	
	cmp T,00000000h
	jl Wolfs;
	cmp T,00000000h
	jne Hoore
	mov edx,OFFSET SPACE;
    call writeString
	ret
	
Hoore:	
	mov eax,lightGreen+(black*15);
	call setTextColor
	mov edx,OFFSET H;
    call writeString
	;call crlf
	mov esi, Point;
	mov HP,esi;
	
	ret

Wolfs:
	neg T;
	dec T
	mov eax,0
	mov al,T;
	mov bl,5;
	imul bl
	
	mov ebx,0;
	mov ebx,OFFSET W1;
	add bx,ax;
    mov edx,ebx;
	mov eax,red+(black*15);
	call setTextColor
    call writeString;
	
	
	cmp T,0
	jne EL_2
	mov esi,Point;
	mov W1p,esi;
	ret
EL_2:
	cmp T,1
	jne EL_3
	mov esi,Point;
	mov W2p,esi;
	ret
EL_3:
	 mov esi,Point;
	 mov W3p,esi;
	   
	ret 
write_Node ENDP

PlayHore PROC,
	I:BYTE;target aim that is wanted to going
	Local move:BYTE,differenceH:BYTE,differenceW:BYTE;
	mov differenceH,0;
	mov differenceW,0;

	
	mov esi,HP;
	mov bl,byte ptr[esi+3];

	
				cmp     bl, 0D2h
				je      secondIf
				cmp     bl, 0C1h
				je      secondIf
				cmp     bl, 0C3h
				je      secondIf
                cmp     bl, 0B2h
                jne     Continue

 SecondIf:                            
                 cmp     I, 0D2h
                 je      WhenTrue
                 cmp     I, 0C1h
                 je      WhenTrue
                 cmp     I, 0C3h
                 je      WhenTrue
                 cmp     I, 0B2h
                 jne     Continue

 WhenTrue:                             
                 mov     edx, offset err3 ; " bak orda yol mu var      "
                 call    WriteString
                 mov     al, 7
                 call    WriteChar
                 mov     al, 7
                 call    WriteChar
                 mov     Eror, 1
                 ret

 Continue:                            
                                         
	mov edx,0;
	mov ecx,11;number of nodes
Find:;finding node which that users wats go it,
	movzx eax,B1[edx+3];
	;call writeInt;
	mov al,I;

	
		cmp    B1[edx+3], al
		jne El_PartW
		cmp    B1[edx+2],00h
		jne El_PartW
		jmp CheckPath1;//finded it,then check is  going possible?
El_PartW:
		cmp    B1[edx+3],al
		jne L
	
		mov edx,OFFSET err2
		call writeString
		mov Eror,1;
		mov AL, 07h
		call    WriteChar;
		mov AL, 07h
		call    WriteChar;
		ret
	
L:	add edx,4;
	loop Find;
	mov edx,OFFSET err4
	call writeString
	mov Eror,1
	mov AL, 07h
	call    WriteChar;
	mov AL, 07h
	call    WriteChar;
	ret
	

CheckPath1:
	mov ebx,0;
	;call dumpregs;
	mov bl,B1[edx];x position
	;call dumpregs;
	mov esi,HP;
	
	sub bl,byte ptr[esi];bl store x differeces
	mov differenceH,bl;
	;call dumpregs;
	
	
	mov bl,B1[edx+1];W position
	push edx;
	;call dumpregs;
	mov esi,HP;
	sub bl,byte ptr[esi+1]
	;call dumpregs;
	mov differenceW,bl;
	
	
	
	
	
	
		cmp     differenceH, 07h
		je      CheckPath2
		cmp     differenceH, 0f9h
		je      CheckPath2
		cmp     differenceH, 00h
		je      CheckPath2
		
        mov edx,OFFSET err1
		call writeString
		;call crlf
		mov Eror,1;
		mov AL, 07h
		call    WriteChar;
		mov AL, 07h
		call    WriteChar;
		ret;
	
	
CheckPath2:


	
		cmp     differenceW, 0dh
		je      whenPossible
		cmp     differenceW, 0F3h
		je      whenPossible
		cmp     differenceW, 00h
		je      whenPossible
		
		mov edx,OFFSET err1
		call writeString
		mov Eror,1;
		mov AL, 07h
		call    WriteChar;			;This block not possible
		mov AL, 07h
		call    WriteChar;
		;call crlf
		ret


whenPossible:
		mov edx,OFFSET okey
		call writeString
		mov Eror,0;

		mov esi,HP;
		;call dumpregs;
		mov byte ptr [esi+2],0;
		;call dumpregs;
		pop edx;
		mov B1[edx+2],1
		;call dumpregs;	
		;call crlf

	ret

PlayHore ENDP


PlayWolf PROC,
	Aim:word;target aim that is wanted to going
	;I:BYTE;target aim that is wanted to going
	Local I:BYTE ,differenceH:BYTE,differenceW:BYTE,temp:BYTE,Pointer:Dword
	mov differenceH,0;
	mov differenceW,0;
	mov temp,0;
	
	
	mov eax,0;
	mov ah,byte ptr aim[1];
	mov temp,ah;
	mov al,byte ptr aim[0];
	MOV I,al;
	
	cmp ah,1
	jne second_if
	mov esi,W1p;
	mov Pointer,esi;
	jmp nextW
second_if:	
	cmp ah,2
	jne third_if
	mov esi,W2p;
	mov Pointer,esi;
	jmp nextW
third_if:
	
	cmp ah,3
	jne L_ELSE
	mov esi,W3p;
	mov Pointer,esi;
	jmp nextW

L_ELSE:	
	mov edx,OFFSET err5
	call writeString
	mov Eror,1;
	mov AL, 07h
	call    WriteChar;
	mov AL, 07h
	call    WriteChar;
	RET;
	
nextW:
	
	
	mov esi,Pointer;
	mov bl,byte ptr[esi+3];
				cmp     bl, 0D2h
				je      SecondIfW
				cmp     bl, 0C1h
				je      SecondIfW
				cmp     bl, 0C3h
				je      SecondIfW
                cmp     bl, 0B2h
                jne     Continue2

 SecondIfW:                            
                 cmp     I, 0D2h
                 je      WhenTrueW
                 cmp     I, 0C1h
                 je      WhenTrueW
                 cmp     I, 0C3h
                 je      WhenTruew
                 cmp     I, 0B2h
                 jne     Continue2

 WhenTrueW:                             
                 mov     edx, offset err3 ; " bak orda yol mu var      "
                 call    WriteString
                 mov AL, 07h
				 call    WriteChar;
				 mov AL, 07h
				 call    WriteChar;
                 mov     Eror, 1
                 ret

 Continue2:       
	
	
	mov edx,0;
	mov ecx,11;number of nodes
Find:;finding node which that users wats go it,
	movzx eax,B1[edx+3];
	;call writeInt;
	mov al,I;

	
		cmp    B1[edx+3], al
		jne El_PartW
		cmp    B1[edx+2],00h
		jne El_PartW
		jmp CheckPath1;//finded it,then check is  going possible?
El_PartW:
		cmp    B1[edx+3],al
		jne L
	
		mov edx,OFFSET err2
		call writeString
		mov Eror,1;
		mov AL, 07h
		call    WriteChar;
		mov AL, 07h
		call    WriteChar;
		ret
	
L:	add edx,4;
	loop Find;
	mov edx,OFFSET err4
	call writeString
	mov Eror,1
	mov AL, 07h
	call    WriteChar;
	mov AL, 07h
	call    WriteChar;
	ret
	


CheckPath1:
	mov ebx,0;
	;call dumpregs;
	mov bl,B1[edx];x position
	;call dumpregs;
	mov esi,Pointer;
	
	sub bl,byte ptr[esi];bl store x differeces
	mov differenceH,bl;
	;call dumpregs;
	
	
	mov bl,B1[edx+1];W position
	push edx;
	;call dumpregs;
	mov esi,Pointer;
	sub bl,byte ptr[esi+1]
	;call dumpregs;
	mov differenceW,bl;
	
	
	
	
		cmp     differenceH, 07h
		je      CheckPath2
		cmp     differenceH, 0f9h
		je      CheckPath2
		cmp     differenceH, 00h
		je      CheckPath2
		
        mov edx,OFFSET err1
		call writeString
		;call crlf
		mov Eror,1;
		mov AL, 07h
		call    WriteChar;
		mov AL, 07h
		call    WriteChar;
		ret;
	
	
	
CheckPath2:


		cmp     differenceW, 0dh
		je      whenPossible
		cmp     differenceW, 00h
		je      whenPossible
		
		mov edx,OFFSET err1
		call writeString
		mov Eror,1;
		mov AL, 07h
		call    WriteChar;			;This block not possible
		mov AL, 07h
		call    WriteChar;
		;call crlf
		ret


whenPossible:
		mov edx,OFFSET okey
		call writeString

		mov esi,Pointer;
		;call dumpregs;
		mov byte ptr [esi+2],0;
		;call dumpregs;
		neg temp;
		pop edx;
		mov bl,temp;
		mov B1[edx+2],bl;
		mov Eror,0;

	ret
PlayWolf ENDP


CheckInput PROC,
Input:ptr DWORD, Tip:BYTE;
	mov  edx,offset check;
	call writestring;
	cmp tip,1;hoore control
	jne CheckWolf
	
	mov esi ,Input;
	;movsx ebx,byte ptr[esi]; 
	;call dumpregs;
    movzx eax,byte ptr[esi];:
    mov  edx, 0;remainder 
    mov ebx, 16; 
    idiv ebx   ;eax/ebx  quotient:eax remainder EDX
	
	cmp dl,10
	jnl ConvertHoore; convert input
	ret
ConvertHoore:
	push eax;quotient
	mov eax,0
	mov al,dl;
	mov bl,16;
    imul bl;;eax*ebx sonuc gene eax
	;call dumpregs;
	pop ebx
	;call dumpregs
	add al,bl;
	;call dumpregs
	mov byte ptr[esi],al
	ret

CheckWolf:

	mov esi ,Input;
	;movsx ebx,byte ptr[esi]; 
	;call dumpregs;
    movzx eax,byte ptr[esi];:
    mov  edx, 0;remainder 
    mov ebx, 16; 
    idiv ebx   ;eax/ebx  quotient:eax KALAN EDX A
	cmp dl,10
	jnl ConvertWolf; convert inputu
	ret
	
ConvertWolf:
	push eax;quotient
	mov eax,0
	mov al,dl;
	
	mov bl,16;
    imul bl;;eax*ebx sonuc gene eax
	;call dumpregs;
	
	pop ebx
	;call dumpregs
	add al,bl;
	;call dumpregs
	mov byte ptr[esi],al
	ret

ret
CheckInput ENDP

ClearScreen Proc; PROC
		;call clrscr
		mov dl,20
		mov dh,14
		call Gotoxy
		mov ecx,30
L3:	
		mov edx,OFFSET Spa
		call writeString
		loop l3
		
		mov dl,20
		mov dh,14
		call Gotoxy
		;call clrscr
		ret
ClearScreen  ENDP

CheckFinish PROC

	mov eax,white+(black*15);
	call setTextColor
	
	mov esi,HP;
	mov edi,w1p;
	mov al,byte ptr[esi+1]
	mov ah,byte ptr[esi+3]
		
	cmp al,byte ptr[edi+1]
	jg Step2
	mov edi,w2p;
    cmp al,byte ptr[edi+1]
	jg Step2
	mov edi,w3p;
    cmp al,byte ptr[edi+1]
	jg Step2
	mov edx,OFFSET succesH
	call writeString;
	call crlf
	exit;
	ret

Step2:


	cmp ah,0e2h
	jne  Quit
	cmp D1[2],0
	je Quit
	cmp D2[2],0
	je Quit
	cmp D3[2],0
	je Quit
	mov edx,OFFSET succesW
	call writeString;
	call crlf
	mov al,1;
	exit;
	ret
	
Quit:	
	
	
 ret
CheckFinish ENDP

ComputerWolf PROC
Local pivot:byte;

	mov pivot,0
	mov pivot,1;
	
TryAgain:
	mov esi, w1p;
	mov edi,Hp
	
	mov al,byte ptr [esi+1];w1
	mov esi, w2p;
	mov ah,byte ptr [esi+1];w2
	mov esi, w3p;
	mov bl,byte ptr [esi+1];w3
	mov bh,byte ptr[edi +3]

	
	CMP al,ah
	jnle Se_W
	CMP al,bl
	jnle Se_W

	  push eax
	  push ebx
	 INVOKE ComputerWolfCalculate,1,pivot ;move w1 next horizontally
	  pop eax
	  pop ebx
	  cmp Eror,0
	  je Clo;

Se_W: 

	
	CMP ah,al
	jnle ThirdW
	CMP ah,bl
	jnle ThirdW

	  push eax
	  push ebx
	 INVOKE ComputerWolfCalculate,2,pivot;move w2 next horizontally
	  pop ebx
	  pop eax
	  cmp Eror,0
	  je Clo;
	
ThirdW:

	CMP bl,ah
	jnle Devam
	CMP bl,al
	jnle Devam

	  
	  push eax
	  push ebx
	  ;CALL crlf
	 INVOKE ComputerWolfCalculate,3,pivot;move w3 next horizontally
	  pop ebx
	  pop eax
	  cmp Eror,0
	  je Clo;
	 CALL crlf
	
	 
	
Devam:
	call crlf
	dec pivot;
	jmp TryAgain

Clo:	
	ret;
	
ComputerWolf ENDP

ComputerWolfCalculate PROC,
T:BYTE,Axis:BYTE
Local Fin:BYTE;
MOV Fin,0;
mov Eror,0;
	
	
	cmp T,1
	jne E_2
	mov esi,w1p;
	jmp NextStep
E_2:
	cmp T,2
	jne E_3
	mov esi,w3p;
	jmp NextStep
E_3:
	 mov esi,w3p;
	
	
NextStep:

	
	MOV EAX,0;
	MOV ah,Axis;
	
	cmp Axis,1;
	jne Ax0;
	mov al,byte ptr [esi+1]
	add al,13;
	jmp Fstep
	 
	 
Ax0:
	cmp Axis,0;
	jne Ax01;
	mov ecx,11;
	mov edx,0;
	mov al,byte ptr [esi]
	mov ah,byte ptr [esi+1]
	add al,7;
	 
	movzx ebx,Axis;
	jmp Find3
	

	 
Ax01:
	cmp Axis,-1;
	jne Fstep;
	mov ecx,11;
	mov edx,0;
	mov al,byte ptr [esi]
	mov ah,byte ptr [esi+1]
	sub al,7;
	mov Axis,0;
	movzx ebx,Axis;
	jmp Find3
	

Fstep:
	 movzx ebx,Axis;

	 mov ecx,11;
	 mov edx,0;
	 
	 
Find2:

	cmp  B1[edx+ebx],al
	jne Con
	cmp  B1[edx+2],00h
	jne Con
	
	
	push eax
	push ebx
	push edx
	mov eax,0;
	mov al,B1[edx+3]
	mov ah,T
	;call dumpregs;
	INVOKE PlayWolf,ax
	pop edx
	pop ebx
	pop eax
	
	cmp Eror,1
	JE Con
	
	mov Fin,1
	mov ecx,1;
	
	
	
Con:
	add edx,4;
	 ;call dumpregs;
	loop Find2;
	cmp Fin,1
	Je  q
	mov Eror,1
q:
	ret
	
Find3:



	;call dumpregs
	cmp  B1[edx+ebx],al
	jne Don
	cmp  B1[edx+2],00h
	jne Don
	cmp  B1[edx+1],ah
	jne Don
	mov ecx,1;
		
Don:
	add edx,4;
	loop Find3;	
	
	
Co:
	sub edx,4;
	; call dumpregs;
	mov eax,0;
	mov al,B1[edx+3]
	mov ah,T
	;call dumpregs;
	INVOKE PlayWolf,ax
	mov al ,Eror
	;call dumpregs;



ret
ComputerWolfCalculate ENDP


ComputerHareplay Proc
Local axe:byte
Local flag:BYTE
mov axe,1;
mov flag,0;


Try:

	
	mov esi, Hp;
	mov al,byte ptr[esi];y
	mov ah,byte ptr[esi+1];x
	
				cmp     axe, 1
                jne     IF_axe_2	;move -x
                sub     ah, 0Dh
                jmp     Forward


 IF_axe_2:                            
                 cmp     axe, 2
                 jne      IF_axe_3
                 sub     ah, 0Dh	;mov -x-y
                 sub     al, 7
                 jmp     Forward
 
 IF_axe_3:                          
                 cmp     axe, 3
                 jne      IF_axe_4
                 sub     ah, 0Dh	;mov y-x
                 add     al, 7
                 jmp     Forward


 IF_axe_4:                          
                 cmp     axe, 4
                jne     IF_axe_5
                 sub     al, 7	;move -y;
                 jmp     Forward

 IF_axe_5:
                 cmp     axe, 5
                 jne     IF_axe_6	;mov +y
                 add     al, 7
                 jmp     Forward

 IF_axe_6:                            
                 cmp     axe, 6
                 jne      IF_axe_7	;mov +x
                 add     ah, 0Dh
                 jmp     Forward

 IF_axe_7:                            
                 cmp     axe, 7
                 jne     IF_axe_8
                 add     ah, 0Dh	;mov +x-y
                 sub     al, 7
                 jmp     Forward

 IF_axe_8:                           
                 cmp     axe, 8
                 jne     Forward
                 add     ah, 0Dh	;mov +x+y
                 add     al, 7

 Forward:                            
	
	
	mov ecx,0;
	mov cl,axe;
	
	mov edx,0
	

	mov ecx,11;
FindH:
	;call dumpregs
	cmp  B1[edx],al
	jne De
	cmp  B1[edx+2],00h
	jne De
	cmp  B1[edx+1],ah
	jne De
	mov ecx,1;
	mov flag,1
	


	
De:
	add edx,4;
	;call dumpregs;
	loop FindH;
	cmp flag,0
	je T
	
	sub edx,4;
	mov eax,0;
	mov al,B1[edx+3]
	INVOKE PlayHore,al
	
	cmp Eror,0
	Je  Bitir
T:	inc axe;
	jmp Try


Bitir:

	ret
ComputerHareplay ENDP




END main
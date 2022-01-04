Data_here segment
	num DW 0081H ; REQ. INPUT : IT081(MY ROLL NUM)
	msg1 db 'Given number is ODD$'
	msg2 db'Given number is EVEN$'
Data_here ends

Stack_here segment stack
	dw 50 dup(0)
	stk1 label word
Stack_here ends

msgproc segment
Check proc far
Assume  cs:msgproc
		PUSHF
		PUSH DX
		shr ax,01H
		jnc evn

odd :   MOV AH,09h
			MOV DX,offset msg1
			INT 21h
			JMP q  

evn :  MOV AH,09h
			MOV DX,offset msg2
			INT 21h
			JMP q
		
q	:	POP DX 
		POPF
		
		RET
		Check endp
msgproc ends

Code_here segment
Assume cs:Code_here ,ds:Data_here ,ss:Stack_here
Start : mov ax,Data_here
		mov ds,ax
		mov ax,Stack_here
		mov ss,ax
		LEA SP,stk1
		
		mov ax,num
		CALL Check
		INT 3h		
Code_here ends

End Start

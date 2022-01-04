DATA_HERE SEGMENT WORD PUBLIC 
	INPUT DW 00ABH,0CDEH,7FFFH,0FFFFH 
	QUOTIENTS DB 4 DUP(0)  
	DIVISOR DB 50H ; DIVISOR P(50H)
	FLAGS DB 4 DUP (0)  
	EFLAG DB 0 ; ERROR FLAG 
DATA_HERE ENDS 

STACK_HERE SEGMENT STACK 
	DW 100 DUP(0) 
	STACK1 LABEL WORD 
STACK_HERE ENDS 

PUBLIC EFLAG
	
	PROC_HERE SEGMENT WORD PUBLIC 
	EXTRN DIV_PROC : FAR 
	PROC_HERE ENDS 

CODE_HERE SEGMENT WORD PUBLIC 
 
		ASSUME CS:CODE_HERE , DS:DATA_HERE , SS:STACK_HERE 
START: 	MOV AX , STACK_HERE 
		MOV SS , AX 
		MOV SP , OFFSET STACK1 
		MOV AX , DATA_HERE 
		MOV DS , AX 
		MOV AX,0000 
		MOV ES, AX 
		
		;CHANGE INTERRUPT TYPE0
	
		MOV WORD PTR ES:0002,SEG DIV_PROC 
		MOV WORD PTR ES:0000,OFFSET DIV_PROC 
		MOV SI,OFFSET INPUT 
		MOV BX,OFFSET QUOTIENTS 
		MOV DI,OFFSET FLAGS 
		MOV CX,0004 
NEXT: 	MOV AX,[SI] 
		DIV DIVISOR 
		CMP EFLAG,01 
		JNE NXT 
		MOV BYTE PTR[BX],00 
		MOV BYTE PTR[DI],01 
		JMP NXT1 
NXT: 	MOV [BX],AL  
		MOV BYTE PTR[DI],00  
NXT1:	MOV EFLAG,00 
		ADD SI,02H 
		INC BX 
		INC DI 
		LOOP NEXT 
STOP: NOP 
CODE_HERE ENDS 
END START 

data_here SEGMENT
	bcd_n DW 0081H
	bin_n DW ?
data_here ENDS

stack_here SEGMENT STACK
	DW 50 DUP(0)
	Stack1 LABEL WORD
stack_here ENDS

code_here SEGMENT

	ASSUME CS:code_here, ES:data_here, DS:data_here, SS:stack_here

START : MOV AX,data_here
		MOV DS,AX
		MOV ES,AX
		
		MOV AX,stack_here
		MOV SS,AX
		LEA SP,Stack1
		
		MOV AX, bcd_n
		PUSH AX               ;store value in stack
		CALL CONVERT1  		  ;call procedure
		POP AX                ;store the result of procedure will be popped from stack
		MOV bin_n,AX          ;copy result in bin_n
		
		INT 3h
		
	CONVERT1 PROC NEAR
	
		PUSHF 
		PUSH BX               
		PUSH CX   
		PUSH BP
		
		MOV BP,SP
		MOV AX,[BP+10]
		
		MOV BX,AX
		AND AX,000FH      ;by this and operation last digit will be stored at last position
		MOV BP,AX         
		
		MOV AX,BX
		AND AX,00F0H      	;to store at second last position
		MOV CL,04H			
		SHR AX,CL		  ;shift by 4 right position
		MOV SI,000AH      
		MUL SI			  ;digit will be multiplied by 10
		MOV SI,AX         
		
		MOV AX,BX
		AND AX,0F00H	  ; to store at third from last position
		MOV CL,08H		 
		SHR AX,CL         ;shift by 8 right position
		MOV DI,0064H      
		MUL DI             ;digit will be multiplied by 100
		MOV DI,AX          
		
		MOV AX,BX
		AND AX,0F000H      ;to store at fourth from last position
		MOV CL,0CH
		SHR AX,CL          ;shift by 12 right position
		MOV CX,03E8H       
		MUL CX             ;digit will be multiplied by 1000   
		ADD AX,SI
		ADD AX,DI         
		ADD AX,BP          ; add all digits
		
		MOV BP,SP
		MOV [BP+10], AX     ;storing result in stack
		 
		POP BP
		POP CX
		POP BX
		POPF
		RET
		
	CONVERT1 ENDP	

code_here ENDS

END START

data_here segment
	input1 DW 0081H ;0081 == 0000 0000 1000 0001
	ans DB ?
data_here ENDS

stack_here segment STACK
	DW 50 DUP(0)
	stack1 LABEL WORD
stack_here ENDS

code_here segment
ASSUME CS:code_here ,SS:stack_here ,DS:data_here
START : MOV AX,data_here
		MOV DS,AX
		MOV AX,stack_here
		MOV SS,AX
		LEA SP ,stack1
		
		MOV AX,input1  
		CALL cnt1 
		MOV ans,AL
		INT 3H
	
cnt1 PROC NEAR
		MOV BL,00H      	
		MOV CL ,10H       
NEXT:	SHR AX,1            ;at a time shift reg AX
		JNC POS             ;if carry not generated jump to POS
		INC BL	            ;if generated BL++
		
POS:	DEC CL              
		JNZ NEXT
		
		MOV AL,BL
		RET
cnt1  ENDP

code_here ENDS

END START

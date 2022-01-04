DATA SEGMENT
    DEMO DB 'AANANDI$'
    STRNG DB 'aanandi$'
    msg1 DB 'strings are same$'
    msg2 DB 'strings are not same$'
DATA ENDS

CODE SEGMENT    
assume CS:CODE,DS:DATA,ES:DATA
    
start:mov AX,DATA
      mov DS,AX
      mov ES,AX
      LEA SI,DEMO
      LEA DI,STRNG
      MOV CX,6
      CLD
      REPE CMPSB    
      jnz msg22
      
	msg11:
    mov AH,09H
    mov DX,OFFSET msg1
    int 21h
    jmp exit
     
    msg22:
    mov AH,09H
    mov DX,OFFSET msg2
    int 21h
    jmp exit
    
    exit:int 3
    
CODE ENDS
END START
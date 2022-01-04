DATA SEGMENT
MESSAGE DB "ENTER STRING : $"
STR1 DB  255 DUP(?)
MESSAGE1 DB "STRING AFTER CONVERSION : $"

DATA ENDS

CODE SEGMENT
ASSUME DS: DATA, CS: CODE, ES: DATA
START:
	MOV AX,DATA
	MOV DS,AX
	MOV ES,AX

	MOV AH,09H
	LEA DX,MESSAGE	              ; Print message
	INT 21H
	
	LEA SI,STR1					 ; Take string from user
    MOV AH,01H

;;Logic for conversion

READ:

    INT 21H
    MOV BL,AL

    CMP AL,0DH
    JE  PRNT
    XOR AL,20H
    MOV BYTE PTR [SI],AL
    INC SI

    JMP READ

PRNT:

    MOV AL,'$'
    MOV BYTE PTR [SI],AL
	
;;end logic : string is converted	

	MOV AH,09H 
	LEA DX,MESSAGE1               ; Print message1
	INT 21H

    LEA DX,STR1					  ; Print converted string	
    MOV AH,09H
    INT 21H

	MOV AH, 4CH                  ; return control to DOS
    INT 21H
	
CODE ENDS
END START
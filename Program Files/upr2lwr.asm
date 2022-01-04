DATA SEGMENT
MESSAGE DB "ENTER CHARACTER IN UPPERCASE : $"
MESSAGE1 DB "CONVERTED CHARACTER INTO LOWERCASE : $"
X DB ?
DATA ENDS

CODE SEGMENT
ASSUME DS: DATA, CS: CODE
START:
	 MOV AX,DATA
	 MOV DS,AX
	 LEA DX,MESSAGE
	 MOV AH, 9                    ; Print message
	 INT 21H
	 MOV AH, 1                    ; read a character
	 INT 21H

     MOV X, AL                   ; save input character into X
	 
	 MOV DL, 0AH                  ; line feed
     INT 21H

	 LEA DX,MESSAGE1
	 MOV AH, 9                    ; Print message1
	 INT 21H
	
	 OR X, 20H
	
     MOV AH, 2                    ; display the character stored in X   
     MOV DL, X
     INT 21H

     MOV AH, 4CH                  ; return control to DOS
     INT 21H
CODE ENDS
END START
DATA SEGMENT
MESSAGE DB "ENTER CHARACTER : $"
MESSAGE1 DB "ENTERED CHARACTER: $"
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

     MOV AH, 2                    ; carriage return
     MOV DL, 0DH          
     INT 21H

     MOV DL, 0AH                  ; line feed
     INT 21H

	 LEA DX,MESSAGE1
	 MOV AH, 9                    ; Print message1
	 INT 21H
	
     MOV AH, 2                    ; display the character stored in X   
     MOV DL, X
     INT 21H

     MOV AH, 4CH                  ; return control to DOS
     INT 21H
CODE ENDS
END START
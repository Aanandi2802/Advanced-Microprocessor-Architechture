DATA SEGMENT
            myname db 'AANANDI R. PANKHANIA$'
			len equ $-myname
DATA ENDS
DATA1 SEGMENT
            str1 db 15 DUP(0)
DATA1 ENDS
 
CODE SEGMENT
assume CS:CODE ,DS:DATA , ES:DATA1
    Start : mov AX,DATA
            mov DS,AX
			mov AX,DATA1
            mov ES, AX
            LEA SI,myname
            LEA DI,str1
            mov CX,len
            CLD
            REP movsb
            INT 3h
CODE ENDS
END Start
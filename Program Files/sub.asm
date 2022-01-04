data_here segment
		a dw 0081h;decimal 0081(roll no)
		b dw 1800h;decimal 1800
		c dw ?
data_here ends

code_here segment
		assume cs:code_here,ds:data_here
		start:
			mov ax,data_here
			mov ds,ax
			mov ax,a
			mov bx,b
			sub ax,bx
			mov c,ax
			int 3h

code_here ends
end start

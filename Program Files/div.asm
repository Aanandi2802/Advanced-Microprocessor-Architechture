data_here segment public
	extrn dvs:word
data_here ends
public division
procedure_here segment public

	division proc far
		assume cs:procedure_here,ds:data_here
		cmp dvs,0
		je carry
		
		mov bx,ax
		mov ax,dx
		mov dx,0000h
		div cx
		mov bp,ax
		mov ax,bx
		div cx
		mov cx,dx
		mov dx,bp
		clc
		jmp q

carry:	stc
q:		ret
division endp

procedure_here ends
end

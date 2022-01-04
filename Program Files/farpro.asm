data_here segment word public
	dvd dw 6E61h,6161h
	dvs dw 5041h
data_here ends

data1_here segment word
	quotient dw 2 dup(0)
	reminder dw 0
data1_here ends

stack_here segment stack
	dw 30 dup(0)
	t1 label word
stack_here ends

public dvs

procedure_here segment public
	extrn division:Far
procedure_here ends

code_here segment word public
	assume cs:code_here,ds:data_here, ss:stack_here

start:	mov ax,data_here
		mov ds,ax
		mov ax,stack_here
		mov ss,ax
		mov sp,offset t1
		
		mov ax,dvd
		mov dx,dvd+2
		mov cx,dvs
		
		call division
		jnc X
		jmp q
		
		assume ds:data1_here
		
   X: 	push ds
		mov bx,data1_here
		mov ds,bx
		
		mov quotient,ax
		mov quotient+2,dx
		mov reminder,cx
		
		assume ds:data_here
		pop ds

q:	int 3h
code_here ends
end start

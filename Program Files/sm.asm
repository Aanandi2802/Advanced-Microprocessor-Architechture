data_here segment
		arr db 1h,2h,3h,14h,25h  ;created an array
		ld db 1h  ;roll no.'s(IT081) last digit---1
		ar db 5 dup(?)  ;another array
data_here ends

code_here segment
		assume cs:code_here,ds:data_here
		start:	mov ax,data_here
			mov ds,ax
			mov cl, 5   ;count value 5
			mov bl, ld
			mov DI, 0
			mov ah,0
		l1: mov al, arr[DI] ;loop l1 start
              mul bl
              mov ar[DI], al
              inc DI
              dec cl    ;count--
              jnz l1    ;when count 0 loop will end...

              int 21h
			  int 3h

code_here ends
end start




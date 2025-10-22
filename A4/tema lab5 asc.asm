;Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the elements of A in reverse order.
;Example:
;A: 2, 1, -3, 0
;B: 4, 5, 7, 6, 2, 1
;R: 1, 2, 6, 7, 5, 4, 0, -3, 1, 2
bits 32 
global start        
extern exit
import exit msvcrt.dll


segment data use32 class=data
    A db 2,1,-3,0
    lena equ $-A
    B db 1,2,6,7,5,4,0,-3,1,2
    lenb equ $-B
    R times lena+lenb db 0 


segment code use32 class=code
    start:
    ; Reverse the elements of B and store them in R
    MOV ECX, lenb
    MOV EDI, 0
    MOV ESI, lenb-1
    
    jecxz end_loop1
    repeat_loop1:
        mov AL, [B+ESI]
        mov [R+EDI], AL
        inc EDI
        dec ESI
    loop repeat_loop1
    end_loop1
    
    MOV ECX, lena
    MOV ESI, lena-1
    
    jecxz end_loop2
    repeat_loop2:
        mov AL, [A+ESI]
        mov [R+EDI], AL
        inc EDI
        dec ESI
    loop repeat_loop2
    end_loop2
    
    
    push    dword 0     
    call    [exit]
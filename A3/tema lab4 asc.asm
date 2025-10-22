;Given the doubleword M, compute the doubleword MNew as follows:
;the bits 0-3 a of MNew are the same as the bits 5-8 a of M.
;the bits 4-7 a of MNew have the value 1
;the bits 27-31 a of MNew have the value 0
;the bits 8-26 of MNew are the same as the bits 8-26 a of M.

bits 32 
global start        
extern exit
import exit msvcrt.dll


segment data use32 class=data
    M dd 01110111010101110111011101010111b
    MNew dd 0


segment code use32 class=code
    start:
    MOV EAX, [M]
    SHR EAX, 5
    AND EAX, 00000000000000000000000000001111b
    MOV [MNew], EAX
    ;the bits 0-3 a of MNew are the same as the bits 5-8 a of M.
    
    MOV EAX, [MNew]
    OR EAX, 00000000000000000000000011110000b
    MOV [MNew], EAX
    ;the bits 4-7 a of MNew have the value 1
    
    

    ;the bits 27-31 a of MNew  already have the value 0
    
        
    
    MOV EAX, [M]
    AND EAX, 00000111111111111111111100000000b
    OR [MNew], EAX
    ;the bits 8-26 of MNew are the same as the bits 8-26 a of M.
    
    push    dword 0     
    call    [exit]
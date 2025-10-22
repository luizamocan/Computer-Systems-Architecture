;21. Being given a string of words, obtain the string (of bytes) of the digits in base 10 of each word from this string.
;Example:
;being given the string
;sir DW 12345, 20778, 4596 
;the result will be
;1, 2, 3, 4, 5, 2, 0, 7, 7, 8, 4, 5, 9, 6.

bits 32 
global start        
extern exit
import exit msvcrt.dll 

segment data use32 class=data
    A dw 12345, 20778, 4596 
    lenA equ ($-A)/2 
    result times lenA*5 db 0
    zece db 10
    
    
segment code use32 class=code
    start:
        MOV ESI, A+(lenA-1)*2; ultimul element din A
        MOV EDI, result+lenA*5-1;ultima pozitie din result 
        MOV ECX, lenA
        cld
        
        repeat:
            LODSW; ax=element din A
            PUSH ECX
            
            numbers:
            DIV byte[zece]; ax/10-> ah=rest al=cat
            MOV BL,AL
            MOV AL, AH
            STOSB
            CMP BL, 0; verifica daca catul e diferit de zero
            JNZ numbers
            
            POP ECX
        loop repeat
        
        
    push dword 0
    call [exit]
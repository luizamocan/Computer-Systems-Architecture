
    bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;(a*a+b+x)/(b+b)+c*c; a-word; b-byte; c-doubleword; x-qword
segment data use32 class=data
      a dw 1    
      b db 2
      c dd 3
      x dq 4
      result dq 0
      

; our code starts here
segment code use32 class=code
    start:
        
        mov AX, [a]
        mov BX, [a]
        imul BX ; DX:AX=a*a-dword
        
        push DX
        push AX
        pop EBX ;EBX=a*a
        
        mov AL, [b]
        cbw ;AX=b
        cwde; EAX=b-byte
        adc EBX, EAX ;EBX=a*a+b
        
        mov EAX, dword[x]
        mov EDX, dword[x+4]
        add EAX , EBX ; EAX = a*a+b+lower 32 bits of x
        adc EDX, 0 ; Add carry and upper 32 bits of x
        ;EDX:EAX=a*a+b+x
       
       
       
       mov AL, [b]
       add  AL, byte[b] ;AL=b+b -byte
       cbw ;AX=b+b
       cwde ;EAX=b+b -dword
       mov EBX, EAX; EBX=b+b-byte
       div EBX ; EAX=(a*a+b+x)/(b+b)
       mov ECX, EAX ; ECX=(a*a+b+x)/(b+b)
       
       mov EBX, [c]
       mov EAX, [c]
       imul EBX ;EDX:EAX=c*c -quad
       
       mov EDX, EAX
       mov EAX, ECX
       add EDX, EAX
       
       
       mov dword [result], EAX  
       mov dword [result + 4], EDX
       ;result is in EDX:EAX       
       
        

    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
 
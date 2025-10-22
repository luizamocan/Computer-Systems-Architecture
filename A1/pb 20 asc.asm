
    bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;(50-b-c)*2+a*a+d
segment data use32 class=data
      a db 2
      b db 30
      c db 4
      d dw 5
      x dw 0
      
      

; our code starts here
segment code use32 class=code
    start:
        mov AL, [a]
        mov BL, [a]
        mul BL
        add AX, [d]
        mov BX, AX
        ;BX=a*a+d
        
        mov CL, 50
        sub CL, [b]
        sub CL, [c]
        ;CL=50-b-c
        mov AL, 2
        mul CL
        ;AX=(50-b-c)*2
        mov [x], AX
        ; x=(50-b-c)*2
        
        add [x], BX
        

    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

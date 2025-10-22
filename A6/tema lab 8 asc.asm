bits 32 
global start        


extern exit, printf, scanf               
import exit msvcrt.dll   
import printf msvcrt.dll
import scanf msvcrt.dll
                          
;Read two numbers a and b (in base 10) from the keyboard and determine the order relation between them (either a < b, or a = b, or a > b).
; Display the result in the following format: "<a> < <b>, <a> = <b> or <a> > <b>".

segment data use32 class=data
   a dd 0
   b dd 0
   format_input db "%d", 0             
   format_smaller db "%d < %d", 0       ; Format for a < b
   format_equal db "%d = %d", 0       ; Format for a = b
   format_bigger db "%d > %d", 0       ; Format for a > b

segment code use32 class=code
    start:
        push dword a
        push dword format_input
        call [scanf]
        add ESP, 4*2
        ;read a
        
        push dword b
        push dword format_input
        call [scanf]
        add ESP, 4*2
        ;read b
        
        
        mov EAX, [a]
        mov EBX, [b]
        cmp EAX, EBX
        
        je display_equal
        jl display_smaller_a
        jg display_bigger_a
        
        display_equal:
        ; a=b
        push EBX
        push EAX
        push format_equal
        call [printf]
        add ESP, 4*3
        jmp end_program
        
        
       display_smaller_a:
       ;a<b
       push EBX
       push EAX
       push format_smaller
       call [printf]
       add ESP,4*3
       jmp end_program
       
       
       display_bigger_a:
       ;a>b
       push EBX
       push EAX
       push format_bigger
       call [printf]
       add ESP, 4*3
       jmp end_program
       
       
       end_program:
        
        
        
        
        push    dword 0      
        call    [exit]       

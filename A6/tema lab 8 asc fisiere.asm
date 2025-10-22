bits 32 
global start        
;A file name and a text (defined in data segment) are given. The text contains lowercase letters, uppercase letters, digits and special characters.
;Replace all spaces from the text with character 'S'. Create a file with the given name and write the generated text to file.

extern exit, fopen, fprintf, fclose               
import exit msvcrt.dll    
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll


segment data use32 class=data
   text db "Ana are 3 mere",0
   len_text equ ($-text)
   access_mode_write db 'w',0
   file_handle db "output.txt",0
   
   
   
segment code use32 class=code
    start:
        push dword access_mode_write
        push dword file_handle
        call [fopen]
        add esp, 8
        
        mov ebx,eax ;save the file we handle in ebx
        mov ecx,len_text
        
        mov esi,text
        jecxz end_loop
        parcurgere:
            lodsb
            cmp al,' '
            jne skip_replace
            mov byte[esi-1], 'S'
          skip_replace:
        loop parcurgere
        end_loop:
      
        
        push dword text
        push ebx
        call [fprintf]
        add esp, 8
        
        
        push ebx
        call [fclose]
        add esp,4
        
        
        push    dword 0      
        call [exit]
        
.MODEL COMPACT
.DATA
     ;ENCODE
    STOR DW 0                           
    LETTER DB 0                         
    INDEX DB 0                          
    COUNT DB 0                          
    LENGTHS DB 0                        
    INPUT  DB  50 dup(?)               
    ;STRINGS
    PRESS_ANY_KEY DB 13,10,13,10,"PRESS ANY KEY TO CONTINUE!$"
    STR_INPUT DB 13,"========================================="
        DB 13,10,"MESSAGE ENCODER (STRING => MORSE)" 
        DB 13,10,"========================================="
        DB 13,10,"Input the readable message to encrypt!"
        DB 13,10,"(In UPPERCASE)" 
        DB 13,10,10,"INPUT : ",13,10,"$"
   
    STR_OUTPUT DB 13,10,"OUTPUT: ",13,10,"$"              
    STR_EMPTY DB "NO INPUT$"              
    MORSE_LISTS DB 13,"========================================="
        DB 13,10,"MORSE CODE TABLE" 
        DB 13,10,"========================================="
        DB 13,10,"A = .-"
        DB "    B = -..."
        DB "  C = -.-."
        DB "  D = -.."
        DB "   E = ."
        DB 13,10,"F = ..-."
        DB "  G = --."
        DB "   H = ...."
        DB "  I = .."
        DB "    J = .---"
        DB 13,10,"K = -.-"
        DB "   L = .-.."
        DB "  M = --"
        DB "    N = -."
        DB "    0 = ---"
        DB 13,10,"P = .--."
        DB "  Q = --.-"
        DB "  R = .-."
        DB "   S = ..."
        DB "   T = -"
        DB 13,10,"U = ..-"
        DB "   V = ...-"
        DB "  W = .--"
        DB "   X = -..-"
        DB "  Y = -.--"
        DB 13,10,"Z = --..$"
    HEADER DB                                          "======================================================="
           DB 13,10,                                   "||                                                   ||"
           DB 13,10,                                   "||               MORSE CODE TRANSLATOR               ||"  
           DB 13,10,                                   "||                                                   ||"
           DB 13,10,                                   "=======================================================$"
    SELECT DB 13,10,10,                                "                WELCOME TO OUR PROGRAM                 "
           DB 13,10,10,                                              "--------------------------- "
           DB 13,10,                                                  "|                          |"
           DB 13,10,                                                  "| MAIN MENU:               | "
           DB 13,10,                                                  "| 1.Encode                 | "
           DB 13,10,                                                  "| 2.Show Morse code lists  | "
           DB 13,10,                                                  "| 3.Exit                   | "
           DB 13,10,                                                  "|                          |"
           DB 13,10,                                                  "--------------------------- "
           DB 13,10,                                                     "Select your choice: $"
   
.CODE
.STARTUP 
    MAIN_MENU:     
    
    CALL CLEAR_SCREEN
    
    MOV AH, 9H
    MOV DX, OFFSET HEADER
    INT 21H  
    
    MOV AH, 9H
    MOV DX, OFFSET SELECT
    INT 21H  
    
    MOV AH, 1H
    INT 21H
    
    CMP AL, 31H
    JNE NOT_ENCODE
    JMP _ENCODE
    
    NOT_ENCODE:             
    CMP AL, 32H             
    JNE NOT_MORSECODE
    JMP _MORSECODE
    
    NOT_MORSECODE:
    CMP AL, 33H
    JNE NOT_REAL_EXIT
    JMP REAL_EXIT
    NOT_REAL_EXIT:
    JMP MAIN_MENU
;ENCODE   
    _ENCODE:

    CALL CLEAR_SCREEN
    MOV AX, @DATA
    MOV DS, AX        
       
    CALL GETINPUT
    
    MOV AH, 9H
    MOV DX, OFFSET STR_OUTPUT
    INT 21H
                
    CHECK_INPUT:
        MOV SI, OFFSET INPUT
        MOV COUNT, 0 
        DEC LENGTHS
         
        LP:  
            MOV DL, [SI]
            MOV AL, DL 
            MOV LETTER, AL 
            CALL CHECK_LETTER
            INC INDEX
            INC COUNT           
            INC SI
            
            MOV BL, LENGTHS[0]     
            CMP COUNT, BL
            JNE NOT_EXIT1
            JMP EXIT1
            NOT_EXIT1:
             
            JMP LP
    GETINPUT:        
        MOV AH, 9H                 
        MOV DX, OFFSET STR_INPUT
        INT 21H                 
        
        MOV SI, OFFSET INPUT      
        MOV LENGTHS, 0            
            
            LO:
                MOV AH,1H
                INT 21H 
                
                MOV [SI],AL
                INC SI
                INC LENGTHS
                
                CMP AL ,13     
                JE DONE     
                
                CMP AL, 8H     
                JE BACK
                
                JMP LO 
                BACK:          
                    CMP LENGTHS[0],1
                    JE LO  
                    CMP SI,48
                    JE LO
                    DEC SI
                    MOV AH, 2H
                    MOV DL, 20H
                    INT 21H   
                    MOV AH, 2H
                    MOV DL, 8H
                    INT 21H
                    DEC SI    
                    DEC LENGTHS
                    DEC LENGTHS
                    JMP LO 
                
            DONE:
                RET
 
    CHECK_LETTER:        
        CMP LETTER, "A"
        JNE NOT_PLAY_A
        JMP PLAY_A
        NOT_PLAY_A:
        CMP LETTER, "B"
        JNE NOT_PLAY_B
        JMP PLAY_B
        NOT_PLAY_B: 
        CMP LETTER, "C"
        JNE NOT_PLAY_C
        JMP PLAY_C
        NOT_PLAY_C:
        CMP LETTER, "D"
        JNE NOT_PLAY_D
        JMP PLAY_D
        NOT_PLAY_D:
        CMP LETTER, "E"
        JNE NOT_PLAY_E
        JMP PLAY_E
        NOT_PLAY_E:
        CMP LETTER, "F"
        JNE NOT_PLAY_F
        JMP PLAY_F
        NOT_PLAY_F:
        CMP LETTER, "G"
        JNE NOT_PLAY_G
        JMP PLAY_G
        NOT_PLAY_G:
        CMP LETTER, "H"
        JNE NOT_PLAY_H
        JMP PLAY_H
        NOT_PLAY_H:
        CMP LETTER, "I"
        JNE NOT_PLAY_I
        JMP PLAY_I
        NOT_PLAY_I:
        CMP LETTER, "J"
        JNE NOT_PLAY_J
        JMP PLAY_J
        NOT_PLAY_J:
        CMP LETTER, "K"
        JNE NOT_PLAY_K
        JMP PLAY_K
        NOT_PLAY_K:
        CMP LETTER, "L"
        JNE NOT_PLAY_L
        JMP PLAY_L
        NOT_PLAY_L:
        CMP LETTER, "M"
        JNE NOT_PLAY_M
        JMP PLAY_M
        NOT_PLAY_M:
        CMP LETTER, "N"
        JNE NOT_PLAY_N
        JMP PLAY_N
        NOT_PLAY_N:
        CMP LETTER, "O"
        JNE NOT_PLAY_O
        JMP PLAY_O
        NOT_PLAY_O:
        CMP LETTER, "P"
        JNE NOT_PLAY_P
        JMP PLAY_P
        NOT_PLAY_P:
        CMP LETTER, "Q"
        JNE NOT_PLAY_Q
        JMP PLAY_Q
        NOT_PLAY_Q:
        CMP LETTER, "R"
        JNE NOT_PLAY_R
        JMP PLAY_R
        NOT_PLAY_R:
        CMP LETTER, "S"
        JNE NOT_PLAY_S
        JMP PLAY_S
        NOT_PLAY_S:
        CMP LETTER, "T"
        JNE NOT_PLAY_T
        JMP PLAY_T
        NOT_PLAY_T:
        CMP LETTER, "U"
        JNE NOT_PLAY_U
        JMP PLAY_U
        NOT_PLAY_U:
        CMP LETTER, "V"
        JNE NOT_PLAY_V
        JMP PLAY_V
        NOT_PLAY_V:
        CMP LETTER, "W"
        JNE NOT_PLAY_W
        JMP PLAY_W
        NOT_PLAY_W:
        CMP LETTER, "X"
        JNE NOT_PLAY_X
        JMP PLAY_X
        NOT_PLAY_X:
        CMP LETTER, "Y"
        JNE NOT_PLAY_Y
        JMP PLAY_Y
        NOT_PLAY_Y:
        CMP LETTER, "Z"
        JNE NOT_PLAY_Z
        JMP PLAY_Z
        NOT_PLAY_Z:
        CMP LETTER, 13H 
        JNE NOT_PLAY_KOSONG
        JMP PLAY_EMPTY     
        NOT_PLAY_KOSONG:
        CMP LETTER, 00H 
        JNE NOT_PLAY_NULL
        JMP PLAY_EMPTY
        NOT_PLAY_NULL:
        CMP LETTER, 20H 
        JNE NOT_PLAY_SPACE
        JMP PLAY_SPACE
        NOT_PLAY_SPACE:
        RET
        
        PLAY_A:           
            MOV     AX, 3043        
            MOV     STOR, AX
            CALL    BEEPS            
            CALL    DELAYS          
            CALL    BEEPL           
            CALL    BEEPSPACE
            CALL    DELAYS          
            RET                            
        PLAY_B:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPL            
            CALL    DELAYS         
            CALL    BEEPS           
            CALL    DELAYS          
            CALL    BEEPS           
            CALL    DELAYS          
            CALL    BEEPS            
            CALL    BEEPSPACE       
            CALL    DELAYS         
            RET
        PLAY_C:           
            MOV     AX, 3043        
            MOV     STOR, AX
            CALL    BEEPL            
            CALL    DELAYS          
            CALL    BEEPS            
            CALL    DELAYS          
            CALL    BEEPL           
            CALL    DELAYS          
            CALL    BEEPS            
            CALL    BEEPSPACE               
            CALL    DELAYS          
            RET        
        PLAY_D:           
            MOV     AX, 3043        
            MOV     STOR, AX
            CALL    BEEPL           
            CALL    DELAYS          
            CALL    BEEPS            
            CALL    DELAYS         
            CALL    BEEPS           
            CALL    BEEPSPACE               
            CALL    DELAYS          
            RET        
        PLAY_E:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPS            
            CALL    BEEPSPACE       
            CALL    DELAYS          
            RET                           
        PLAY_F:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPS          
            CALL    DELAYS          
            CALL    BEEPS           
            CALL    DELAYS         
            CALL    BEEPL            
            CALL    DELAYS               
            CALL    BEEPS           
            CALL    BEEPSPACE       
            CALL    DELAYS          
            RET                                       
        PLAY_G:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPL          
            CALL    DELAYS          
            CALL    BEEPL           
            CALL    DELAYS          
            CALL    BEEPS            
            CALL    BEEPSPACE       
            CALL    DELAYS          
            RET     
            RET
        PLAY_H:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPS          
            CALL    DELAYS        
            CALL    BEEPS          
            CALL    DELAYS         
            CALL    BEEPS          
            CALL    DELAYS         
            CALL    BEEPS           
            CALL    BEEPSPACE       
            CALL    DELAYS          
            RET
        PLAY_I:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPS           
            CALL    DELAYS        
            CALL    BEEPS          
            CALL    BEEPSPACE      
            CALL    DELAYS         
            RET
        PLAY_J:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPS           
            CALL    DELAYS          
            CALL    BEEPL           
            CALL    DELAYS          
            CALL    BEEPL            
            CALL    DELAYS          
            CALL    BEEPL           
            CALL    BEEPSPACE       
            CALL    DELAYS          
            RET
        PLAY_K:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPL           
            CALL    DELAYS        
            CALL    BEEPS        
            CALL    DELAYS          
            CALL    BEEPL           
            CALL    BEEPSPACE      
            CALL    DELAYS         
            RET
        PLAY_L:           
            MOV     AX, 3043       
            MOV     STOR, AX              
            CALL    BEEPS         
            CALL    DELAYS       
            CALL    BEEPL           
            CALL    DELAYS          
            CALL    BEEPS          
            CALL    DELAYS          
            CALL    BEEPS           
            CALL    BEEPSPACE      
            CALL    DELAYS         
            RET
        PLAY_M:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPL            
            CALL    DELAYS         
            CALL    BEEPL          
            CALL    BEEPSPACE      
            CALL    DELAYS         
            RET
        PLAY_N:           
            MOV     AX, 3043       
            MOV     STOR, AX              
            CALL    BEEPL          
            CALL    DELAYS         
            CALL    BEEPS          
            CALL    BEEPSPACE       
            CALL    DELAYS          
            RET
        PLAY_O:           
            MOV     AX, 3043       
            MOV     STOR, AX              
            CALL    BEEPL          
            CALL    DELAYS          
            CALL    BEEPL           
            CALL    DELAYS        
            CALL    BEEPL           
            CALL    BEEPSPACE      
            CALL    DELAYS         
            RET
        PLAY_P:           
            MOV     AX, 3043       
            MOV     STOR, AX              
            CALL    BEEPS          
            CALL    DELAYS         
            CALL    BEEPL         
            CALL    DELAYS         
            CALL    BEEPL          
            CALL    DELAYS          
            CALL    BEEPS          
            CALL    BEEPSPACE       
            CALL    DELAYS          
            RET
        PLAY_Q:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPL           
            CALL    DELAYS         
            CALL    BEEPL         
            CALL    DELAYS         
            CALL    BEEPS          
            CALL    DELAYS         
            CALL    BEEPL         
            CALL    BEEPSPACE      
            CALL    DELAYS         
            RET
        PLAY_R:           
            MOV     AX, 3043       
            MOV     STOR, AX              
            CALL    BEEPS         
            CALL    DELAYS          
            CALL    BEEPL          
            CALL    DELAYS         
            CALL    BEEPS        
            CALL    BEEPSPACE      
            CALL    DELAYS         
            RET
        PLAY_S:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPS          
            CALL    DELAYS         
            CALL    BEEPS          
            CALL    DELAYS          
            CALL    BEEPS           
            CALL    BEEPSPACE       
            CALL    DELAYS          
            RET
        PLAY_T:           
            MOV     AX, 3043      
            MOV     STOR, AX              
            CALL    BEEPL           
            CALL    BEEPSPACE       
            CALL    DELAYS          
            RET
        PLAY_U:           
            MOV     AX, 3043       
            MOV     STOR, AX              
            CALL    BEEPS          
            CALL    DELAYS        
            CALL    BEEPS           
            CALL    DELAYS          
            CALL    BEEPL         
            CALL    DELAYS        
            CALL    BEEPL          
            CALL    BEEPSPACE     
            CALL    DELAYS         
            RET
        PLAY_V:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPS           
            CALL    DELAYS          
            CALL    BEEPS           
            CALL    DELAYS         
            CALL    BEEPS          
            CALL    DELAYS          
            CALL    BEEPL           
            CALL    BEEPSPACE      
            CALL    DELAYS          
            RET
        PLAY_W:           
            MOV     AX, 3043       
            MOV     STOR, AX              
            CALL    BEEPS        
            CALL    DELAYS          
            CALL    BEEPL          
            CALL    DELAYS         
            CALL    BEEPL          
            CALL    BEEPSPACE       
            CALL    DELAYS        
            RET
        PLAY_X:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPL           
            CALL    DELAYS          
            CALL    BEEPS           
            CALL    DELAYS          
            CALL    BEEPS           
            CALL    DELAYS          
            CALL    BEEPL            
            CALL    BEEPSPACE       
            CALL    DELAYS          
            RET
        PLAY_Y:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPL            
            CALL    DELAYS          
            CALL    BEEPS           
            CALL    DELAYS          
            CALL    BEEPL           
            CALL    DELAYS          
            CALL    BEEPL           
            CALL    BEEPSPACE       
            CALL    DELAYS         
            RET
        PLAY_Z:           
            MOV     AX, 3043        
            MOV     STOR, AX              
            CALL    BEEPL            
            CALL    DELAYS          
            CALL    BEEPL          
            CALL    DELAYS         
            CALL    BEEPS            
            CALL    DELAYS         
            CALL    BEEPS            
            CALL    BEEPSPACE       
            CALL    DELAYS          
            RET               
        RET      
        PLAY_EMPTY:           
            MOV AH, 9H
            MOV DX, OFFSET STR_EMPTY
            INT 21H
            RET      
        PLAY_SPACE:           
            MOV AH, 2H
            MOV DL, " " 
            INT 21H
            RET             
       
        EXIT1:
        JMP EXT
        
;SOUNDS
        BEEPS:
            MOV     AL, 0B6H        
            OUT     43H, Al         
            MOV     AX, STOR        
            OUT     42H, AL         
            MOV     AL, AH          
            OUT     42H, AL        
            IN      AL, 061H        
            OR      AL, 03H         
            OUT     61H, AL         
            CALL    DELAYS          
            AND     AL, 0FCH        
            OUT     61H, AL         
            CALL    CLR_KEYB        
            MOV     AH, 2H
            MOV     DL, "."
            INT     21H
        RET                            
        
        BEEPL:
            MOV     AL, 0B6H        
            OUT     43H, Al         
            MOV     AX, STOR        
            OUT     42H, AL         
            MOV     AL, AH          
            OUT     42H, AL         
            IN      AL, 061H        
            OR      AL, 03H         
            OUT     61H, AL         
            CALL    DELAYL          
            AND     AL, 0FCH        
            OUT     61H, AL       
            CALL    CLR_KEYB          
            MOV     AH, 2H
            MOV     DL,"-"
            INT     21H
        RET                      
        
        BEEPSPACE:
            CALL    DELAYS          
            MOV     AH, 2H
            MOV     DL, " "
            INT     21H
        RET                          

;DELAY
        DELAYS:
            MOV     AH, 00H         
            INT     01AH            
            ADD     DX, 2           
            MOV     BX, DX          

        PZ:
            INT     01AH            
            CMP     DX, BX          
            JL      PZ             
        RET                                      
        
        DELAYL:
            MOV     AH, 00H         
            INT     01AH            
            ADD     DX, 8          
            MOV     BX, DX          

        PX:
            INT     01AH            
            CMP     DX, BX          
            JL      PX              
        RET                         
        ;CLEAR KEYBOARD BUFFER
        CLR_KEYB:
            PUSH    ES                      
            PUSH    DI                      
            MOV     AX, 40H                 
            MOV     ES, AX                  
            MOV     AX, 1AH                 
            MOV     DI, AX                  
            MOV     AX, 1EH                 
            MOV     ES: WORD PTR [DI], AX   
            INC     DI                      
            INC     DI                      
            MOV     ES: WORD PTR [DI], AX   
            POP     DI                      
            POP     ES                      
        RET                                  
        CLEAR_SCREEN:                       
            MOV AH, 0H
            MOV AL, 3H
            INT 16
        RET
        
         EXT: 
    MOV AH, 9H
    MOV DX, OFFSET PRESS_ANY_KEY
    INT 21H  
    
    MOV AH, 1H
    INT 21H
    
    JMP MAIN_MENU
;SHOW MORSE CODE LISTS     
    _MORSECODE:
            CALL CLEAR_SCREEN
            MOV AH, 9H
            MOV DX, OFFSET MORSE_LISTS
            INT 21H
            JMP EXT
            
    REAL_EXIT:    
    .EXIT
END

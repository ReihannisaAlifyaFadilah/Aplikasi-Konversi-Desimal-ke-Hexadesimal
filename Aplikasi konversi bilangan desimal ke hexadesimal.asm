.MODEL SMALL
    .CODE
    ORG 100H

TULIS    MACRO KALIMAT
    MOV AH,09H
    LEA DX, KALIMAT
    INT 21H
    ENDM

CETAK    MACRO KARAKTER
    MOV AH,02H
    MOV DL,KARAKTER
    INT 21H
    ENDM

START:    JMP PROSES
    KAL0 DB 13,10,'Konversi Desimal ke Hexadesimal$'
    KAL1 DB 13,10,'Tekan ESC Untuk Keluar$'
    INPUT DB 13,10,'Masukkan 4 Angka Desimal: $'
    OUTPUT DB 13,10,'Hasil Konversi Dalam Hexadesimal: $'
    BIL1 DW 0
    DIGIT3 DB 0
    DIGIT2 DB 0
    DIGIT1 DB 0
    DIGIT0 DB 0

PROSES:    TULIS KAL0
    TULIS KAL1
    TULIS INPUT
    JMP VAR1

KELUAR:    INT 20H

VAR1:    LEA BX,DIGIT3
    MOV CX,4

ULANG1:    MOV AH,07H
    INT 21H
    CMP AL,27
    JE KELUAR
    CMP AL,30H
    JB ULANG1
    CMP AL,39H
    JA ULANG1
    CETAK AL
    SUB AL,30H
    MOV [BX],AL
    INC BX
    LOOP ULANG1
    LEA BX,DIGIT3
    MOV AX,1000
    MOV CH,0
    MUL CX
    PUSH AX
    INC BX
    MOV AX,100
    MOV CX,[BX]
    MOV CH,0
    MUL CX
    MOV DX,AX
    POP AX
    ADD AX,DX
    PUSH AX
    INC BX
    MOV AX,10
    MOV CX,[BX]
    MOV CH,0
    MUL CX
    MOV DX,AX
    POP AX
    ADD AX,DX
    PUSH AX
    INC BX
    MOV AX,1
    MOV CX,[BX]
    MOV CH,0
    MUL CX
    MOV DX,AX
    POP AX
    ADD AX,DX
    LEA BX,BIL1
    MOV [BX],AX

DGT3:    MOV DX,0
    MOV CX,16
    DIV CX
    ADD DL,30H
    MOV DIGIT3,DL
    CMP DIGIT3,39H
    JA ATAS3

DGT2:    MOV DX,0
    DIV CX
    ADD DL,30H
    MOV DIGIT2,DL
    CMP DIGIT2,39H
    JA ATAS2

DGT1:    MOV DX,0
    DIV CX
    ADD DL,30H
    MOV DIGIT1,DL
    CMP DIGIT1,39H
    JA ATAS1

DGT0:    MOV DX,0
    DIV CX
    ADD DL,30H
    MOV DIGIT0,DL
    CMP DIGIT0,39H
    JA ATAS0
    JMP HASIL

ATAS3:    ADD DIGIT3,7
    JMP DGT2

ATAS2:    ADD DIGIT2,7
    JMP DGT1

ATAS1:    ADD DIGIT1,7
    JMP DGT0

ATAS0:    ADD DIGIT0,7

HASIL:    TULIS OUTPUT
    CETAK DIGIT0
    CETAK DIGIT1
    CETAK DIGIT2
    CETAK DIGIT3
    JMP PROSES
END START
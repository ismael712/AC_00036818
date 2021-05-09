org 100h

section .text

    XOR AL,AL;
    XOR BL,BL;
    MOV AL, 0d;
    MOV BL, 0d;
    call sumar
    call dividir
    call exit

sumar:
    ADD AL, 0d; ;AL =0+0
    ADD BL, AL; ;AL = 0+0  BL = 0 -> BL = 0+0+0 -> BL = 0;
    MOV AL, 3d; ;AL = 3
    ADD AL, BL; ;AL = 3   BL = 0; -> AL = 3 + 0
    MOV BL, 6d; ;BL = 6
    ADD BL, AL; ;BL = 6   AL = 3 -> BL = 3 + 6 = 9
    MOV AL, 8d; ;AL = 8
    ADD AL, BL; ;AL = 8   BL = 9 -> AL = 9+8 = 17
    MOV BL, 1d; ;BL = 1
    ADD BL, AL; ;BL = 1   AL = 17 -> BL = 17+1 = 18
    MOV AL, 8d; ;AL = 8
    ADD AL, BL; ;AL = 8   BL = 18 -> AL = 18+8 = 26
    ;MOV [20Ah],AL; ; 20Ah = 26
    CMP AL, 26d; ; compara si es igual a 26d, el programa returnara y llamara a ELALIT
    JNE sumar; si es igual se seguira ejecutando sumar
    ret; retornamo

dividir:
    MOV [200h], AL;
    MOV AX, [200h];
    MOV BL, 8d;
    IDIV BL; ya que estamos trabajando con valores de 8bits se utiliza bits con signo por el primer bit significativo
    MOV byte [20Ah], AL;
    CMP AL, 3d;
    JNE dividir;
    ret;

exit:
    int 20h ; terminamos el programa

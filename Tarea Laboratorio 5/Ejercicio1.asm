org 100h

    section .text
    xor AX, AX
    xor SI, SI
    xor BX, BX
    XOR CX, CX
    xor DX, DX

    MOV SI, 0
    MOV DI, 0

    MOV DH, 10 ;fila en la que se mostrará el cursor
    MOV DL, 20 ;columna en la que se mostrará el cursor
    MOV byte[200h], 12; salto entre filas
    MOV byte[201h], 14; salto entre filas
    MOV byte[202h], 16;

    call modotexto

    primeraIteracion:
        ;Loop para mover el cursor y el caracter a imprimir en pantalla
        call movercursor ;llamada a mover cursor
        MOV CL, [cadena1+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter; Llamada a escribircaracter
        XOR CL, CL
        INC SI ; SE SUMA 1 A SI PARA CONTINUAR CON EL SIGUIENTE CARACTER
        INC DL ; SE SUMA 1 A DL PARA MOVER CURSOR A LA SIGUIENTE COLUMNA
        INC DI ; contador para terminar la ejecución del programa al llegar a 10
        CMP DI, 7 ; Comparación de DI con 7
        JB primeraIteracion; si DI es menor a 7, entonces que siga iterando.
        call espacio
        jmp segundaIteracion


     segundaIteracion:
        MOV DH, [200h];asignamos 12 a DH-> para que se vaya moviendo la posicion de la fila de 2 en 2
        call movercursor ;llamada a mover cursor
        MOV CL, [cadena1+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter; Llamada a escribircaracter
        INC SI ; SE SUMA 1 A SI PARA CONTINUAR CON EL SIGUIENTE CARACTER
        INC DL ; SE SUMA 1 A DL PARA MOVER CURSOR A LA SIGUIENTE COLUMNA
        INC DI ; contador para terminar la ejecución del programa al llegar a 10
        CMP DI,9 ; Comparación de DI con 7
        JB segundaIteracion
        call espacio;
        jmp tercerIteracion; de caso contrario, que salte a esperar tecla. 


    tercerIteracion:
        MOV DH, [201h]; asignamos 14 a DH-> para que se vaya moviendo la posicion de la fila de 2 en 2
        call movercursor ;llamada a mover cursor
        MOV CL, [cadena1+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter; Llamada a escribircaracter
        INC SI ; SE SUMA 1 A SI PARA CONTINUAR CON EL SIGUIENTE CARACTER
        INC DL ; SE SUMA 1 A DL PARA MOVER CURSOR A LA SIGUIENTE COLUMNA
        INC DI ; contador para terminar la ejecución del programa al llegar a 10
        CMP DI,7  ; Comparación de DI con 7
        JB tercerIteracion
        call espacio;
        jmp cuartaIteracion; de caso contrario, que salte a esperar tecla.*/    

     cuartaIteracion:
        MOV DH, [202h]; asignamos 16 a DH -> para que se vaya moviendo la posicion de la fila de 2 en 2
        call movercursor ;llamada a mover cursor
        MOV CL, [cadena1+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter; Llamada a escribircaracter
        INC SI ; SE SUMA 1 A SI PARA CONTINUAR CON EL SIGUIENTE CARACTER
        INC DL ; SE SUMA 1 A DL PARA MOVER CURSOR A LA SIGUIENTE COLUMNA
        INC DI ; contador para terminar la ejecución del programa al llegar a 10
        CMP DI,6  ; Comparación de DI con 7
        JB cuartaIteracion
        call espacio
        jmp esperartecla; de caso contrario, que salte a esperar tecla.*/

       espacio: ; subrutina que nos ayudara ir desplazandonos columnas por columnas donde seteamos el valor de di.
        MOV DI,0
        MOV DL,20
        RET 



    modotexto: 
        MOV AH, 0h ; activa modo texto
        MOV AL, 03h ; modo gráfico deseado(25x80 filasxcolumnas)
        INT 10h
        RET

     movercursor:
        MOV AH, 02h ; posiciona el cursor en pantalla.
        MOV BH, 0h 
        INT 10h
        RET
    escribircaracter:

        MOV AH, 0Ah ; escribe caracter en pantalla según posición del cursor
        MOV AL, CL ; denotamos el caracter a escribir en pantalla, los valores deben ser según código hexadecimal de tabla ASCII
        MOV BH, 0h ; número de página
        MOV CX, 1h ; número de veces a escribir el caracter
        INT 10h
        RET

    esperartecla:
    ;Se espera que el usuario presione una tecla
        MOV AH, 00h 
        INT 16h
    exit:
        int 20h



    section .data

    cadena1 DB 'Ismael Bladimir Chicas Garcia'

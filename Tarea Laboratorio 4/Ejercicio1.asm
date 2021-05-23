; MAIN 
          org    100h

          section .text

          MOV BP, arrNum;                       ;Puntero a arrNum
          call OddEven;                         ;Se hace el llamado a la funcion

          int 20h

          section .data                         ;Decrando las variables a utilizar en el ensamblado

arrNum    db      3,45,31,6,87,25,4,10,47,98;   ;Definiendo el arreglo de un bit(10)
divisor   equ     2;                            ;Divisor que sera el que se ocupara en dicha operacion
len       equ     $-arrNum;                     ;Tamaño del arreglo, el valor no va a cambiar por eso es constante

OddEven:                                        ;Funcion que nos ayudara a verificar si un numero es par o impar

          XOR SI, SI;                           ;Limpiando los registros a utilizar
          XOR DI, DI;
          XOR BX, BX;
          XOR CX, CX;
          XOR DX, DX;
          MOV BL, divisor;                      ;Asignandole el valor de 2 a BL
                                                ;Como no hay nada qu haga el llamado a la funcion, esta solo ejecuta la siguiente intruccion que es iteracion
iteracion: 
          XOR AX, AX;                           ;Por cada iteracion se limpiara AX, para que no se acumule la basura de los resultados de la division
          MOV AL, [BP+SI];                      ;Movemos la posicion 1, de nuestro arreglo al registro AL. Asi se hara sucesivamente pos 2 a AL, pos 3 a AL, etc.
          INC SI;                               ;Incrementamos el valor se SI en 1, el cual sera como el puntero que ayudara a recorrer la casilla de memoria
          MOV BH,AL                             ;Hacemos este movimiento antes de la division ya que AL, recibira el valor del cociente entonces perderiamos el valor del arreglo el cual esta almacemado en AL y mejor se pasa a BH
          DIV BL;                               ;AX(primera posicion del arreglo)/BL(2), y asi sucesivamente hasta llegar a la ultima posicion del arreglo
          CMP AH, 0;                            ;Ah contiene el residuo, entonces compara si el residuo entre 2 es igual a 0.
          JE even;                              ;Si es igual a 0 entonces hace un salto a la etiqueta even
          JA odd;                               ;Si es mayor a 0(si el residuo es 1) emtonces se salta a la etiqueta odd

even:       
          MOV DI, CX                            ; Movemos 0 a DI
          MOV byte [0300H + DI], BH;            ;Movemos lo que contiene BH(una posicion del arreglo) y lo movemos a la primer direccion de memoria 300, luego seria 301, 302,etc. Porque el valor de DI va ir incrementando en 1 por cada iteracion
          INC DI;                               ;Incrementamos en 1 a DI, DI = 1
          MOV CX, DI                            ;Movemos a el valor de DI(1) a CX
          CMP SI, len                           ;Comprobamos si el INDICE SI ya llego a 10
          JE exit;                              ;Si ya llego a 10 ejecuta el salto a la etiqueta exit
          jmp iteracion;                        ;Si no es 10, entonces hacemos un salto a iteracion

odd:
          MOV DI, DX                            ;Movemos 0 a DI
          MOV byte [0320H + DI], BH             ;Movemos lo que contiene BH(una posicion del arreglo) y lo movemos a la primer direccion de memoria 300, luego seria 301, 302,etc. Porque el valor de DI va ir incrementando en 1 por cada iteracion
          INC DI;                               ;Incrementamo DI en 1
          MOV DX, DI                            ;El valor de 1 lo movemos al registro DX
          CMP SI, len                           ;Comprobamos si el INDICE SI ya llego a 10
          JE exit;                              ;Si ya llego a 10 ejecuta el salto a la etiqueta exit 
          jmp iteracion;                        ;Si no es 10, entonces hacemos un salto a iteracion

                                                ;Pimera iteracion : MOV DI, CX -> CX = 0, DI =0 se incrementa en 1 el DI
                                                ;                     MOV CX,DI  -> CX=1, DI = 1 
                                                ;Segunda iteracion: CX = 1, DI = 1, incrementamos en 1 el DI
                                                ;                     DI = 2, CX = 2                   
                                                ;al final se hace ya que se esta utilixando el mismo iterador en las etiquetas ODD Y EVEN, entonces si no hiciemos esos movimeintos, dejariamos casillas de memoria en blanco,
                                                ;sn que se haga una insercion correctaosea en orden                    

exit:                                           
          ret;                                  ;Retornamos a la CALL, que ya habiendo terminado, solo ejecutara una siguiente instruccion que terminara el programa



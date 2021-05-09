    org 100h

    section .text

                XOR CX, CX;
                XOR AX, AX;
                MOV CL, 5d; 
                MOV AL, 1d;
                CMP CL, 00; compara si CL es igual a cero
                JZ salto; verifica si es 0, si es ejecuta lo que contiene la etiqueta salto

    condic      MUL CX ; en cada iteracion cx disminuye en 1
                LOOP condic ; primera iteracion CX = 5 y AX = 1 -> 5*1 = 5, es almacenado en AX = 5;
                            ; segunda iteracion CX = 4 y AX = 5 -> 5*4 = 20, es almacenado en AX = 20
                            ; tercera iteracion CX = 3 y AX = 20 -> 3*20 = 60, es almacenado en AX = 60
                            ; cuarta iteracion CX = 2 y AX = 5 -> 2*60 = 120, es almacenado en AX = 120
                            ; quinta iteracion CX = 1 y AX = 120 -> 1*120 = 120, es almacenado en AX = 120
                            ; termina el boocle ya que el contador llego a 0
    salto       MOV [20BH], AL; el resultado es almacenado en la casilla de memoria 20BH

                int 20h;
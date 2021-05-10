org 100h

section .text

    XOR AX, AX
    XOR BX,BX;
    XOR SI, SI;
    MOV BL, 8D;           cantidad de digitos del carnet, que sera utilizado para la division
    MOV word CX, 8D;      Contador que es de por si de parte del loop a la cual le asignamos 8 ya que es la cantidad de recorridos que hara, disminuyendo en 1
    MOV SI, 00;           contador que lo inicializamos en 0, ya que por cada pasada se estaria moviendo una casilla, ejemplo-> iteracion 1 : [200+0], iteracion 2: [200+1]....
    MOV byte [0200H], 00; moviendo los digitos a una casilla de memoria para asi facilitarnos el ocupar un bucle 
    MOV byte [0201H], 00;
    MOV byte [0202H], 00;
    MOV byte [0203H], 03;
    MOV byte [0204H], 06;
    MOV byte [0205H], 08;
    MOV byte [0206H], 01;
    MOV byte [0207H], 08;                        

    jmp iterar           ;vamos hacer un salto hacia el bucle


iterar:
    ADD AL, [0200H + SI]; se va ir sumando cada casilla de memoria y se ira almacenando en AL
    INC SI; incrementamos el contador de nuestro indice
    LOOP iterar; se repetira hasta que nuestro contador CX disminuya a 0

dividir:
    DIV BL;
    MOV [020AH], AL;
    jmp exit;

exit:
    int 20h;



org 	100h

	section	.text

    mov BP, frase       ;Ingresamos la palabra
    call LeerCadena     ;se lee la palabra ingresada
    call EscribirCadena 
    call EsperarTecla   ;espera que el usuario ingrese 


	int 	20h

	section	.data
   msg1  db "BIENVENIDO$"
   msg2  db "INCORRECTO$"
   clave db "isma1$"
   frase 	times 	10  	db	" " 	

; FUNCIONES

; Permite leer un carácter de la entrada estándar con echo
; Parámetros:   AH: 07h         
; Salida:       AL: caracter ASCII leído
EsperarTecla:
        mov     AH, 01h         
        int     21h
        ret


; Leer cadena de texto desde el teclado
; Salida:       SI: longitud de la cadena 		BP: direccion de guardado
LeerCadena:
        XOR     SI, SI          ;Limpiamos el acumulador
        ;XOR     DI, DI
       
while:  
        call    EsperarTecla    ; retorna un caracter en AL
        cmp     AL, 0x0D        ; comparar AL con caracter EnterKey
        je      exit            ; si AL == EnterKey, saltar a exit
        MOV     [BP+SI], AL   	; guardar caracter en memoria


        MOV CL, [frase+SI]      ;Recorriendo la palabra insertada, caracter por caracter y lo vamos guardando en cl
        MOV BL, [clave+SI]      ;Recorriendo la clave guardada en una variable y la guardamos en un registro
        INC     SI              ;Incrementamos el acumulador
        CMP BL, CL              ;Comparamos caracter de la clave con caracter de la palabra insertada, iteracion por itereracion para comprobar si son igual
        JE correcto             ;Si es igual el caracter por caracter, lo mandamos a la etiqueta correcto
        JNP incorrecto          ;Si no es igual lo mandamos a la otra etiqueta
        jmp     while           ;Saltar a while
exit:
    	mov byte [BP+SI], "$"	; agregar $ al final de la cadena
        cmp DI, 0               ;comparamos si di es igual a 0
        JG error                ; verifica que si no es igual a 0, osea el destino es mayor que la fuente entonces hacemos el salto a Error
        ret                     ; si es igual a 0, solo retornamos, a leer cadena la palabra "BIENVENIDO"

correcto:
        XOR DX, DX              ;Limpiamos los registros que guardaran nuestras cadenas de respuesta
        MOV DX, msg1            ;El mensaje lo guardamos en el registro
        jmp while               ;

incorrecto:
        XOR DI, DI              ;Limpiamos los indices
        INC DI                  ;Si es incorrecto pues sumamos 1 al contador
        jmp while               ;volvemos a iterar el bucle

error:
        MOV DX, msg2            ;Limpiamos los registros que guardaran nuestras cadenas de respuesta
        RET                     ;Retornamos a la funcion leerCadena el mensaje, dado una comprobacion que seria "INCORRECTO"


; Permite escribir en la salida estándar una cadena de caracteres o string, este
; debe tener como terminación el carácter “$”
; Parámetros:	AH: 09h 	DX: dirección de la celda de memoria inicial de la cadena
EscribirCadena:
	mov 	AH, 09h
	int 	21h
	ret
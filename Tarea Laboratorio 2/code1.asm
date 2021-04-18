        org 	100h
        section	.text

        ;Escribir cuatro iniciales de su nombre completo empezando en la dirección de memoria 200h

        mov   byte[200h], "I"
        mov   byte[201h], "B"
        mov   byte[202h], "C"
        mov   byte[203h], "G"

        ; Direcciomiento directo
         mov   AX, [200h]

        ;direccionamiento indirecto por registro
        mov   BX, 201h
        mov   CX, [BX]

        ; direccionamiento indirecto base más índice
        mov   BX,  202h
        mov   DX, [BX+SI]

        ;direccionamiento relativo por registro
        mov   DI, [SI+203h]

        int 20h


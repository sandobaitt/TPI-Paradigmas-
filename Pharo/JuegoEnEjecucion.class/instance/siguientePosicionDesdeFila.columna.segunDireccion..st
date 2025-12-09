accessing
siguientePosicionDesdeFila: fila columna: col segunDireccion: unaDireccion
    "unaDireccion podría ser un símbolo: #arriba, #abajo, #izquierda, #derecha."
    unaDireccion = #arriba    ifTrue: [ ^ col @ (fila - 1) ].
    unaDireccion = #abajo     ifTrue: [ ^ col @ (fila + 1) ].
    unaDireccion = #izquierda ifTrue: [ ^ (col - 1) @ fila ].
    unaDireccion = #derecha   ifTrue: [ ^ (col + 1) @ fila ].
    ^ col @ fila  "fallback raro, por si acaso"

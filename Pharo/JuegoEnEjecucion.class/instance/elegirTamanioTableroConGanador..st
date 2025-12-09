accessing
elegirTamanioTableroConGanador: unJugadorGanador
    | opciones indice |

    opciones := #('8 x 8' '10 x 10').

    indice := UIManager default
        chooseFrom: opciones
        title: 'Ganó ', unJugadorGanador nombre,
               '. Elija el tamaño del tablero.'.

    indice = 0 ifTrue: [ ^ self ].  "por si cancela"

    indice = 1 ifTrue: [ self tamanioTablero: 8 ].
    indice = 2 ifTrue: [ self tamanioTablero: 10 ].




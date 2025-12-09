actions
refrescarTablaJugadores
    "Vuelve a cargar la tabla de jugadores (nombre y vidas)."
	| jugadores |

    tablaJugadores isNil ifTrue: [ ^ self ].
    juego isNil ifTrue: [ ^ self ].

    jugadores := OrderedCollection new.

    juego jugador1 ifNotNil: [ jugadores add: juego jugador1 ].
    juego jugador2 ifNotNil: [ jugadores add: juego jugador2 ].

    tablaJugadores items: jugadores.

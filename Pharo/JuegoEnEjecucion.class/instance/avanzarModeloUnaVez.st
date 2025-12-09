accessing
avanzarModeloUnaVez
    "Avanza un paso el sistema para un solo jugador (el del turno actual).
    Aplica reglas de flecha, rotación, vidas y fin de juego."

    self juegoTerminado ifTrue: [ ^ self ].

    self turnoJugador1
        ifTrue: [ self avanzarJugador: jugador1 ]
        ifFalse: [ self avanzarJugador: jugador2 ].

    self actualizarEstadoJuego.

    "Si después de avanzar se terminó el juego, no cambiamos el turno"
    self juegoTerminado ifTrue: [ ^ self ].

    "Cambiar turno para la próxima jugada"
    self turnoJugador1: self turnoJugador1 not.

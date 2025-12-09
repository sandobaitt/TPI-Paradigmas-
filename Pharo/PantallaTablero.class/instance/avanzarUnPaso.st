actions
avanzarUnPaso
    "Avanza el modelo un paso (los dos jugadores) y refresca la vista."

    juego isNil ifTrue: [ ^ self ].

    juego juegoTerminado ifTrue: [
        UIManager default inform: 'La partida ya terminó.'.
        ^ self
    ].

    juego avanzarModeloUnaVez.

    self actualizarTablero.
    self refrescarTablaJugadores.

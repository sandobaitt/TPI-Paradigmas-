actions
avanzarTodo
    "Avanza el modelo hasta que el juego termine y luego refresca la vista."

    juego isNil ifTrue: [ ^ self ].

    [ juego juegoTerminado ] whileFalse: [
        juego avanzarModeloUnaVez
    ].

    self actualizarTablero.
    self refrescarTablaJugadores.

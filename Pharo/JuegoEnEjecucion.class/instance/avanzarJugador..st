accessing
avanzarJugador: unJugador
    "Hace que unJugador siga la flecha de la celda actual 1 paso.
    Rota la flecha 90° en la celda de origen y aplica power-ups / muerte."

    | fila col celdaActual direccion nuevaPos fila2 col2 celdaNueva |
    
    (unJugador estaMuerto or: [ unJugador posicion isNil ]) ifTrue: [
        ^ self ].

    fila := unJugador posicion y.
    col  := unJugador posicion x.

    celdaActual := tablero celdaEnFila: fila columna: col.
    direccion := celdaActual direccion.

    "Calculamos nueva fila/columna según flecha"
    nuevaPos := self siguientePosicionDesdeFila: fila
                                columna: col
                          segunDireccion: direccion.
    fila2 := nuevaPos y.
    col2  := nuevaPos x.

    "Rotar flecha de la celda que dejamos"
    celdaActual rotar90.

    (tablero dentroDeLimitesFila: fila2 columna: col2)
        ifFalse: [
            "Se fue del tablero → pierde una vida"
            unJugador perderVida.
            (unJugador estaMuerto) ifTrue: [
                "nada más que hacer, posible fin de juego"
            ].
            ^ self ].

    "Sigue dentro del tablero"
    celdaNueva := tablero celdaEnFila: fila2 columna: col2.
    unJugador posicion: nuevaPos.

    celdaNueva esEspecial ifTrue: [
        "Aplicar power-up (ej: gana vidasExtra)"
        unJugador ganarVidas: celdaNueva vidasExtra.
        celdaNueva desactivarPowerUp
    ].

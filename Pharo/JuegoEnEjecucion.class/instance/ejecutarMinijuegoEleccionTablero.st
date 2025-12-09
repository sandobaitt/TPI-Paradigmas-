accessing
ejecutarMinijuegoEleccionTablero
    "Corre el minijuego según si se juega contra CPU o no
    y luego guarda el tamaño del tablero elegido."
    | minijuego ganador |
    minijuego := Minijuego new.

    ganador := self juega_cpu
        ifTrue:  [ minijuego jugarJugador: self jugador1 contraCPU: self jugador2 ]
        ifFalse: [ minijuego jugarCon: self jugador1 y: self jugador2 ].

    self elegirTamanioTableroConGanador: ganador



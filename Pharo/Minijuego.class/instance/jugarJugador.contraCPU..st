actions
jugarJugador: unJugador contraCPU: cpuJugador
    "Versión del minijuego cuando se juega contra la CPU."

    | ganador |
    ganador := nil.

    [ ganador isNil ] whileTrue: [
        numeroJugador1 := self pedirNumeroPara: unJugador.
        numeroJugador2 := self generarNumeroCPU.
        numeroSecreto := self generarNumeroSecreto.

        ganador := self
            determinarGanadorEntre: unJugador
            y: cpuJugador
            numero1: numeroJugador1
            numero2: numeroJugador2
            secreto: numeroSecreto
    ].

    UIManager default inform:
        'El número secreto fue ', numeroSecreto asString, String cr,
        'El jugador eligió: ', numeroJugador1 asString, String cr,
        'La CPU eligió: ', numeroJugador2 asString, String cr,
        'Ganó: ', ganador nombre.

    ^ ganador

actions
jugarEntre: jugador1 y: jugador2 esCpuSegundo: esCpu
    "Corre el minijuego entre jugador1 y jugador2.
     Si esCpu = true, el segundo número lo elige la CPU (aleatorio).
     Devuelve el jugador ganador, o nil si hubo empate."

    | numero1 numero2 secreto ganador |

    "Número del primer jugador (siempre humano en tu diseño)"
    numero1 := self pedirNumeroPara: jugador1.

    "Número del segundo: humano o CPU"
    esCpu
        ifTrue: [ numero2 := self numeroAleatorioParaCPU ]
        ifFalse: [ numero2 := self pedirNumeroPara: jugador2 ].

    secreto := self generarNumeroSecreto.

    ganador := self
        determinarGanadorEntre: jugador1
        y: jugador2
        numero1: numero1
        numero2: numero2
        secreto: secreto.

    ganador isNil ifFalse: [
        UIManager default inform:
            'El ganador del minijuego es ', ganador nombre ].

    ^ganador.

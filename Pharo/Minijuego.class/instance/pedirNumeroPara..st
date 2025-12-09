actions
pedirNumeroPara: unJugador
    | entrada numero nombreJugador |

    nombreJugador := unJugador nombre.

    [
        entrada := UIManager default
            request: 'Jugador ', nombreJugador, String cr,
                     'Ingrese un número entre 0 y 100:'
            initialAnswer: ''.

        entrada isNil ifTrue: [
            UIManager default inform: 'No se puede cancelar el minijuego.'.
            ^ self pedirNumeroPara: unJugador ].  "vuelve a pedir"

        [ numero := entrada asInteger ]
            on: Error
            do: [
                UIManager default inform: 'Debe ingresar un número entero.'.
                numero := nil ].

        (numero notNil and: [ numero between: 0 and: 100 ])
            ifFalse: [
                UIManager default inform: 'El número debe estar entre 0 y 100.'.
                numero := nil ].

        numero isNil
    ] whileTrue.

    ^ numero

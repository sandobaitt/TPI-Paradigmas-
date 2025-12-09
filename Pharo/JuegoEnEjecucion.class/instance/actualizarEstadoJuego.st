accessing
actualizarEstadoJuego
    "Revisa si alguno de los jugadores murió o salió del tablero.
    Marca juegoTerminado y ganador en consecuencia."
    
    | vivo1 vivo2 |
    vivo1 := jugador1 notNil and: [ jugador1 estaMuerto not ].
    vivo2 := jugador2 notNil and: [ jugador2 estaMuerto not ].

    (vivo1 and: [ vivo2 ]) ifTrue: [ ^ self ].  "siguen los dos"

    (vivo1 and: [ vivo2 not ]) ifTrue: [
        juegoTerminado := true.
        ganador := jugador1.
		  PantallaFinal abrir.
        ^ self ].

    (vivo2 and: [ vivo1 not ]) ifTrue: [
        juegoTerminado := true.
        ganador := jugador2.
    	  PantallaFinal abrir.
		  ^ self ].

    "Si ninguno está vivo, empate raro"
    juegoTerminado := true.
    ganador := nil.

accessing
ejecutarMinijuegoTurnosYTablero
    "Vuelve a correr el minijuego (PvP o contra CPU),
     decide quién empieza, arma el tablero y abre la pantalla."
    | mini ganadorTurnos perdedor tamanio nuevoTablero |

    (self jugador1 isNil or: [ self jugador2 isNil ]) ifTrue: [
        UIManager default inform: 'Faltan jugadores cargados.'.
        ^ self
    ].

    self tamanioTablero isNil ifTrue: [
        UIManager default inform: 'Todavía no se eligió el tamaño del tablero.'.
        ^ self
    ].

    "---------- SEGUNDO MINIJUEGO: quién empieza ----------"
    mini := Minijuego new.

    ganadorTurnos := self juega_cpu
        ifTrue: [ mini jugarJugador: self jugador1 contraCPU: self jugador2 ]
        ifFalse: [ mini jugarCon: self jugador1 y: self jugador2 ].

    ganadorTurnos isNil ifTrue: [
        "Empate: el propio minijuego ya informó que se vuelve a jugar."
        ^ self
    ].

    perdedor := (ganadorTurnos == self jugador1)
        ifTrue: [ self jugador2 ]
        ifFalse: [ self jugador1 ].

    "En el modelo, jugador1 va a ser el que comienza"
    self jugador1: ganadorTurnos.
    self jugador2: perdedor.

    "---------- Crear tablero según el tamaño elegido ----------"
    tamanio := self tamanioTablero.
    nuevoTablero := Tablero cuadradoDe: tamanio.
    self tablero: nuevoTablero.

    "Posiciones iniciales (ajustá si tus reglas son otras)"
    PantallaEleccionPosicion
	 	 abrirParaJugador: (self jugador1)
		 conSiguienteAccion: [
		    PantallaEleccionPosicion
			    abrirParaJugador: (self jugador2)
			    conSiguienteAccion: [
					 pantallaTablero := PantallaTablero abrirConJuego: self.
				 ].
		 ].
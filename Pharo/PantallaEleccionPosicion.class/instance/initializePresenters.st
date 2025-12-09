initialization
initializePresenters
	"Método utilizado para inicializar todos
	los elementos de la pantalla y definir
	sus comportamientos."
	caja_pos_x := self newTextInput.
	caja_pos_y := self newTextInput.
	boton_sig := self newButton.
	
	boton_sig
		label: 'Grabar posición';
		action: [
			| pos_x pos_y instancia_juego |.
			instancia_juego := JuegoEnEjecucion instancia_actual.
			pos_x := (caja_pos_x text) asInteger.
			pos_y := (caja_pos_y text) asInteger.
			jugador_a_posicionar posicion: (pos_y @ pos_x).
			
			"Controlamos que los jugadores no se pongan en
			la misma posición."
			(jugador_a_posicionar = instancia_juego jugador2) ifTrue: [
				(jugador_a_posicionar posicion = instancia_juego jugador1 posicion) ifTrue: [
					^self error: 'No pueden posicionarse ambos jugadores en la misma ubicacion.'.
				].
			].

			"Controlamos que el jugador se posicione en una posicion
			válida."
			(pos_x < 1 or: [pos_x > instancia_juego tablero filas]) ifTrue: [
				^self error: 'Por favor, elija un número de fila válido.'.
			].

			(pos_y < 1 or: [pos_y > instancia_juego tablero columnas]) ifTrue: [
				^self error: 'Por favor, elija un número de columna válido.'.
			].
			
			self siguiente_accion value.
			self window close.
		].
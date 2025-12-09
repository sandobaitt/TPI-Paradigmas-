initialization
initializePresenters
	"Método utilizado para inicializar todos
	los elementos de la pantalla y definir
	sus comportamientos."
	| txt_msg |.
	txt_msg := #(
		'======================'
		'¿Cómo funciona el juego?'
		'======================'
		'Se cuenta con un tablero que tiene casillas rellenadas con flechas (↑, →, ↓, ←). En'
		'cada turno, el jugador que está parado en una casilla dada se mueve en la dirección'
		'que esta indica y, al cambiar de posición, la casilla es coloreada con el color'
		'asignado al jugador que la ocupó por última vez, mientras que la flecha que contiene'
		'es rotada en sentido horario unos 90°.'
		''
		'El juego puede ser jugado contra otra persona o contra la máquina. En caso de que se'
		'opte por enfrentarse a otra persona, el tamaño del tablero y el jugador que inicia la'
		'partida serán elegidos en un minijuego, que consiste en tratar de adivinar cuál es el'
		'número generado al azar por la computadora. El jugador que más se acerque al número'
		'generado por la computadora gana.'
		''
		'======='
		'REGLAS'
		'======='
		'a) No puede haber dos jugadores parados en la misma casilla.'
		'b) Si un jugador se encuentra ubicado en el borde del tablero y su flecha le ordena'
		'   moverse al vacío, perderá automáticamente al comenzar su turno.'
	) joinUsing: Character cr.
	
	explicacion := self newText.
	explicacion
		text: txt_msg;
		editable: false.
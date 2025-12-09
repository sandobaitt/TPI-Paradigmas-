setting
num_jugador_titulo: unNumero
	"Con este método se le asigna un valor
	al atributo num_jugador_titulo, con la
	finalidad de que después, al mostrar la
	ventana de introducción de información
	del jugador, en el título se indique a
	qué jugador se le está solicitando el
	nombre."
	
	(unNumero isInteger) ifFalse: [
		| error_msg |.
		error_msg := #(
			'El atributo num_jugador_titulo'
			'de PantallaInfoJugador debe ser'
			'un número entero.'
		) joinUsing: ' '.
		^self error: error_msg.
	].

	(unNumero <= 0 or: unNumero > 2) ifTrue: [
		^self error: 'El atributo num_jugador_titulo debe tener 1 o 2 como valor'.
	].

	num_jugador_titulo := unNumero.
private
chequearTipoValorJugador: unValor
	"Método utilizado para controlar que
	los valores que se le quieran asignar
	a los atributos jugador1 y jugador2
	sean del tipo de dato correcto."
	| error_msg |
	(unValor isNil or: (unValor isKindOf: Jugador)) ifTrue: [ ^self ].
	error_msg := #(
		'Los atributos jugador1 y jugador2'
		'de la clase "Juego" solo pueden'
		'tener nil o un objeto de tipo'
		'"Jugador" como valor.'
	) joinUsing: ' '.
	^self error: error_msg.
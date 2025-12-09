actions
ejecutarSiguienteAccion
	"Método utilizado para definir el
	comportamiento del botón 'Siguiente'."
	| nombre_jugador instancia_juego jugador |.
	nombre_jugador := self obtenerNombreIntroducido.
	
	(nombre_jugador isEmpty) ifTrue: [
		^self error: 'Se debe introducir un nombre válido para el jugador ', num_jugador_titulo asString.
	].
	
	instancia_juego := JuegoEnEjecucion instancia_actual.
	jugador := Jugador nuevoConNombre: nombre_jugador.
	
	"En función del valor de 'num_jugador_titulo'
	se deduce qué jugador está siendo registrado."
	(num_jugador_titulo = 1)
		ifTrue: [
			instancia_juego jugador1: jugador.
		]
		ifFalse: [
			instancia_juego jugador2: jugador.
		].

	self window close.
	self siguiente_accion value.
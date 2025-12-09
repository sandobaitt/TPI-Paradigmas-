instance creation
abrirParaJugador: unJugador conSiguienteAccion: unaSiguienteAccion
	"Método para instanciar objetos de esta
	clase, recibiendo como parámetros el
	objeto correspondiente al jugador al
	cual se le debe solicitar una posicion y
	un bloque de acciones a ejecutar cuando
	el usuario presione el botón 'Siguiente'."
	| pantalla |.
	pantalla := self new
		jugador_a_posicionar: unJugador;
		siguiente_accion: unaSiguienteAccion.
	pantalla := pantalla open.
	pantalla window
		removeCollapseBox;
		removeExpandBox;
		removeMenuBox;
		removeCloseBox;
		beUnresizeable.
	
	^pantalla.
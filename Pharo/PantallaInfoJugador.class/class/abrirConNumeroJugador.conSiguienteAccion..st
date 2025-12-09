instance creation
abrirConNumeroJugador: unNumero conSiguienteAccion: unaSiguienteAccion
	"Método para instanciar objetos de esta
	clase, recibiendo como parámetros el
	número correspondiente al jugador al
	cual se le debe solicitar su nombre y
	un bloque de acciones a ejecutar cuando
	el usuario presione el botón 'Siguiente'."
	| pantalla |.
	pantalla := self new
		num_jugador_titulo: unNumero;
		siguiente_accion: unaSiguienteAccion.
	pantalla := pantalla open.
	pantalla window
		removeCollapseBox;
		removeExpandBox;
		removeMenuBox;
		removeCloseBox;
		beUnresizeable.
	
	^pantalla.
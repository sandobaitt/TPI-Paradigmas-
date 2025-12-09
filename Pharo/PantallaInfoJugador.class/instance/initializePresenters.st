initialization
initializePresenters
	"Método utilizado para inicializar todos
	los elementos de la pantalla y definir
	sus comportamientos."
	|instancia_global_juego|.
	instancia_global_juego := JuegoEnEjecucion instancia_actual.
	caja_txt := self newTextInput.
	boton_sig := self newButton.
	boton_retroceder := self newButton.
	
	boton_sig
		label: 'Siguiente';
		action: [
			self ejecutarSiguienteAccion.
		].
	
	boton_retroceder
		label: 'Cancelar y retroceder';
		action: [
			self window close.
			PantallaInicial abrir.
			"Si se vuelve al menú anterior, conviene
			resetear el estado global para no quedar
			con información que ya no sirve del
			estado anterior."
			instancia_global_juego jugador1: nil.
			instancia_global_juego jugador2: nil.
			instancia_global_juego juega_cpu: false.
		].
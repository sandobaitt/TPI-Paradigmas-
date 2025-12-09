initialization
initializePresenters
	"Método utilizado para inicializar todos
	los elementos de la pantalla y definir
	sus comportamientos."
	boton_volver := self newButton.
	
	boton_volver
		label: 'Volver al menú';
		icon: (self iconNamed: #back );
		action: [
			|instancia_juego|.
			instancia_juego := JuegoEnEjecucion instancia_actual.
			self window close.
			instancia_juego pantallaTablero window close.
			PantallaInicial abrir.
			instancia_juego reiniciar.
		].
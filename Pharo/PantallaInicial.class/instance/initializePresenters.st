initialization
initializePresenters
	"Método utilizado para inicializar todos
	los elementos de la pantalla y definir
	sus comportamientos."
	boton_iniciar := self newButton.
	boton_explicacion := self newButton.
	boton_salir := self newButton.
	
	boton_iniciar
		label: 'Jugar';
		icon: (self iconNamed: #go);
		action: [
         | registro_segundo_jugador instancia_global_juego |
			instancia_global_juego := JuegoEnEjecucion instancia_actual.
         instancia_global_juego reiniciar.

         "Se jugará JUGADOR vs JUGADOR"
         instancia_global_juego juega_cpu: false.

         registro_segundo_jugador := [ 
            | primer_minijuego |

            "Bloque que se ejecuta cuando ya se cargó el nombre del JUGADOR 2"
            primer_minijuego := [
            | juego |
            juego := JuegoEnEjecucion instancia_actual.

            "1) Minijuego para elegir quién decide el tamaño del tablero"
            juego ejecutarMinijuegoEleccionTablero.

            "2) Segundo minijuego para decidir quién empieza + abrir tablero"
            juego ejecutarMinijuegoTurnosYTablero.
            ].

            "Pantalla para el JUGADOR 2"
            PantallaInfoJugador
            abrirConNumeroJugador: 2
            conSiguienteAccion: primer_minijuego.
         ].

         self window close.
         "Pantalla para el JUGADOR 1"
         PantallaInfoJugador
         abrirConNumeroJugador: 1
         conSiguienteAccion: registro_segundo_jugador.
      ].
	
	boton_explicacion
		label: 'Ver una explicación sobre el juego';
		icon: (self iconNamed: #smallInfo);
		action: [
			ExplicacionJuego abrir.
		].
	
	boton_salir
		label: 'Salir del juego';
		icon: (self iconNamed: #stop);
		action: [
			self window close.
		].
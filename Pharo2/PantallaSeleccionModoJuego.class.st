"
""PantallaSeleccionModoJuego"" es la clase que permite
inicializar y mostrar la pantalla de selección del
modo de juego del Sistema Repulsor Dinámico. La pantalla
cuenta con tres botones que proveen las siguientes funciones:

* Jugar contra otra persona.
* Jugar contra la computadora.
* Volver al menú principal.

Para proveer las funcionalidades de los botones,
esta clase depende de dos clases:

* ""PantallaInfoJugador"".
* ""PantallaInicial"".

======================
Representación interna
======================
La clase está compuesta por las siguientes variables de
instancia:

* <<boton_pvp>>: contiene el botón para elegir jugar
  contra otra persona.
* <<boton_pve>>: contiene el botón para elegir jugar
  contra la computadora.
* <<boton_retroceder>>: contiene el botón para volver
  al menú anterior.

====================
Métodos de instancia
====================
La clase provee los siguientes métodos de instancia:

* <<initializePresenters>>: permite inicializar los elementos
  de la clase y definir el comportamiento que tendrán.
* <<initializeWindow:>>: permite establecer las propiedades de
  la pantalla.
* <<defaultLayout>>: permite especificar la estética que tendrá
  la pantalla.

================
Métodos de clase
================
La clase provee los siguientes métodos de clase:

* <<abrir>>: heredado de ""Pantalla"", es utilizado para abrir
  la pantalla representada por este método.
"
Class {
	#name : 'PantallaSeleccionModoJuego',
	#superclass : 'Pantalla',
	#instVars : [
		'boton_pvp',
		'boton_pve',
		'boton_retroceder'
	],
	#category : 'TPI-Menus',
	#package : 'TPI',
	#tag : 'Menus'
}

{ #category : 'layout' }
PantallaSeleccionModoJuego >> defaultLayout [
	"Método utilizado para definir el
	esquema de organización de los
	elementos en pantalla."
	self centered.
	^SpBoxLayout newTopToBottom
		add: boton_pvp;
		add: boton_pve;
		add: boton_retroceder;
		spacing: 10;
		yourself.
]

{ #category : 'initialization' }
PantallaSeleccionModoJuego >> initializePresenters [
	"Método utilizado para inicializar todos
	los elementos de la pantalla y definir
	sus comportamientos."
	|instancia_global_juego|.
	instancia_global_juego := Juego instancia_actual.
	boton_pvp := self newButton.
	boton_pve := self newButton.
	boton_retroceder := self newButton.
	
	boton_pvp
		label: 'Jugar contra otra persona';
		action: [
			| registro_segundo_jugador |.
			
			registro_segundo_jugador := [ 
				| primer_minijjuego |.
				primer_minijjuego := [
					"Acá iría el contenido que se debe
					ejecutar luego de que se registre
					el nombre del segundo jugador."
				].
				
				PantallaInfoJugador
					abrirConNumeroJugador: 2
					conSiguienteAccion: primer_minijjuego.
			].
			
			PantallaInfoJugador
				abrirConNumeroJugador: 1
				conSiguienteAccion: registro_segundo_jugador.
		].
	
	boton_pve
		label: 'Jugar contra la computadora';
		action: [
		].
	
	boton_retroceder
		label: 'Volver al menú inicial';
		action: [
			self window close.
			PantallaInicial abrir.
		].
]

{ #category : 'initialization' }
PantallaSeleccionModoJuego >> initializeWindow: aWindowPresenter [
	"Método utilizado para establecer
	el título y tamaño de la ventana."
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Selección de modo de juego';
		initialExtent: 420@260.
]

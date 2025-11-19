"
""ExplicacionJuego"" es la clase que permite inicializar y
mostrar el apartado de explicación del funcionamiento del
Sistema Repulsor Dinámico en el menú principal.

======================
Representación interna
======================
La clase está compuesta por las siguientes variables de
instancia:

* <<explicacion>>: contiene el campo de texto en el que
  se muestra la explicación del funcionamiento del juego
  y de sus reglas.

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

* <<abrir>>: sobreescritura del método heredado de la clase
  ""Pantalla"", para poder preservar el botón de cierre de
  ventana.
"
Class {
	#name : 'ExplicacionJuego',
	#superclass : 'Pantalla',
	#instVars : [
		'explicacion'
	],
	#category : 'TPI-Menus',
	#package : 'TPI',
	#tag : 'Menus'
}

{ #category : 'instance creation' }
ExplicacionJuego class >> abrir [
	"Sobreescritura del método provisto
	por la clase 'Pantalla', porque para
	esta ventana sí se necesita el botón
	para cerrar."
	| pantalla |.
	pantalla := self new open.
	pantalla window
		removeCollapseBox;
		removeExpandBox;
		removeMenuBox;
		beUnresizeable.
	
	^pantalla.
]

{ #category : 'layout' }
ExplicacionJuego >> defaultLayout [
	"Método utilizado para definir el
	esquema de organización de los
	elementos en pantalla."
	self centered.
	^SpBoxLayout newTopToBottom
		add: explicacion;
		yourself.
]

{ #category : 'initialization' }
ExplicacionJuego >> initializePresenters [
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
]

{ #category : 'initialization' }
ExplicacionJuego >> initializeWindow: aWindowPresenter [
	"Método utilizado para establecer
	el título y tamaño de la ventana."
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Explicación de reglas y funcionamiento';
		initialExtent: 500@465
]

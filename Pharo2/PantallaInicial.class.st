"
""PantallaInicial"" es la clase que permite inicializar y
mostrar la pantalla inicial del Sistema Repulsor Dinámico.
La pantalla cuenta con tres botones que proveen las
siguientes funciones:

* Iniciar el juego.
* Ver una explicación del juego.
* Salir.

Para proveer las funcionalidades de los primeros dos
botones, esta clase depende de dos clases:

* ""PantallaSeleccionModoJuego"".
* ""ExplicacionJuego"".

Para poder ejecutar el juego y mostrar esta pantalla, se
debe utilizar el método <<ejecutar>> de la clase ""Juego""
con el siguiente llamado: ""Juego ejecutar"".

======================
Representación interna
======================
La clase está compuesta por las siguientes variables de
instancia:

* <<boton_iniciar>>: contiene el botón para ir a la
  pantalla de selección de modo de juego.
* <<boton_explicacion>>: contiene el botón para ver
  una explicación de como funciona el juego y sus
  reglas.
* <<boton_salir>>: contiene el botón para salir del
  juego.

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
	#name : 'PantallaInicial',
	#superclass : 'Pantalla',
	#instVars : [
		'boton_iniciar',
		'boton_explicacion',
		'boton_salir'
	],
	#category : 'TPI-Menus',
	#package : 'TPI',
	#tag : 'Menus'
}

{ #category : 'layout' }
PantallaInicial >> defaultLayout [
	"Método utilizado para definir el
	esquema de organización de los
	elementos en pantalla."
	self centered.
	^SpBoxLayout newTopToBottom
		add: boton_iniciar;
		add: boton_explicacion;
		add: boton_salir;
		spacing: 10;
		yourself.
]

{ #category : 'initialization' }
PantallaInicial >> initializePresenters [
	"Método utilizado para inicializar todos
	los elementos de la pantalla y definir
	sus comportamientos."
	boton_iniciar := self newButton.
	boton_explicacion := self newButton.
	boton_salir := self newButton.
	
	boton_iniciar
		label: 'Seleccionar modo de juego';
		icon: (self iconNamed: #thumbsUp);
		action: [
			self window close.
			PantallaSeleccionModoJuego abrir.
		].
	
	boton_explicacion
		label: 'Ver una explicación sobre el juego';
		icon: (self iconNamed: #user);
		action: [
			ExplicacionJuego abrir.
		].
	
	boton_salir
		label: 'Salir del juego';
		icon: (self iconNamed: #thumbsDown);
		action: [
			self window close.
		].
]

{ #category : 'initialization' }
PantallaInicial >> initializeWindow: aWindowPresenter [
	"
	Método utilizado para establecer
	el título y tamaño de la ventana.
	
	Acá, el parámetro aWindowPresenter
	es como el parámetro aStream que
	se le pasa a printOn, siendo implícito.
	Es la ventana que resulta de hacer
	'PantallaInicial new open', de clase
	'SpWindowPresenter'.
	"
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Menú inicial del Sistema Dinámico Repulsor';
		initialExtent: 420@260.
]

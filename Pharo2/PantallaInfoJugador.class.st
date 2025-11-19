"
""PantallaInfoJugador"" es la clase que permite inicializar
y mostrar la pantalla para solicitar el nombre de un jugador.
Esta pantalla permite introducir un nombre de jugador, o bien,
regresar al menú de selección de modo, para lo cual provee
dos botones.

Para proveer las funcionalidades de los botones, esta clase
depende de las siguientes clases:

* ""Jugador"".
* ""PantallaSeleccionModoJuego"".

======================
Representación interna
======================
La clase está compuesta por las siguientes variables de
instancia:

* <<num_jugador_titulo>>: contiene el número correspondiente
  al jugador al cual se le está pidiendo que introduzca su
  nombre. Se usa para personalizar el título de la ventana,
  de manera que diga ""Introduzca el nombre del jugador 1"" o
  ""Introduzca el nombre del jugador 2"".
  ** Como el juego está hardcodeado para únicamente permitir
     dos jugadores, los únicos valores que esta variable
     admite son 1 y 2.
* <<siguiente_accion>>: contiene el bloque de comandos a
  ejecutar cuando el jugador pulse el botón ""Siguiente"".
* <<caja_txt>>: contiene el campo en el cual un jugador
  debe introducir su nombre.
* <<boton_sig>>: contiene el botón para continuar con
  el juego tras introducir su nombre.
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
* <<num_jugador_titulo:>>: permite inicializar el atributo
  num_jugador_titulo, de manera que en el título de la ventana
  se pueda identificar a qué jugador se le está pidiendo que
  introduzca sus datos.
* <<siguiente_accion:>>: permite inicializar el atributo
  siguiente_accion, de manera que se pueda cargar un bloque
  de comandos a ejecutar cuando el jugador presiona el botón
  ""Siguiente"".
* <<obtenerNombreIntroducido>>: permite obtener el nombre
  introducido por un jugador para participar.
* <<siguiente_acicon>>: permite obtener el bloque de comandos
  a ejecutar luego de que un jugador presione el botón
  ""Siguiente"".
  ** Este método debe ser llamado de la siguiente forma:
     ""self siguiente_accion value"".
* <<ejecutarSiguienteAccion>>: pone en marcha la secuencia de
  acciones que se van a ejecutar cuando el jugador presione
  el botón ""Siguiente"".

================
Métodos de clase
================
La clase provee los siguientes métodos de clase:

* <<abrirConNumeroJugador:>>: reemplazo del método <<abrir>>
  provisto por la superclase ""Pantalla"", que permite recibir
  como parámetro el número de jugador al que se le van a
  solicitar datos, para luego llamar al método
  <<inicializarNumeroJugador>> durante el instanciado del
  objeto, tras lo cual se muestra esta pantalla.
"
Class {
	#name : 'PantallaInfoJugador',
	#superclass : 'Pantalla',
	#instVars : [
		'num_jugador_titulo',
		'siguiente_accion',
		'caja_txt',
		'boton_sig',
		'boton_retroceder'
	],
	#category : 'TPI-Menus',
	#package : 'TPI',
	#tag : 'Menus'
}

{ #category : 'instance creation' }
PantallaInfoJugador class >> abrir [
	"Sobreescritura del método provisto
	por la clase 'Pantalla' para avisarle
	al usuario cual es el método de clase
	correcto para instanciar objetos de
	esta clase."
	^self error: 'Para instanciar objetos de clase PantallaInfoJugador, use "abrirConNumeroJugador:conSiguienteAccion:"'.
]

{ #category : 'instance creation' }
PantallaInfoJugador class >> abrirConNumeroJugador: unNumero conSiguienteAccion: unaSiguienteAccion [
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
]

{ #category : 'layout' }
PantallaInfoJugador >> defaultLayout [
	"Método utilizado para definir el
	esquema de organización de los
	elementos en pantalla."
	self centered.
	^ SpGridLayout new
		  add: 'Nombre: ' atPoint: 1 @ 2;
		  add: #caja_txt atPoint: 2 @ 2 span: 2 @ 1;
		  add: #boton_sig atPoint: 2 @ 3 span: 1 @ 1;
		  add: #boton_retroceder atPoint: 2 @ 4 span: 1 @ 1;
		  yourself
]

{ #category : 'actions' }
PantallaInfoJugador >> ejecutarSiguienteAccion [
	"Método utilizado para definir el
	comportamiento del botón 'Siguiente'."
	| nombre_jugador instancia_juego jugador |.
	nombre_jugador := self obtenerNombreIntroducido.
	
	(nombre_jugador isEmpty) ifTrue: [
		^self error: 'Se debe introducir un nombre válido para el jugador ', num_jugador_titulo asString.
	].
	
	instancia_juego := Juego instancia_actual.
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
]

{ #category : 'initialization' }
PantallaInfoJugador >> initializePresenters [
	"Método utilizado para inicializar todos
	los elementos de la pantalla y definir
	sus comportamientos."
	|instancia_global_juego|.
	instancia_global_juego := Juego instancia_actual.
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
			PantallaSeleccionModoJuego abrir.
			"Si se vuelve al menú anterior, conviene
			resetear el estado global para no quedar
			con información que ya no sirve del
			estado anterior."
			instancia_global_juego jugador1: nil.
			instancia_global_juego jugador2: nil.
			instancia_global_juego juega_cpu: false.
		].
]

{ #category : 'initialization' }
PantallaInfoJugador >> initializeWindow: aWindowPresenter [
	"Método utilizado para establecer
	el título y tamaño de la ventana."
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Introduzca el nombre del jugador ', num_jugador_titulo asString;
		initialExtent: 420@200.
]

{ #category : 'setting' }
PantallaInfoJugador >> num_jugador_titulo: unNumero [
	"Con este método se le asigna un valor
	al atributo num_jugador_titulo, con la
	finalidad de que después, al mostrar la
	ventana de introducción de información
	del jugador, en el título se indique a
	qué jugador se le está solicitando el
	nombre."
	
	"(unNumero isInteger) ifFalse: [
		| error_msg |.
		error_msg := #(
			'El atributo num_jugador_titulo'
			'de PantallaInfoJugador debe ser'
			'un número entero.'
		) joinUsing: ' '.
		^self error: error_msg.
	].

	(unNumero <= 0 or: unNumero > 2) ifTrue: [
		^self error: 'El atributo num_jugador_titulo debe tener 1 o 2 como valor'.
	]."

	num_jugador_titulo := unNumero.
]

{ #category : 'accessing' }
PantallaInfoJugador >> obtenerNombreIntroducido [
	"Devuelve el nombre de jugador
	introducido por el usuario."
	(caja_txt text) ifNil: [
		^self error: '¡Introduzca un nombre para el jugador!'.
	].
	^caja_txt text.
]

{ #category : 'accessing' }
PantallaInfoJugador >> siguiente_accion [
	"Método utilizado para devolver
	el bloque de comandos a ejecutar
	cuando se presiona el botón
	'Siguiente', definido al instanciar
	un objeto de la clase."
	^siguiente_accion.
]

{ #category : 'setting' }
PantallaInfoJugador >> siguiente_accion: aBlock [
	"Con este método se le asigna un valor
	al atributo siguiente_accion, el cual
	debe tratarse de un bloque de comandos,
	con la finalidad de que las acciones
	definidas en el bloque se ejecuten
	cuando el jugador presione el botón
	'Siguiente'."
	siguiente_accion := aBlock
]

"
""Juego"" es la clase utilizada para representar y almacenar
el estado global del juego.

======================
Representación interna
======================
La clase está compuesta por las siguientes variables de
instancia:

* <<juega_cpu>>: debe contener un valor booleano que
  indique si el usuario va a jugar contra persona (false)
  o contra la máquina (true).
* <<jugador1>>: debe contener un objeto de clase ""Jugador""
  correspondiente al primer jugador de la partida.
* <<jugador2>>: debe contener un objeto de clase ""Jugador""
  correspondiente al segundo jugador de la partida.

Asimismo, también está compuesta por las siguientes
variables de instancia:

* <<instancia_actual>>: se debe utilizar para almacenar
  la instancia creada de ""Juego"" durante la ejecución
  del juego, a los efectos de contar con una manera de
  acceder y modificar el estado global del juego.
  ** Una explicación más profundizada del uso de esta
     variable se encuentra en la descripción del método
     homónimo más abajo, y en la documentación del
     método en su definición.

====================
Métodos de instancia
====================
La clase provee los siguientes métodos de instancia:

* <<juega_cpu>>: devuelve el valor del atributo ""juega_cpu"".
* <<juega_cpu:>>: permite establecer el valor del atributo
  ""juega_cpu"".
* <<jugador1>>: devuelve el objeto contenido en el atributo
  ""jugador1"".
* <<jugador1:>>: permite establecer el valor del atributo
  ""jugador1"".
* <<jugador2>>: devuelve el objeto contenido en el atributo
  ""jugador2"".
* <<jugador2:>>: permite establecer el valor del atributo
  ""jugador2"".

================
Métodos de clase
================
La clase provee los siguientes métodos de clase:

* <<ejecutar>>: utilizado para ejecutar el juego.
* <<instancia_actual>>: utilizado para acceder al atributo
  de clase que contiene la instancia en ejecución del juego.
  Si no existe instancia alguna, se la crea y se la devuelve.
  Este método solo debe ser utilizado por el método <<abrir>>.
  Se aplica el patrón de diseño Singleton. Más información en
  los comentarios del método.
"
Class {
	#name : 'Juego',
	#superclass : 'Object',
	#instVars : [
		'juega_cpu',
		'jugador1',
		'jugador2'
	],
	#classInstVars : [
		'instancia_actual'
	],
	#category : 'TPI-Elementos',
	#package : 'TPI',
	#tag : 'Elementos'
}

{ #category : 'instance creation' }
Juego class >> ejecutar [
	"
	Método utilizado para abrir
	la pantalla inicial del juego.
	
	Para almacenar el estado global
	del juego se aplica el principio
	Singleton a través del método
	'instancia_actual'. Una
	descripción más detalladas se
	encuentra en la definición de
	dicho método.
	"
	self instancia_actual.
	^PantallaInicial abrir.
]

{ #category : 'instance creation' }
Juego class >> instancia_actual [
	"
	instancia_actual es un método que se
	utiliza para aplicar el patrón de
	diseño Singleton: la idea es que esta
	clase (Juego) se pueda utilizar para
	mantener un control del estado global
	del juego, por lo que solo debe existir
	como máximo una instancia de esta clase
	en cualquier momento dado.
	
	Este método actúa como un getter que
	permite acceder al atributo de clase
	homónimo, y que si este no tiene un
	objeto almacenado, lo crea.
	
	En el atributo de clase homónimo se
	almacena un objeto de esta clase, el
	cual se utiliza durante la ejecución
	del juego para acceder a datos globales
	y relevantes del juego, como los objetos
	que representan a los jugadores que
	participan del juego.
	
	Al almacenar el objeto en un atributo
	de clase, nos aseguramos de que el
	recolector de basura de Smalltalk no
	lo borre en ningún momento, y que por
	lo tanto la información que necesitamos
	almacenar en los atributos de instancia
	del objeto almacenado sea accesible en
	cualquier momento.
	
	Más información: https://es.wikipedia.org/wiki/Singleton.
	"
	instancia_actual ifNil: [
		instancia_actual := self new.
	].
	^instancia_actual.
]

{ #category : 'private' }
Juego >> chequearTipoValorJugador: unValor [
	"Método utilizado para controlar que
	los valores que se le quieran asignar
	a los atributos jugador1 y jugador2
	sean del tipo de dato correcto."
	| error_msg |
	(unValor isNil or: (unValor isKindOf: Jugador)) ifTrue: [ ^self ].
	error_msg := #(
		'Los atributos jugador1 y jugador2'
		'de la clase "Juego" solo pueden'
		'tener nil o un objeto de tipo'
		'"Jugador" como valor.'
	) joinUsing: ' '.
	^self error: error_msg.
]

{ #category : 'initialization' }
Juego >> initialize [
	"
	Inicialización de una instancia de
	la clase con valores por defecto
	lógicos.
	
	jugador1 y jugador2 ya son
	inicializados con nil, así que no
	hace falta realizar eso acá.
	"
	super initialize.
	juega_cpu := false.
]

{ #category : 'accessing' }
Juego >> juega_cpu [
	"Método para obtener el valor
	del atributo 'juega_cpu'."
	^juega_cpu.
]

{ #category : 'setting' }
Juego >> juega_cpu: aBoolean [
	"Método para asignarle un valor
	al atributo 'juega_cpu'."
	juega_cpu := aBoolean.
]

{ #category : 'accessing' }
Juego >> jugador1 [
	"Método para obtener el valor
	del atributo 'jugador1'."
	^jugador1.
]

{ #category : 'setting' }
Juego >> jugador1: unJugador [
	"Método para asignarle un valor
	al atributo 'jugador1'."
	self chequearTipoValorJugador: unJugador.
	jugador1 := unJugador.
]

{ #category : 'accessing' }
Juego >> jugador2 [
	"Método para obtener el valor
	del atributo 'jugador2'."
	^jugador2.
]

{ #category : 'setting' }
Juego >> jugador2: unJugador [
	"Método para asignarle un valor
	al atributo 'jugador2'."
	self chequearTipoValorJugador: unJugador.
	jugador2 := unJugador.
]

"
""Jugador"" es la clase utilizada para representar a los
jugadores que participan del juego y almacenar su
información.

======================
Representación interna
======================
La clase está compuesta por las siguientes variables de
instancia:

* <<nombre>>: contiene el nombre de un jugador.

====================
Métodos de instancia
====================
La clase provee los siguientes métodos de instancia:

* <<inicializarConNombre:>>: permite inicializar un
  objeto de esta clase, utilizando un nombre de
  jugador recibido por parámetro.
* <<nombre>>: permite obtener el nombre de un jugador.

================
Métodos de clase
================
La clase provee los siguientes métodos de clase:

* <<nuevoConNombre:>>: permite instanciar rápidamente
  un objeto de esta clase, utilizando un nombre de
  jugador recibido por parámetro.
"
Class {
	#name : 'Jugador',
	#superclass : 'Object',
	#instVars : [
		'nombre'
	],
	#category : 'TPI-Elementos',
	#package : 'TPI',
	#tag : 'Elementos'
}

{ #category : 'instance creation' }
Jugador class >> nuevoConNombre: aName [
	"Método para instanciar rápidamente un
	objeto de esta clase."
	^self new
		inicializarConNombre: aName.
]

{ #category : 'instance creation' }
Jugador >> inicializarConNombre: aName [
	"Método para inicializar una
	instancia de Jugador con un
	nombre pasado por parámetro."
	| jugador |.
	jugador := self class new.
	nombre := aName.
	^jugador.
]

{ #category : 'accessing' }
Jugador >> nombre [
	"Método para obtener el nombre
	de un jugador."
	^nombre.
]

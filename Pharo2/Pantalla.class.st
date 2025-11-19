"
Class: Pantalla
                                                                                                    
""Pantalla"" es una clase utilizada para proveer
métodos comunes a todas las pantallas/menús del
juego.

================
Métodos de clase
================
La clase provee los siguientes métodos de clase:

* <<abrir>>: utilizado para abrir pantallas del
  juego con parámetros en común. Algunas clases
  de menús pueden llegar a redefinir este método
  según lo vean necesario.
"
Class {
	#name : 'Pantalla',
	#superclass : 'SpPresenter',
	#category : 'TPI-Menus',
	#package : 'TPI',
	#tag : 'Menus'
}

{ #category : 'instance creation' }
Pantalla class >> abrir [
	"Método genérico para abrir una
	pantalla sin decoraciones, como
	los botones para minimizar o el
	menú de opciones de la punta
	superior izquierda."
	| pantalla |.
	pantalla := self new open.
	pantalla window
		removeCollapseBox;
		removeExpandBox;
		removeMenuBox;
		removeCloseBox;
		beUnresizeable.
	
	^pantalla.
]

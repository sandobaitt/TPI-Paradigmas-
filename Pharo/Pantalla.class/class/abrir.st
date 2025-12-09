instance creation
abrir
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
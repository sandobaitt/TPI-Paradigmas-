instance creation
abrir
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
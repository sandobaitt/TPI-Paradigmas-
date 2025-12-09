instance creation
ejecutar
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
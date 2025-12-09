initialization
initializeWindow: aWindowPresenter
	"Método utilizado para establecer
	el título y tamaño de la ventana."
	|nombre_jugador|.
	nombre_jugador := jugador_a_posicionar nombre.
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: nombre_jugador asString, ': introduzca una posición en la que empezar';
		initialExtent: 470@150.
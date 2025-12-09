initialization
initializeWindow: aWindowPresenter
	"Método utilizado para establecer
	el título y tamaño de la ventana."
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Introduzca el nombre del jugador ', num_jugador_titulo asString;
		initialExtent: 420@200.
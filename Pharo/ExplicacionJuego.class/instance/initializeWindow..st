initialization
initializeWindow: aWindowPresenter
	"Método utilizado para establecer
	el título y tamaño de la ventana."
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Explicación de reglas y funcionamiento';
		initialExtent: 500@465
initialization
initializeWindow: aWindowPresenter
	"
	Método utilizado para establecer
	el título y tamaño de la ventana.
	
	Acá, el parámetro aWindowPresenter
	es como el parámetro aStream que
	se le pasa a printOn, siendo implícito.
	Es la ventana que resulta de hacer
	'PantallaInicial new open', de clase
	'SpWindowPresenter'.
	"
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Menú inicial del Sistema Dinámico Repulsor';
		initialExtent: 420@260.
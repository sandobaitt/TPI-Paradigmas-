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
	|nombreGanador|
	nombreGanador:= JuegoEnEjecucion instancia_actual ganador nombre.
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: '¡Fin del juego! El ganador es ', nombreGanador asString;
		initialExtent: 520@200.
layout
defaultLayout
	"Método utilizado para definir el
	esquema de organización de los
	elementos en pantalla."
	self centered.
	^SpBoxLayout newTopToBottom
		add: boton_iniciar;
		add: boton_explicacion;
		add: boton_salir;
		spacing: 10;
		yourself.
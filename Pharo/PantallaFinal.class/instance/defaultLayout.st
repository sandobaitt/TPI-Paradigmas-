layout
defaultLayout
	"Método utilizado para definir el
	esquema de organización de los
	elementos en pantalla."
	self centered.
	^SpBoxLayout newTopToBottom
		add: boton_volver;
		yourself.
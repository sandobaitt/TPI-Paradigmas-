layout
defaultLayout
	"Método utilizado para definir el
	esquema de organización de los
	elementos en pantalla."
	self centered.
	^ SpGridLayout new
		  add: 'Nombre: ' atPoint: 1 @ 2;
		  add: #caja_txt atPoint: 2 @ 2 span: 2 @ 1;
		  add: #boton_sig atPoint: 2 @ 3 span: 1 @ 1;
		  add: #boton_retroceder atPoint: 2 @ 4 span: 1 @ 1;
		  yourself
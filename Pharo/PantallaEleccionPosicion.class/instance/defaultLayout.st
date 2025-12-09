layout
defaultLayout
	"Método utilizado para definir el
	esquema de organización de los
	elementos en pantalla."
	self centered.
	^ SpGridLayout new
		  add: 'Fila: ' atPoint: 1 @ 2;
		  add: #caja_pos_x atPoint: 2 @ 2 span: 2 @ 1;
		  add: 'Columna: ' atPoint: 1 @ 3;
		  add: #caja_pos_y atPoint: 2 @ 3 span: 2 @ 1;
		  add: #boton_sig atPoint: 2 @ 4 span: 1 @ 1;
		  yourself
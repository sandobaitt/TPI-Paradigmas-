layout
defaultLayout
    | filaSuperior filaInferior |

    "Fila de arriba: tablero + tabla de jugadores"
    filaSuperior := SpBoxLayout newHorizontal.
    filaSuperior
        add: tableroMorphPresenter
            withConstraints: [ :c |
                c expand: true.
                c fill: true.
                c padding: 10 ];
        add: tablaJugadores
            withConstraints: [ :c |
                c width: 180.
                c padding: 10 ].

    "Fila de abajo: los dos botones"
    filaInferior := SpBoxLayout newHorizontal.
    filaInferior
        add: botonPaso
            withConstraints: [ :c |
                c padding: 10.
                c expand: false ];
        add: botonFinal
            withConstraints: [ :c |
                c padding: 10.
                c expand: false ].

	 self centered.
    ^ SpBoxLayout newVertical
        add: filaSuperior
            withConstraints: [ :c |
                c expand: true.
                c fill: true ];
        add: filaInferior
            withConstraints: [ :c |
                c height: 70 ]



actions
actualizarTablero
    "Sincroniza el TableroMorph con el modelo Juego/Tablero y lo redibuja."
	| morph |

    tableroMorphPresenter isNil ifTrue: [ ^ self ].

    morph := tableroMorphPresenter morph.
    morph isNil ifTrue: [ ^ self ].

    juego notNil ifTrue: [
        morph juego: juego.
        morph tablero: juego tablero
    ].

    morph changed.   "forzamos que se redibuje"

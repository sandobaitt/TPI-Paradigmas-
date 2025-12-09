actions
configurarTableroMorph
    | morph |
    morph := TableroMorph new.

    juego notNil ifTrue: [
        morph juego: juego.
        juego tablero notNil ifTrue: [
            morph tablero: juego tablero ] ].

    tableroMorphPresenter morph: morph.

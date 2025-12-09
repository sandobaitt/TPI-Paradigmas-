actions
configurarTablaJugadores
    tablaJugadores
        addColumn: (SpStringTableColumn
            title: 'Jugador'
            evaluated: [ :jugador | jugador nombre ]);
        addColumn: (SpStringTableColumn
            title: 'Vidas'
            evaluated: [ :jugador | 
                (jugador respondsTo: #vidas)
                    ifTrue: [ 'x', jugador vidas asString ]
                    ifFalse: [ 'x?' ] ]).
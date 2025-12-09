initialization
initializePresenters
    "Inicializa todos los presenters de Spec."
    super initializePresenters.

    tableroMorphPresenter := self newMorph.
    tablaJugadores := self newTable.
    botonPaso := self newButton.
    botonFinal := self newButton.

    self configurarTableroMorph.
    self configurarTablaJugadores.

    botonPaso
        label: 'Avanzar 1 paso';
        action: [ self avanzarUnPaso ].

    botonFinal
        label: 'Avanzar todo';
        action: [ self avanzarTodo ].

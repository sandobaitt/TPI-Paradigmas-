actions
determinarGanadorEntre: unJugador1 y: unJugador2 numero1: unNumero1 numero2: unNumero2 secreto: unSecreto

	| diferencia1 diferencia2 numAlAzar |
	diferencia1 := (unSecreto - unNumero1) abs.
	diferencia2 := (unSecreto - unNumero2) abs.
	diferencia1 < diferencia2 ifTrue: [ ^ unJugador1 ].
	diferencia2 < diferencia1 ifTrue: [ ^ unJugador2 ].
	diferencia1 = diferencia2 ifFalse: [ ^ self ].
	numAlAzar := (1 to: 2) atRandom.
	numAlAzar = 1 ifFalse: [ ^ unJugador2 ].
	^unJugador1.
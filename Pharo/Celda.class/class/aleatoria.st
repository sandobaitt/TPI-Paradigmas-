as yet unclassified
aleatoria
    | direcciones dir esEsp |
    direcciones := #(#arriba #abajo #izquierda #derecha).
    dir := direcciones atRandom.

    "10% de probabilidad de ser especial"
    esEsp := ((1 to: 10) atRandom = 1).

    ^ self
        direccion: dir
        especial: esEsp
        vidasExtra: (esEsp ifTrue: [ 1 ] ifFalse: [ 0 ])
drawing
textoParaDireccion: unaDireccion
    | d |
    unaDireccion isNil ifTrue: [ ^ '' ].

    d := unaDireccion asString asLowercase.

    (d beginsWith: 'arriba')  ifTrue: [ ^ '↑' ].
    (d beginsWith: 'abajo')   ifTrue: [ ^ '↓' ].
    (d beginsWith: 'izqu')    ifTrue: [ ^ '←' ].
    (d beginsWith: 'derec')   ifTrue: [ ^ '→' ].

    "Si no reconocemos la palabra, mostramos el texto original"
    ^ unaDireccion asString.

drawing
dibujarJugadoresSobre: aCanvas
    cellWidth: cellWidth
    cellHeight: cellHeight
    originX: originX
    originY: originY

    | jugadores |
    juego isNil ifTrue: [ ^ self ].
    tablero isNil ifTrue: [ ^ self ].

    "Armamos colección de jugadores con su nombre y color"
    jugadores := OrderedCollection new.
    juego jugador1 ifNotNil: [
        jugadores add: { juego jugador1. juego jugador1 nombre. Color blue } ].
    juego jugador2 ifNotNil: [
        jugadores add: { juego jugador2. juego jugador2 nombre. Color red } ].

    jugadores do: [:triple |
        | jugador etiqueta color pos fila col centerX centerY radio circleRect
          font textWidth textHeight textX textY |

        jugador := triple first.
        etiqueta := triple second.
        color := triple third.

        pos := jugador posicion.
        pos isNil ifTrue: [ ^ self ].

        "Ojo: x = columna, y = fila"
        col := pos x.
        fila := pos y.

        "Si está fuera del tablero, lo ignoramos"
        ((fila between: 1 and: tablero filas)
            and: [ col between: 1 and: tablero columnas ]) ifFalse: [ ^ self ].

        "Centro de la celda en píxeles"
        centerX := originX + ((col - 0.5) * cellWidth).
        centerY := originY + ((fila - 0.5) * cellHeight).

        radio := (cellWidth min: cellHeight) * 0.35.

        circleRect := (centerX - radio) @ (centerY - radio)
                        extent: (radio * 2) @ (radio * 2).

        "Círculo del jugador"
        aCanvas fillOval: circleRect color: color.

        "Nombre del jugador CENTRADO en el círculo"
        font := StandardFonts defaultFont.
        textWidth := font widthOfString: etiqueta.
        textHeight := font height.

        "IMPORTANTE: usar enteros (//) para que no falle el primitivo"
        textX := circleRect center x - (textWidth // 2).
        textY := circleRect center y - (textHeight // 2).

        aCanvas
            drawString: etiqueta
            at: textX @ textY
            font: font
            color: Color white.
    ].

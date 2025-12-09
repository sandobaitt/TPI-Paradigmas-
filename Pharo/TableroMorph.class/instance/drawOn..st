drawing
drawOn: aCanvas
    | filas columnas area cellWidth cellHeight originX originY |

    super drawOn: aCanvas.

    "Si no tenemos tablero, no dibujamos nada"
    tablero isNil ifTrue: [ ^ self ].

    filas := tablero filas.
    columnas := tablero columnas.

    "Zona donde se dibuja el tablero dentro del morph"
    area := self bounds insetBy: 20.
    cellWidth := area width / columnas.
    cellHeight := area height / filas.
    originX := area left.
    originY := area top.

    1 to: filas do: [:fila |
        1 to: columnas do: [:col |
            | x y rect celda texto colorCelda |

            x := originX + ((col - 1) * cellWidth).
            y := originY + ((fila - 1) * cellHeight).
            rect := (x @ y extent: cellWidth @ cellHeight).

            celda := tablero celdaEnFila: fila columna: col.

            colorCelda := (celda esEspecial
                ifTrue: [ Color lightGreen ]
                ifFalse: [ Color veryLightGray ]).

            aCanvas fillRectangle: rect color: colorCelda.
            aCanvas frameRectangle: rect width: 1 color: Color black.

            "Dibujamos el texto de la dirección (arriba/abajo/etc.)"
            texto := self textoParaDireccion: celda direccion.
            aCanvas
                drawString: texto
                in: rect
                font: TextStyle defaultFont
                color: Color black.
        ]].

"Después de dibujar las celdas, dibujamos los jugadores"
	self dibujarJugadoresSobre: aCanvas
   		cellWidth: cellWidth
    	cellHeight: cellHeight
    	originX: originX
    	originY: originY.


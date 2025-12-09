accessing
generarCeldasAleatorias
    | fila |
    celdas := Array new: filas.
    1 to: filas do: [ :i |
        fila := Array new: columnas.
        1 to: columnas do: [ :j |
            fila at: j put: Celda aleatoria ].
        celdas at: i put: fila ].
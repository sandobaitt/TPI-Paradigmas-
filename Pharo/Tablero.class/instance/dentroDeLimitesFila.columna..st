accessing
dentroDeLimitesFila: fila columna: col
    ^ fila >= 1
        and: [ fila <= filas
        and: [ col >= 1
        and: [ col <= columnas ] ] ]
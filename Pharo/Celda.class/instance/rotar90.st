accessing
rotar90
    "Cambia la dirección 90° en sentido horario."
    direccion := direccion
        caseOf: {
            [ #arriba ]    -> [ #derecha ].
            [ #derecha ]   -> [ #abajo ].
            [ #abajo ]     -> [ #izquierda ].
            [ #izquierda ] -> [ #arriba ] }
        otherwise: [ direccion ].
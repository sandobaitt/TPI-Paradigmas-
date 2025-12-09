instance creation
nuevoConNombre: aName
    "Constructor cómodo: crea un jugador con el nombre dado."
    ^ self new
        nombre: aName;
        yourself
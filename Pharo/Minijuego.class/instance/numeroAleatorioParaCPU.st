actions
numeroAleatorioParaCPU
    "Devuelve un número aleatorio para la CPU.
     Ajustá el rango según lo que ya uses en tu minijuego."

    ^ (Random new nextInteger: 100) + 1
    "Por ejemplo 1..100"

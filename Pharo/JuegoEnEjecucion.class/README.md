"Juego" es la clase utilizada para representar y almacenar
el estado global del juego.

======================
Representación interna
======================
La clase está compuesta por las siguientes variables de
instancia:

* <<juega_cpu>>: debe contener un valor booleano que
  indique si el usuario va a jugar contra persona (false)
  o contra la máquina (true).
* <<jugador1>>: debe contener un objeto de clase "Jugador"
  correspondiente al primer jugador de la partida.
* <<jugador2>>: debe contener un objeto de clase "Jugador"
  correspondiente al segundo jugador de la partida.

Asimismo, también está compuesta por las siguientes
variables de instancia:

* <<instancia_actual>>: se debe utilizar para almacenar
  la instancia creada de "Juego" durante la ejecución
  del juego, a los efectos de contar con una manera de
  acceder y modificar el estado global del juego.
  ** Una explicación más profundizada del uso de esta
     variable se encuentra en la descripción del método
     homónimo más abajo, y en la documentación del
     método en su definición.

====================
Métodos de instancia
====================
La clase provee los siguientes métodos de instancia:

* <<juega_cpu>>: devuelve el valor del atributo "juega_cpu".
* <<juega_cpu:>>: permite establecer el valor del atributo
  "juega_cpu".
* <<jugador1>>: devuelve el objeto contenido en el atributo
  "jugador1".
* <<jugador1:>>: permite establecer el valor del atributo
  "jugador1".
* <<jugador2>>: devuelve el objeto contenido en el atributo
  "jugador2".
* <<jugador2:>>: permite establecer el valor del atributo
  "jugador2".

================
Métodos de clase
================
La clase provee los siguientes métodos de clase:

* <<ejecutar>>: utilizado para ejecutar el juego.
* <<instancia_actual>>: utilizado para acceder al atributo
  de clase que contiene la instancia en ejecución del juego.
  Si no existe instancia alguna, se la crea y se la devuelve.
  Este método solo debe ser utilizado por el método <<abrir>>.
  Se aplica el patrón de diseño Singleton. Más información en
  los comentarios del método.
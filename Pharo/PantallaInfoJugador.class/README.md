"PantallaInfoJugador" es la clase que permite inicializar
y mostrar la pantalla para solicitar el nombre de un jugador.
Esta pantalla permite introducir un nombre de jugador, o bien,
regresar al menú de selección de modo, para lo cual provee
dos botones.

Para proveer las funcionalidades de los botones, esta clase
depende de las siguientes clases:

* "Jugador".
* "PantallaSeleccionModoJuego".

======================
Representación interna
======================
La clase está compuesta por las siguientes variables de
instancia:

* <<num_jugador_titulo>>: contiene el número correspondiente
  al jugador al cual se le está pidiendo que introduzca su
  nombre. Se usa para personalizar el título de la ventana,
  de manera que diga "Introduzca el nombre del jugador 1" o
  "Introduzca el nombre del jugador 2".
  ** Como el juego está hardcodeado para únicamente permitir
     dos jugadores, los únicos valores que esta variable
     admite son 1 y 2.
* <<siguiente_accion>>: contiene el bloque de comandos a
  ejecutar cuando el jugador pulse el botón "Siguiente".
* <<caja_txt>>: contiene el campo en el cual un jugador
  debe introducir su nombre.
* <<boton_sig>>: contiene el botón para continuar con
  el juego tras introducir su nombre.
* <<boton_retroceder>>: contiene el botón para volver
  al menú anterior.

====================
Métodos de instancia
====================
La clase provee los siguientes métodos de instancia:

* <<initializePresenters>>: permite inicializar los elementos
  de la clase y definir el comportamiento que tendrán.
* <<initializeWindow:>>: permite establecer las propiedades de
  la pantalla.
* <<defaultLayout>>: permite especificar la estética que tendrá
  la pantalla.
* <<num_jugador_titulo:>>: permite inicializar el atributo
  num_jugador_titulo, de manera que en el título de la ventana
  se pueda identificar a qué jugador se le está pidiendo que
  introduzca sus datos.
* <<siguiente_accion:>>: permite inicializar el atributo
  siguiente_accion, de manera que se pueda cargar un bloque
  de comandos a ejecutar cuando el jugador presiona el botón
  "Siguiente".
* <<obtenerNombreIntroducido>>: permite obtener el nombre
  introducido por un jugador para participar.
* <<siguiente_acicon>>: permite obtener el bloque de comandos
  a ejecutar luego de que un jugador presione el botón
  "Siguiente".
  ** Este método debe ser llamado de la siguiente forma:
     "self siguiente_accion value".
* <<ejecutarSiguienteAccion>>: pone en marcha la secuencia de
  acciones que se van a ejecutar cuando el jugador presione
  el botón "Siguiente".

================
Métodos de clase
================
La clase provee los siguientes métodos de clase:

* <<abrirConNumeroJugador:>>: reemplazo del método <<abrir>>
  provisto por la superclase "Pantalla", que permite recibir
  como parámetro el número de jugador al que se le van a
  solicitar datos, para luego llamar al método
  <<inicializarNumeroJugador>> durante el instanciado del
  objeto, tras lo cual se muestra esta pantalla.
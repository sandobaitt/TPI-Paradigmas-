# 🏹 Sistema Dinámico Repulsor

Este proyecto implementa una versión ampliada y mejorada del **Sistema Dinámico Repulsor**, desarrollado para el TPI de la materia **Paradigmas de Programación**. 

El sistema consiste en un tablero cuadriculado donde cada casilla tiene una flecha con una dirección previamente asignada. Dos jugadores compiten haciendo un recorrido por el tablero siguiendo las direcciones de las flechas, gestionando sus vidas y aprovechando eventos aleatorios.

## 🎮 Reglas del Juego

1. **Vidas Iniciales:** Cada jugador comienza la partida con 3 vidas.
2. **Inicio:** Mediante un minijuego, se define qué jugador elige el tamaño del tablero (8x8 o 10x10) y qué jugador selecciona primero su casilla de inicio.
3. **Movimiento:** En cada turno manual, el jugador avanza hacia la casilla contigua obedeciendo estrictamente la dirección de la flecha actual.
4. **Rotación:** Al abandonar una casilla, la flecha de origen rota **90 grados en sentido de las agujas del reloj**, modificando el tablero dinámicamente.
5. **Condición de Daño/Derrota:** Si un movimiento expulsa al jugador fuera de los límites físicos del tablero, este pierde una vida. El jugador es eliminado de la partida cuando sus vidas llegan a cero.
6. **Victoria:** El ganador es el último jugador que logra mantenerse con vida dentro del tablero.

## 🚀 Características Agregadas (Nuestra Versión)
Para evitar que la dinámica sea previsible desde el inicio, incorporamos las siguientes mecánicas:
* **Minijuegos de Decisión:** Eventos de adivinanza numérica contra la máquina para establecer ventajas iniciales (elección de tablero y turnos).
* **Sistema de Vidas y Daño:** Reemplazamos la "muerte súbita" por un sistema de 3 vidas, permitiendo mayor competitividad.
* **Celdas Especiales (Power-Ups):** Casillas aleatorias de color verde que otorgan una vida extra al jugador que aterrice sobre ellas, las cuales se desactivan tras su uso.
* **Interfaz Gráfica (GUI):** Menús interactivos, ventanas de configuración y un tablero visual dinámico.

---

## 🛠️ Tecnologías y Versiones
El escenario ha sido modelado siguiendo el **Paradigma Orientado a Objetos** y codificado en dos lenguajes:

### 🧊 Smalltalk (Pharo)
La versión principal y totalmente funcional desarrollada en el entorno Pharo. 

**Cómo importar y probar el juego:**

Para jugar, necesitas tener instalado Pharo (recomendado Pharo 13) y seguir estos pasos para cargar el código fuente en tu entorno:

**1. Clonar el repositorio en Iceberg:**
* Abrí Pharo y dirigite a **Iceberg** (desde el World Menu o presionando `Ctrl + O` y luego `I`).
* Hacé clic en el botón **Add** (arriba a la izquierda) y seleccioná **Clone from github.com**.
* Ingresá el dueño y el nombre del repositorio (en este caso `sandobaitt/TPI-Paradigmas-`), o pegá la URL HTTPS del repositorio.
* Presioná **OK**.

**2. Cargar el paquete en la imagen:**
* En la lista de Iceberg, hacé doble clic sobre el repositorio recién clonado.
* Dirigite a la pestaña **Packages**.
* Vas a ver el paquete del juego con el estado *Not loaded*. Hacé clic derecho sobre él y seleccioná **Load**. 
* El estado cambiará a *Loaded*, lo que significa que el código ya está en tu sistema.

**3. Ejecutar el juego:**
* Abrí un **Playground** (presionando `Ctrl + O` y luego `W`).
* Escribí el siguiente comando para abrir el menú principal:
  ```smalltalk
  PantallaInicial new openWithSpec.

### 🐍 Python
Prototipo inicial construido para evaluar la lógica central del funcionamiento, direcciones y rotación antes de migrar al entorno definitivo.
* **Ubicación:** `/Python`
* **Cómo ejecutar:** `SDR Python.py`

---

## 📂 Documentación
El análisis detallado del modelo de clases (MVC), el uso del patrón Singleton, las reflexiones sobre el trabajo grupal y el diagrama UML completo se encuentran en el informe técnico (Paper) adjunto en este repositorio.

---

## 👥 Integrantes del Equipo
* **Juan Alejo Acosta**
* **Lucas Ivan Benchat Parra**
* **Ambar Noara Mártinez**
* **Lautaro Emanuel Sandoval**
* **Raúl Vicente Agustín Verón**
* **Lucas Maximiliano Zurano Lang**

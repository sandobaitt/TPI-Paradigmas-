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
La versión principal y definitiva. Cuenta con una interfaz visual robusta construida sobre el framework Spec.

**Cómo importar y probar el juego en Pharo:**
> *(Espacio reservado: Explicar aquí paso a paso cómo cargar el archivo .st o conectar con Iceberg y qué comando ejecutar en el Playground para abrir el menú principal).*

### 🐍 Python
Prototipo inicial construido para evaluar la lógica central del funcionamiento, direcciones y rotación antes de migrar al entorno definitivo.
* **Ubicación:** `/Python`
* **Cómo ejecutar:** `python main.py`

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

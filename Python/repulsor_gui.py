# repulsor_gui_final_v2.py
# SISTEMA DINÁMICO REPULSOR - Versión final (ajustes adicionales)
# Autor: Implementación para Alejo
# Requisitos: Python 3 (tkinter incluido)

import random
import tkinter as tk
from tkinter import messagebox

# -------------------------------
# Lógica del juego (POO)
# -------------------------------
class Casilla:
    SIMBOLOS = ['^', '>', 'v', '<']  # 0=arriba,1=derecha,2=abajo,3=izquierda

    def __init__(self, direccion=None):
        self.direccion = direccion if direccion is not None else random.randint(0, 3)

    def rotar(self):
        self.direccion = (self.direccion + 1) % 4

    def obtener_simbolo(self):
        return Casilla.SIMBOLOS[self.direccion]

class Tablero:
    DELTAS = [(-1, 0), (0, 1), (1, 0), (0, -1)]  # ↑ → ↓ ←

    def __init__(self, filas, columnas):
        self.filas = filas
        self.columnas = columnas
        self.casillas = [[Casilla() for _ in range(columnas)] for _ in range(filas)]

    def mover_desde(self, pos):
        """
        Rota la casilla en pos y devuelve (nueva_pos, pos_rotada).
        Si el movimiento sale del tablero, devuelve (None, pos_rotada).
        """
        i, j = pos
        casilla = self.casillas[i][j]
        di, dj = Tablero.DELTAS[casilla.direccion]
        casilla.rotar()
        nueva = (i + di, j + dj)
        if not self.dentro_de_limites(nueva):
            return None, (i, j)
        return nueva, (i, j)

    def dentro_de_limites(self, pos):
        i, j = pos
        return 0 <= i < self.filas and 0 <= j < self.columnas

class Jugador:
    def __init__(self, nombre):
        self.nombre = nombre
        self.posicion = None
        self.pasos = 0
        self.visitadas = set()  # casillas por las que pasó (para color permanente)

    def mover(self, tablero):
        nueva_pos, pos_rotada = tablero.mover_desde(self.posicion)
        # marcar la casilla rotada como visitada (aunque salga)
        self.visitadas.add(pos_rotada)
        if nueva_pos is None:
            return False, pos_rotada
        self.posicion = nueva_pos
        self.pasos += 1
        return True, pos_rotada

# -------------------------------
# Utilidades GUI
# -------------------------------
def centrar_ventana(ventana, ancho, alto):
    ventana.update_idletasks()
    pantalla_ancho = ventana.winfo_screenwidth()
    pantalla_alto = ventana.winfo_screenheight()
    x = int((pantalla_ancho / 2) - (ancho / 2))
    y = int((pantalla_alto / 2) - (alto / 2))
    ventana.geometry(f"{ancho}x{alto}+{x}+{y}")

def destruir_y_abrir(prev_window, new_window_creator):
    """Destruye la ventana anterior (si existe) y crea la nueva ventana usando new_window_creator()."""
    if prev_window is not None:
        try:
            prev_window.destroy()
        except:
            pass
    return new_window_creator()

# Colores
COLOR_J1 = "#FFA500"  # naranja
COLOR_J2 = "#87CEFA"  # azul claro
CELL_BG_DEFAULT = "white"

# -------------------------------
# Ventanas separadas
# -------------------------------
class MenuWindow:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("Repulsor - Menú")
        centrar_ventana(self.root, 420, 260)

        lbl = tk.Label(self.root, text="SISTEMA DINÁMICO REPULSOR", font=("Arial", 14, "bold"))
        lbl.pack(pady=12)

        btn_inicio = tk.Button(self.root, text="Iniciar juego", width=22, command=self.abrir_nombre1)
        btn_explic = tk.Button(self.root, text="Ver explicación", width=22, command=self.abrir_explicacion)
        btn_cerrar = tk.Button(self.root, text="Cerrar aplicación", width=22, command=self.root.destroy)

        btn_inicio.pack(pady=6)
        btn_explic.pack(pady=6)
        btn_cerrar.pack(pady=6)

        self.root.mainloop()

    def abrir_explicacion(self):
        destruir_y_abrir(self.root, ExplanationWindow)

    def abrir_nombre1(self):
        destruir_y_abrir(self.root, NameWindow1)

class ExplanationWindow:
    def __init__(self):
        self.win = tk.Tk()
        self.win.title("Explicación - Repulsor")
        centrar_ventana(self.win, 640, 420)

        txt = (
            "Reglas del Sistema Dinámico Repulsor:\n\n"
            "- Tablero con flechas en cada casilla (↑, →, ↓, ←).\n"
            "- Mini-juego 1: cada jugador elige un número (1-100). El más cercano al numero_secreto decide el tamaño del tablero (8×8 ó 10×10).\n"
            "- Mini-juego 2: otro número (1-100) decide quién empieza.\n"
            "- El que comienza elige primero su casilla inicial (fila, columna); el otro elige después. No pueden elegir la misma casilla.\n"
            "- Cada turno, el jugador avanza siguiendo la flecha de su casilla.\n"
            "- Al abandonar una casilla, la flecha en ella rota 90° en sentido horario y la casilla se colorea permanentemente con el color del jugador que la usó.\n"
            "- Jugador 1: color naranja; Jugador 2: color azul.\n"
            "- Al ganar un mini-juego, presioná ENTER para continuar a la siguiente etapa.\n"
            "- Al terminar la partida, podés elegir volver al menú o cerrar la aplicación.\n"
        )
        lbl = tk.Label(self.win, text=txt, justify="left", padx=12, pady=12)
        lbl.pack(fill="both", expand=True)

        btn_volver = tk.Button(self.win, text="Volver al menú", command=lambda: destruir_y_abrir(self.win, MenuWindow))
        btn_volver.pack(pady=10)

        self.win.mainloop()

class NameWindow1:
    def __init__(self):
        self.win = tk.Tk()
        self.win.title("Jugador 1 - Ingresar nombre")
        centrar_ventana(self.win, 420, 180)

        tk.Label(self.win, text="Ingrese el nombre del Jugador 1:", font=("Arial", 11)).pack(pady=8)
        self.entry = tk.Entry(self.win)
        self.entry.pack(pady=6)

        btn = tk.Button(self.win, text="Siguiente", command=self.siguiente)
        btn.pack(pady=8)

        btn_volver = tk.Button(self.win, text="Cancelar y volver al menú", command=lambda: destruir_y_abrir(self.win, MenuWindow))
        btn_volver.pack(pady=6)

        self.entry.bind("<Return>", lambda event: self.siguiente())

        self.win.mainloop()

    def siguiente(self):
        nombre = self.entry.get().strip()
        if not nombre:
            messagebox.showwarning("Error", "Ingrese un nombre válido.")
            return
        destruir_y_abrir(self.win, lambda: NameWindow2(nombre))

class NameWindow2:
    def __init__(self, nombre1):
        self.nombre1 = nombre1
        self.win = tk.Tk()
        self.win.title("Jugador 2 - Ingresar nombre")
        centrar_ventana(self.win, 420, 180)

        tk.Label(self.win, text="Ingrese el nombre del Jugador 2:", font=("Arial", 11)).pack(pady=8)
        self.entry = tk.Entry(self.win)
        self.entry.pack(pady=6)

        btn = tk.Button(self.win, text="Siguiente", command=self.siguiente)
        btn.pack(pady=8)

        btn_volver = tk.Button(self.win, text="Volver atrás", command=lambda: destruir_y_abrir(self.win, NameWindow1))
        btn_volver.pack(pady=6)

        self.entry.bind("<Return>", lambda event: self.siguiente())

        self.win.mainloop()

    def siguiente(self):
        nombre2 = self.entry.get().strip()
        if not nombre2:
            messagebox.showwarning("Error", "Ingrese un nombre válido.")
            return
        destruir_y_abrir(self.win, lambda: MiniGame1Window(self.nombre1, nombre2))

class MiniGame1Window:
    """Mini-juego 1: decidir quién elige el tablero (8x8 o 10x10).
       Después de mostrar ganador, espera ENTER para permitir elegir tamaño."""
    def __init__(self, name1, name2):
        self.name1 = name1
        self.name2 = name2
        self.win = tk.Tk()
        self.win.title("Mini-juego 1 - Elegir tablero")
        centrar_ventana(self.win, 560, 380)

        tk.Label(self.win, text="Mini-juego 1: Elegir tablero", font=("Arial", 12, "bold")).pack(pady=8)

        frame = tk.Frame(self.win)
        frame.pack(pady=6)
        tk.Label(frame, text=f"{self.name1} - número (1-100):").grid(row=0, column=0, sticky="e", padx=6, pady=4)
        tk.Label(frame, text=f"{self.name2} - número (1-100):").grid(row=1, column=0, sticky="e", padx=6, pady=4)
        self.num1_var = tk.StringVar()
        self.num2_var = tk.StringVar()
        self.e1 = tk.Entry(frame, textvariable=self.num1_var)
        self.e2 = tk.Entry(frame, textvariable=self.num2_var)
        self.e1.grid(row=0, column=1, padx=6, pady=4)
        self.e2.grid(row=1, column=1, padx=6, pady=4)

        self.btn_jugar = tk.Button(self.win, text="Jugar mini-juego", command=self.jugar)
        self.btn_jugar.pack(pady=8)

        self.result_label = tk.Label(self.win, text="", fg="blue")
        self.result_label.pack(pady=6)

        # no back button here
        self.win.mainloop()

    def jugar(self):
        n1 = self.num1_var.get().strip()
        n2 = self.num2_var.get().strip()
        try:
            num1 = int(n1); num2 = int(n2)
            if not (1 <= num1 <= 100 and 1 <= num2 <= 100):
                raise ValueError
        except:
            messagebox.showwarning("Error", "Ingrese números válidos entre 1 y 100.")
            return

        # evitar que ambos elijan el mismo número
        if num1 == num2:
            messagebox.showwarning("Error", "No pueden elegir el mismo número. Vuelvan a ingresar ambos números.")
            self.num1_var.set("")
            self.num2_var.set("")
            return

        numero_secreto = random.randint(1, 100)
        dif1 = abs(num1 - numero_secreto)
        dif2 = abs(num2 - numero_secreto)
        if dif1 < dif2:
            ganador_nombre = self.name1
        elif dif2 < dif1:
            ganador_nombre = self.name2
        else:
            ganador_nombre = random.choice([self.name1, self.name2])

        texto = (f"Número secreto: {numero_secreto}\nGanador: {ganador_nombre}\n"
                 f"Presione ENTER para continuar y elegir el tablero (8x8 o 10x10).")
        self.result_label.config(text=texto)

        # bind Enter to proceed to board selection, ensure only once
        def proceed(event=None):
            # unbind to avoid doble llamadas
            self.win.unbind("<Return>")
            destruir_y_abrir(self.win, lambda: BoardSelectionWindow(self.name1, self.name2, ganador_nombre))
        self.win.bind("<Return>", proceed)

class BoardSelectionWindow:
    """Después de mini1 y presionar Enter, elegir entre 8x8 y 10x10."""
    def __init__(self, name1, name2, ganador_tablero):
        self.name1 = name1
        self.name2 = name2
        self.ganador_tablero = ganador_tablero

        self.win = tk.Tk()
        self.win.title("Seleccionar tamaño de tablero")
        centrar_ventana(self.win, 420, 200)

        tk.Label(self.win, text=f"{ganador_tablero} - elegí el tamaño del tablero", font=("Arial", 12)).pack(pady=10)

        btn8 = tk.Button(self.win, text="8 x 8", width=12, command=lambda: destruir_y_abrir(self.win, lambda: MiniGame2Window(self.name1, self.name2, 8, 8, self.ganador_tablero)))
        btn10 = tk.Button(self.win, text="10 x 10", width=12, command=lambda: destruir_y_abrir(self.win, lambda: MiniGame2Window(self.name1, self.name2, 10, 10, self.ganador_tablero)))
        btn8.pack(pady=6)
        btn10.pack(pady=6)

class MiniGame2Window:
    """Mini-juego 2: decidir quién empieza; espera ENTER para continuar a elección de posiciones."""
    def __init__(self, name1, name2, filas_tab, cols_tab, ganador_tablero_nombre):
        self.name1 = name1
        self.name2 = name2
        self.filas_tab = filas_tab
        self.cols_tab = cols_tab
        self.ganador_tablero_nombre = ganador_tablero_nombre

        self.win = tk.Tk()
        self.win.title("Mini-juego 2 - Quién empieza")
        centrar_ventana(self.win, 580, 460)

        tk.Label(self.win, text="Mini-juego 2: Decidir quién empieza", font=("Arial", 12, "bold")).pack(pady=8)

        frame = tk.Frame(self.win)
        frame.pack(pady=6)
        tk.Label(frame, text=f"{self.name1} - número (1-100):").grid(row=0, column=0, sticky="e", padx=6, pady=4)
        tk.Label(frame, text=f"{self.name2} - número (1-100):").grid(row=1, column=0, sticky="e", padx=6, pady=4)
        self.num1_var = tk.StringVar()
        self.num2_var = tk.StringVar()
        self.e1 = tk.Entry(frame, textvariable=self.num1_var)
        self.e2 = tk.Entry(frame, textvariable=self.num2_var)
        self.e1.grid(row=0, column=1, padx=6, pady=4)
        self.e2.grid(row=1, column=1, padx=6, pady=4)

        self.btn_jugar = tk.Button(self.win, text="Jugar mini-juego 2", command=self.jugar)
        self.btn_jugar.pack(pady=8)

        self.result_label = tk.Label(self.win, text="", fg="blue")
        self.result_label.pack(pady=6)

        # no back button here
        self.win.mainloop()

    def jugar(self):
        n1 = self.num1_var.get().strip()
        n2 = self.num2_var.get().strip()
        try:
            num1 = int(n1); num2 = int(n2)
            if not (1 <= num1 <= 100 and 1 <= num2 <= 100):
                raise ValueError
        except:
            messagebox.showwarning("Error", "Ingrese números válidos entre 1 y 100.")
            return

        # evitar que ambos elijan el mismo número
        if num1 == num2:
            messagebox.showwarning("Error", "No pueden elegir el mismo número. Vuelvan a ingresar ambos números.")
            self.num1_var.set("")
            self.num2_var.set("")
            return

        numero_secreto = random.randint(1, 100)
        dif1 = abs(num1 - numero_secreto)
        dif2 = abs(num2 - numero_secreto)
        if dif1 < dif2:
            ganador_nombre = self.name1
        elif dif2 < dif1:
            ganador_nombre = self.name2
        else:
            ganador_nombre = random.choice([self.name1, self.name2])

        texto = (f"Número secreto: {numero_secreto}\nComienza: {ganador_nombre}\n"
                 f"Presione ENTER para que {ganador_nombre} elija su posición inicial.")
        self.result_label.config(text=texto)

        # bind Enter to proceed to winner choose pos (only once)
        def proceed(event=None):
            self.win.unbind("<Return>")
            destruir_y_abrir(self.win, lambda: WinnerChoosePosWindow(self.name1, self.name2, self.filas_tab, self.cols_tab, ganador_nombre, self.ganador_tablero_nombre))
        self.win.bind("<Return>", proceed)

class WinnerChoosePosWindow:
    """Ventana donde el ganador del mini-juego 2 elige su posición primero."""
    def __init__(self, name1, name2, filas_tab, cols_tab, ganador_nombre, ganador_tablero_nombre):
        self.name1 = name1
        self.name2 = name2
        self.filas_tab = filas_tab
        self.cols_tab = cols_tab
        self.ganador_nombre = ganador_nombre
        self.ganador_tablero_nombre = ganador_tablero_nombre

        self.win = tk.Tk()
        self.win.title(f"{ganador_nombre} - Elegir posición inicial")
        centrar_ventana(self.win, 520, 260)

        tk.Label(self.win, text=f"{ganador_nombre}, elegí tu posición (fila y columna, 0-index)", font=("Arial", 11)).pack(pady=8)

        frame = tk.Frame(self.win)
        frame.pack(pady=4)
        tk.Label(frame, text=f"Fila (0-{filas_tab-1}):").grid(row=0, column=0, padx=6, pady=4)
        tk.Label(frame, text=f"Columna (0-{cols_tab-1}):").grid(row=1, column=0, padx=6, pady=4)
        self.fila_var = tk.StringVar()
        self.col_var = tk.StringVar()
        e1 = tk.Entry(frame, textvariable=self.fila_var)
        e2 = tk.Entry(frame, textvariable=self.col_var)
        e1.grid(row=0, column=1, padx=6, pady=4)
        e2.grid(row=1, column=1, padx=6, pady=4)

        btn_confirm = tk.Button(self.win, text="Confirmar posición (Enter)", command=self.confirmar)
        btn_confirm.pack(pady=8)

        e1.bind("<Return>", lambda ev: self.confirmar())
        e2.bind("<Return>", lambda ev: self.confirmar())

        self.win.mainloop()

    def confirmar(self):
        try:
            f = int(self.fila_var.get()); c = int(self.col_var.get())
        except:
            messagebox.showwarning("Error", "Ingrese coordenadas válidas (enteros).")
            return
        if not (0 <= f < self.filas_tab and 0 <= c < self.cols_tab):
            messagebox.showwarning("Error", f"Las filas deben estar entre 0 y {self.filas_tab-1} y columnas entre 0 y {self.cols_tab-1}.")
            return
        jugador_inicio = Jugador(self.ganador_nombre)
        jugador_inicio.posicion = (f, c)
        destruir_y_abrir(self.win, lambda: OtherChoosePosWindow(self.name1, self.name2, self.filas_tab, self.cols_tab, jugador_inicio, self.ganador_tablero_nombre))

class OtherChoosePosWindow:
    """Ventana para que el otro jugador elija su posición (evitar solapamiento)."""
    def __init__(self, name1, name2, filas_tab, cols_tab, jugador_inicio, ganador_tablero_nombre):
        self.name1 = name1
        self.name2 = name2
        self.filas_tab = filas_tab
        self.cols_tab = cols_tab
        self.jugador_inicio = jugador_inicio
        self.ganador_tablero_nombre = ganador_tablero_nombre

        # determinar el otro jugador
        otro_nombre = self.name2 if self.jugador_inicio.nombre == self.name1 else self.name1
        self.otro_nombre = otro_nombre

        self.win = tk.Tk()
        self.win.title(f"{otro_nombre} - Elegir posición inicial")
        centrar_ventana(self.win, 520, 260)

        tk.Label(self.win, text=f"{otro_nombre}, elegí tu posición (fila y columna, 0-index)", font=("Arial", 11)).pack(pady=8)

        frame = tk.Frame(self.win)
        frame.pack(pady=4)
        tk.Label(frame, text=f"Fila (0-{filas_tab-1}):").grid(row=0, column=0, padx=6, pady=4)
        tk.Label(frame, text=f"Columna (0-{cols_tab-1}):").grid(row=1, column=0, padx=6, pady=4)
        self.fila_var = tk.StringVar()
        self.col_var = tk.StringVar()
        e1 = tk.Entry(frame, textvariable=self.fila_var)
        e2 = tk.Entry(frame, textvariable=self.col_var)
        e1.grid(row=0, column=1, padx=6, pady=4)
        e2.grid(row=1, column=1, padx=6, pady=4)

        btn_confirm = tk.Button(self.win, text="Confirmar posición (Enter)", command=self.confirmar)
        btn_confirm.pack(pady=8)

        e1.bind("<Return>", lambda ev: self.confirmar())
        e2.bind("<Return>", lambda ev: self.confirmar())

        self.win.mainloop()

    def confirmar(self):
        try:
            f = int(self.fila_var.get()); c = int(self.col_var.get())
        except:
            messagebox.showwarning("Error", "Ingrese coordenadas válidas (enteros).")
            return
        if not (0 <= f < self.filas_tab and 0 <= c < self.cols_tab):
            messagebox.showwarning("Error", f"Las filas deben estar entre 0 y {self.filas_tab-1} y columnas entre 0 y {self.cols_tab-1}.")
            return
        # evitar solapamiento con jugador_inicio
        if (f, c) == self.jugador_inicio.posicion:
            messagebox.showwarning("Error", "Esa posición ya está ocupada por el otro jugador. Elegí otra.")
            return
        otro_jugador = Jugador(self.otro_nombre)
        otro_jugador.posicion = (f, c)
        destruir_y_abrir(self.win, lambda: GameWindow(self.jugador_inicio, otro_jugador, self.filas_tab, self.cols_tab))

class GameWindow:
    """Ventana donde se muestra el tablero y se juega paso a paso."""
    def __init__(self, jugador_inicio, otro_jugador, filas, cols):
        self.win = tk.Tk()
        self.win.title("Juego - Sistema Dinámico Repulsor")
        centrar_ventana(self.win, 920, 700)

        self.tablero = Tablero(filas, cols)
        # mantener jugadores en orden; jugador_inicio comienza
        self.jugador1 = jugador_inicio  # inicia el que ganó mini-juego 2
        self.jugador2 = otro_jugador
        self.turno_actual = self.jugador1

        # Labels info
        info_frame = tk.Frame(self.win)
        info_frame.pack(pady=6)
        self.lbl_turno = tk.Label(info_frame, text=f"Turno: {self.turno_actual.nombre}", font=("Arial", 12, "bold"))
        self.lbl_turno.grid(row=0, column=0, padx=10)
        self.lbl_info = tk.Label(info_frame, text=f"{self.jugador1.nombre} (naranja)  vs  {self.jugador2.nombre} (azul)", font=("Arial", 11))
        self.lbl_info.grid(row=0, column=1, padx=10)

        # Frame tablero visual
        self.frame_tab = tk.Frame(self.win)
        self.frame_tab.pack(pady=6)

        # crear widgets de celdas
        self.cell_widgets = [[None for _ in range(cols)] for _ in range(filas)]
        self.cell_bg = {}  # bg por celda (permanece)
        for i in range(filas):
            for j in range(cols):
                simbol = self.tablero.casillas[i][j].obtener_simbolo()
                lbl = tk.Label(self.frame_tab, text=simbol, width=4, height=2, relief="ridge", font=("Consolas", 14), bg=CELL_BG_DEFAULT)
                lbl.grid(row=i, column=j, padx=1, pady=1)
                self.cell_widgets[i][j] = lbl
                self.cell_bg[(i,j)] = CELL_BG_DEFAULT

        # aplicar color a posiciones iniciales y marcar visitadas
        self.jugador1.visitadas.add(self.jugador1.posicion)
        self.jugador2.visitadas.add(self.jugador2.posicion)
        self.actualizar_tablero_visual()

        # Botones
        btn_frame = tk.Frame(self.win)
        btn_frame.pack(pady=10)
        self.btn_avanzar = tk.Button(btn_frame, text="Avanzar turno (Enter)", width=20, command=self.avanzar_turno)
        self.btn_avanzar.grid(row=0, column=0, padx=6)
        btn_reiniciar = tk.Button(btn_frame, text="Volver al menú", command=self.volver_al_menu_confirm)
        btn_reiniciar.grid(row=0, column=1, padx=6)
        btn_salir = tk.Button(btn_frame, text="Salir", command=self.win.destroy)
        btn_salir.grid(row=0, column=2, padx=6)

        # Bind Enter to avanzar_turno
        self.win.bind("<Return>", lambda event: self.avanzar_turno())

        # Area final (aparece al terminar)
        self.final_frame = tk.Frame(self.win)
        self.final_label = tk.Label(self.final_frame, text="", font=("Arial", 12, "bold"))
        self.btn_final_menu = tk.Button(self.final_frame, text="Volver al menú", command=lambda: destruir_y_abrir(self.win, MenuWindow))
        self.btn_final_quit = tk.Button(self.final_frame, text="Salir", command=self.win.destroy)

        self.win.mainloop()

    def actualizar_tablero_visual(self):
        # Actualiza símbolos y marcas de jugadores, y bg permanente por visitadas
        for i in range(self.tablero.filas):
            for j in range(self.tablero.columnas):
                simbolo = self.tablero.casillas[i][j].obtener_simbolo()
                texto = simbolo
                if self.jugador1.posicion == (i, j) and self.jugador2.posicion == (i, j):
                    texto = "X"
                elif self.jugador1.posicion == (i, j):
                    texto = "1"
                elif self.jugador2.posicion == (i, j):
                    texto = "2"
                self.cell_widgets[i][j].config(text=texto)
                # establecer bg según si fue visitada por j1 o j2 (j1 tiene prioridad visual aquí)
                if (i,j) in self.jugador1.visitadas:
                    self.cell_widgets[i][j].config(bg=COLOR_J1)
                    self.cell_bg[(i,j)] = COLOR_J1
                elif (i,j) in self.jugador2.visitadas:
                    self.cell_widgets[i][j].config(bg=COLOR_J2)
                    self.cell_bg[(i,j)] = COLOR_J2
                else:
                    self.cell_widgets[i][j].config(bg=self.cell_bg[(i,j)])
        self.lbl_turno.config(text=f"Turno: {self.turno_actual.nombre}")

    def destacar_casilla_permanente(self, pos, jugador):
        """Marca permanentemente la casilla pos con el color del jugador."""
        i,j = pos
        if jugador == self.jugador1:
            color = COLOR_J1
            self.jugador1.visitadas.add(pos)
        else:
            color = COLOR_J2
            self.jugador2.visitadas.add(pos)
        self.cell_widgets[i][j].config(bg=color)
        self.cell_bg[(i,j)] = color

    def destacar_casilla_temp_then_permanente(self, pos, jugador):
        """
        Primero parpadea la casilla (breve), luego la mantiene en color del jugador.
        """
        i,j = pos
        widget = self.cell_widgets[i][j]
        orig = self.cell_bg[(i,j)]
        highlight = COLOR_J1 if jugador == self.jugador1 else COLOR_J2
        try:
            widget.config(bg=highlight)
            widget.after(300, lambda: widget.config(bg=orig))
            widget.after(600, lambda: self.destacar_casilla_permanente(pos, jugador))
        except:
            self.destacar_casilla_permanente(pos, jugador)

    def avanzar_turno(self):
        jugador = self.turno_actual
        sigue, pos_rotada = jugador.mover(self.tablero)
        # resaltar (parpadeo y luego permanente) la casilla rotada con color del jugador
        if pos_rotada is not None:
            self.destacar_casilla_temp_then_permanente(pos_rotada, jugador)
        if not sigue:
            ganador = self.jugador1 if jugador == self.jugador2 else self.jugador2
            # actualizar visual antes de mostrar
            self.actualizar_tablero_visual()
            message = f"{jugador.nombre} salió del tablero.\n¡{ganador.nombre} gana!"
            messagebox.showinfo("Partida finalizada", message)
            self.mostrar_final(message)
            return
        # actualizar visual
        self.actualizar_tablero_visual()
        # alternar turno
        self.turno_actual = self.jugador1 if self.turno_actual == self.jugador2 else self.jugador2
        self.lbl_turno.config(text=f"Turno: {self.turno_actual.nombre}")

    def mostrar_final(self, mensaje):
        # desactivar boton avanzar y mostrar opciones
        self.btn_avanzar.config(state="disabled")
        self.final_label.config(text=mensaje)
        self.final_label.pack(pady=6)
        self.btn_final_menu.pack(side="left", padx=8)
        self.btn_final_quit.pack(side="left", padx=8)
        self.final_frame.pack(pady=12)

    def volver_al_menu_confirm(self):
        if messagebox.askyesno("Confirmar", "¿Volver al menú principal? Se perderá la partida actual."):
            destruir_y_abrir(self.win, MenuWindow)

# -------------------------------
# Programa principal
# -------------------------------
if __name__ == "__main__":
    MenuWindow()

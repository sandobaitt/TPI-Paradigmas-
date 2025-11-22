# repulsor_gui_fase14_final.py
# SISTEMA DINÁMICO REPULSOR - Código con doble Enter separado y forzado en minijuegos

import random
import tkinter as tk
from tkinter import messagebox
from functools import partial
import copy

# -------------------------------
# Constantes GUI y Colores
# -------------------------------
COLOR_J1 = "#FF6B00"    # Naranja brillante (Jugador 1)
COLOR_J2 = "#00BFFF"    # Azul Cielo Profundo (Jugador 2)
CELL_BG_DEFAULT = "#F0F0F0" 
COLOR_NUMERO = "black" 
DIRECCIONES_STR = ["Arriba (↑)", "Derecha (→)", "Abajo (↓)", "Izquierda (←)"] 

CELL_SIZE = 40
CANVAS_WIDTH = CELL_SIZE
CANVAS_HEIGHT = CELL_SIZE
PADDING_X = 1
PADDING_Y = 1
HIGHLIGHT_WIDTH_OCCUPIED = 4 
HIGHLIGHT_WIDTH_DEFAULT = 1 

POWER_UP_LISTA = [
    "Una Vida Más",         
    "Cambio de Posición",   
    "Ojo de Halcón",        
    "Intercambio de Posición" 
]

# -------------------------------
# Lógica del juego (POO)
# -------------------------------
class Casilla:
    def __init__(self, direccion=None):
        self.direccion = direccion if direccion is not None else random.randint(0, 3)
    def rotar(self):
        self.direccion = (self.direccion + 1) % 4
    def obtener_nombre_direccion(self):
        return DIRECCIONES_STR[self.direccion]

class Tablero:
    DELTAS = [(-1, 0), (0, 1), (1, 0), (0, -1)] 
    
    def __init__(self, filas, columnas):
        self.filas = filas
        self.columnas = columnas
        self.casillas = [[Casilla() for _ in range(columnas)] for _ in range(filas)] 
        self.power_up_posiciones = []
        
    def mover_desde(self, pos):
        i, j = pos
        casilla = self.casillas[i][j]
        di, dj = Tablero.DELTAS[casilla.direccion] 
        casilla.rotar() 
        nueva = (i + di, j + dj)
        if not self.dentro_de_limites(nueva):
            return False, (i, j) 
        return True, nueva 
    
    def dentro_de_limites(self, pos):
        i, j = pos
        return 0 <= i < self.filas and 0 <= j < self.columnas
    
    def obtener_destino(self, pos):
        if pos is None or not self.dentro_de_limites(pos): return None
        i, j = pos
        casilla = self.casillas[i][j]
        di, dj = Tablero.DELTAS[casilla.direccion]
        nueva_pos = (i + di, j + dj)
        return nueva_pos if self.dentro_de_limites(nueva_pos) else None
        
    def inicializar_power_ups(self, pos_j1, pos_j2):
        num_power_ups = max(1, (self.filas * self.columnas) // 10)
        posiciones_ocupadas = {pos_j1, pos_j2}
        posiciones_disponibles = []
        
        for i in range(self.filas):
            for j in range(self.columnas):
                pos = (i, j)
                if pos not in posiciones_ocupadas:
                    posiciones_disponibles.append(pos)
                    
        if len(posiciones_disponibles) < num_power_ups:
            self.power_up_posiciones = posiciones_disponibles
        else:
            self.power_up_posiciones = random.sample(posiciones_disponibles, num_power_ups)
            
    def tiene_power_up(self, pos):
        return pos in self.power_up_posiciones
    
    def consumir_power_up(self, pos):
        if pos in self.power_up_posiciones:
            self.power_up_posiciones.remove(pos)
            return True
        return False
        
class Jugador:
    def __init__(self, nombre, id_jugador, pos_inicial, pos_actual=None):
        self.nombre = nombre
        self.id_jugador = id_jugador 
        self.posicion = pos_actual if pos_actual is not None else pos_inicial 
        self.posicion_inicial = pos_inicial 
        self.pasos = 0
        self.vidas = 1 
        self.power_ups_activos = {} 
        
    def mover(self, tablero):
        sigue, nueva_pos_o_pos_rotada = tablero.mover_desde(self.posicion)
        
        if not sigue:
            return False, nueva_pos_o_pos_rotada
        
        self.posicion = nueva_pos_o_pos_rotada
        self.pasos += 1
        return True, nueva_pos_o_pos_rotada
    
    def reiniciar(self):
        self.posicion = self.posicion_inicial
        self.pasos = 0
        self.vidas = 1
        self.power_ups_activos = {}
        
# -------------------------------
# Utilidades GUI y Flujo de Ventanas
# -------------------------------
def centrar_ventana(ventana, ancho, alto):
    ventana.update_idletasks()
    pantalla_ancho = ventana.winfo_screenwidth()
    pantalla_alto = ventana.winfo_screenheight()
    x = int((pantalla_ancho / 2) - (ancho / 2))
    y = int((pantalla_alto / 2) - (alto / 2))
    ventana.geometry(f"{ancho}x{alto}+{x}+{y}")

def destruir_y_abrir(prev_window, new_window_creator):
    if prev_window is not None:
        try:
            prev_window.destroy()
        except:
            pass
    return new_window_creator()

# --- Clases de Configuración ---

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
        centrar_ventana(self.win, 650, 350) 
        txt = (

            "Reglas del Sistema Dinámico Repulsor:\n\n"
            "- Tablero con flechas en cada casilla. El movimiento se basa en la dirección de la flecha.\n"
            "- Al moverte, la flecha de la casilla que dejas **rota** 90 grados.\n"
            "- El juego termina cuando un jugador sale del tablero y no tiene vidas extra.\n"
            "- **Vidas:** Cada jugador empieza con 1 vida. Si sales del tablero, consumes 1 vida y vuelves al inicio.\n"
            "- **Power-Ups:** 10% del tablero contiene Power-Ups ocultos que otorgan ventajas."
        )
        lbl = tk.Label(self.win, text=txt, justify="left", padx=12, pady=12, font=("Arial", 10))
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
        btn = tk.Button(self.win, text="Siguiente (Enter)", command=self.siguiente)
        btn.pack(pady=8)
        self.entry.bind("<Return>", lambda event: self.siguiente())
        self.win.mainloop()
    def siguiente(self):
        nombre = self.entry.get().strip()
        if not nombre:
            messagebox.showwarning("Error", "Ingrese un nombre válido.")
            return
        destruir_y_abrir(self.win, lambda: NameWindow2(nombre))
        
class NameWindow2:
    nombre1_static = None
    nombre2_static = None
    
    def __init__(self, nombre1):
        self.nombre1 = nombre1
        self.win = tk.Tk()
        self.win.title("Jugador 2 - Ingresar nombre")
        centrar_ventana(self.win, 420, 180) 
        tk.Label(self.win, text="Ingrese el nombre del Jugador 2:", font=("Arial", 11)).pack(pady=8)
        self.entry = tk.Entry(self.win)
        self.entry.pack(pady=6)
        btn = tk.Button(self.win, text="Siguiente (Enter)", command=self.siguiente)
        btn.pack(pady=8)
        self.entry.bind("<Return>", lambda event: self.siguiente())
        self.win.mainloop()
        
    def siguiente(self):
        nombre2 = self.entry.get().strip()
        if not nombre2:
            messagebox.showwarning("Error", "Ingrese un nombre válido.")
            return
        if nombre2 == self.nombre1:
            messagebox.showwarning("Error", "Los nombres deben ser diferentes.")
            return
            
        NameWindow2.nombre1_static = self.nombre1
        NameWindow2.nombre2_static = nombre2
        
        destruir_y_abrir(self.win, lambda: MiniGame1Window(self.nombre1, nombre2))

class MiniGame1Window:
    ganador_tablero_static = None 
    
    def __init__(self, name1, name2):
        self.name1 = name1
        self.name2 = name2
        self.win = tk.Tk()
        self.win.title("Mini-juego 1 - Elegir tablero")
        centrar_ventana(self.win, 560, 320) 
        self.played = False 
        
        tk.Label(self.win, text="Mini-juego 1: Elegir tablero", font=("Arial", 12, "bold")).pack(pady=8)
        frame = tk.Frame(self.win); frame.pack(pady=6)
        tk.Label(frame, text=f"{self.name1} - número (1-100):").grid(row=0, column=0, sticky="e", padx=6, pady=4)
        tk.Label(frame, text=f"{self.name2} - número (1-100):").grid(row=1, column=0, sticky="e", padx=6, pady=4)
        self.num1_var = tk.StringVar(); self.num2_var = tk.StringVar()
        self.e1 = tk.Entry(frame, textvariable=self.num1_var); self.e2 = tk.Entry(frame, textvariable=self.num2_var)
        self.e1.grid(row=0, column=1, padx=6, pady=4); self.e2.grid(row=1, column=1, padx=6, pady=4)
        
        # Botones Jugar y Confirmar
        self.btn_jugar = tk.Button(self.win, text="Jugar Mini-juego", command=self.jugar_game)
        self.btn_jugar.pack(pady=8)
        
        self.result_label = tk.Label(self.win, text="", font=("Arial", 11, "bold"), fg="blue"); self.result_label.pack(pady=6)

        self.btn_confirmar = tk.Button(self.win, text="Confirmar (Enter)", state="disabled", command=self.avanzar_ventana)
        self.btn_confirmar.pack(pady=8)
        
        # Binding: Enter en entrys llama a jugar_game
        self.e1.bind("<Return>", lambda event: self.jugar_game())
        self.e2.bind("<Return>", lambda event: self.jugar_game())
        
        # Binding: Enter en el botón Confirmar llama a avanzar_ventana (solo se activa cuando el botón se habilita)
        # Importante: El binding de Enter solo se activa en el botón cuando este está habilitado.
        self.btn_confirmar.bind("<Return>", lambda event: self.avanzar_ventana()) 

        # Eliminar el binding global de la ventana para evitar doble activación al presionar Enter en el Entry.
        self.win.unbind("<Return>")


        self.win.mainloop()
            
    def jugar_game(self):
        if self.played:
            return

        n1 = self.num1_var.get().strip(); n2 = self.num2_var.get().strip()
        try:
            num1 = int(n1); num2 = int(n2)
            if not (1 <= num1 <= 100 and 1 <= num2 <= 100): raise ValueError
        except:
            messagebox.showwarning("Error", "Ingrese números válidos entre 1 y 100."); return
            
        if num1 == num2:
            messagebox.showwarning("Error", "No pueden elegir el mismo número."); self.num1_var.set(""); self.num2_var.set(""); return
            
        numero_secreto = random.randint(1, 100)
        dif1 = abs(num1 - numero_secreto); dif2 = abs(num2 - numero_secreto)
        
        if dif1 < dif2:
            ganador_nombre = self.name1
        elif dif2 < dif1:
            ganador_nombre = self.name2
        else:
            ganador_nombre = random.choice([self.name1, self.name2])
            
        # Actualización de la interfaz
        texto = (f"Número secreto: {numero_secreto}\n"
                 f"¡El ganador es: {ganador_nombre}!")
        
        self.result_label.config(text=texto)
        self.btn_jugar.config(state="disabled") 
        self.btn_confirmar.config(state="normal") 
        self.played = True
        
        MiniGame1Window.ganador_tablero_static = ganador_nombre
        
        # Mover el foco al botón Confirmar para que el próximo Enter lo active
        self.btn_confirmar.focus_set()


    def avanzar_ventana(self):
        if self.played:
            # Asegurarse que el foco está en el botón para evitar doble avance si se llama desde el binding de entry
            if self.win.focus_get() == self.btn_confirmar:
                destruir_y_abrir(self.win, lambda: BoardSelectionWindow(self.name1, self.name2, MiniGame1Window.ganador_tablero_static))

class BoardSelectionWindow:
    filas_static = None
    cols_static = None
    
    def __init__(self, name1, name2, ganador_tablero):
        self.name1 = name1
        self.name2 = name2
        self.ganador_tablero = ganador_tablero
        self.win = tk.Tk()
        self.win.title("Seleccionar tamaño de tablero")
        centrar_ventana(self.win, 420, 200) 
        tk.Label(self.win, text=f"{ganador_tablero}, elegí el tamaño del tablero", font=("Arial", 12)).pack(pady=10)
        
        def select_8x8(): self.seleccionar_y_continuar(8, 8)
        def select_10x10(): self.seleccionar_y_continuar(10, 10)
        
        btn8 = tk.Button(self.win, text="8 x 8", width=12, command=select_8x8)
        btn10 = tk.Button(self.win, text="10 x 10", width=12, command=select_10x10)
        btn8.pack(pady=6); btn10.pack(pady=6)
        
        # Enter deshabilitado en esta ventana
        self.win.unbind("<Return>")

    def seleccionar_y_continuar(self, filas, cols):
        BoardSelectionWindow.filas_static = filas
        BoardSelectionWindow.cols_static = cols
        destruir_y_abrir(self.win, lambda: MiniGame2Window(self.name1, self.name2, filas, cols, self.ganador_tablero))
        
class MiniGame2Window:
    ganador_inicio_static = None
    
    def __init__(self, name1, name2, filas_tab, cols_tab, ganador_tablero_nombre):
        self.name1 = name1; self.name2 = name2; self.filas_tab = filas_tab; self.cols_tab = cols_tab
        self.ganador_tablero_nombre = ganador_tablero_nombre
        self.win = tk.Tk()
        self.win.title("Mini-juego 2 - Quién empieza")
        centrar_ventana(self.win, 580, 320) 
        self.played = False 
        
        tk.Label(self.win, text="Mini-juego 2: Decidir quién empieza", font=("Arial", 12, "bold")).pack(pady=8)
        frame = tk.Frame(self.win); frame.pack(pady=6)
        tk.Label(frame, text=f"{self.name1} - número (1-100):").grid(row=0, column=0, sticky="e", padx=6, pady=4)
        tk.Label(frame, text=f"{self.name2} - número (1-100):").grid(row=1, column=0, sticky="e", padx=6, pady=4)
        self.num1_var = tk.StringVar(); self.num2_var = tk.StringVar()
        self.e1 = tk.Entry(frame, textvariable=self.num1_var); self.e2 = tk.Entry(frame, textvariable=self.num2_var)
        self.e1.grid(row=0, column=1, padx=6, pady=4); self.e2.grid(row=1, column=1, padx=6, pady=4)
        
        # Botones Jugar y Confirmar
        self.btn_jugar = tk.Button(self.win, text="Jugar Mini-juego", command=self.jugar_game)
        self.btn_jugar.pack(pady=8)
        
        # La etiqueta de resultado muestra quién gana
        self.result_label = tk.Label(self.win, text="", font=("Arial", 11, "bold"), fg="blue"); self.result_label.pack(pady=6)
        
        self.btn_confirmar = tk.Button(self.win, text="Confirmar (Enter)", state="disabled", command=self.avanzar_ventana)
        self.btn_confirmar.pack(pady=8)
        
        # Binding: Enter en entrys llama a jugar_game
        self.e1.bind("<Return>", lambda event: self.jugar_game())
        self.e2.bind("<Return>", lambda event: self.jugar_game())
        
        # Binding: Enter en el botón Confirmar llama a avanzar_ventana
        self.btn_confirmar.bind("<Return>", lambda event: self.avanzar_ventana()) 

        # Eliminar el binding global de la ventana para evitar doble activación.
        self.win.unbind("<Return>")

        self.win.mainloop()
        
    def jugar_game(self):
        if self.played:
            return
            
        n1 = self.num1_var.get().strip(); n2 = self.num2_var.get().strip()
        try:
            num1 = int(n1); num2 = int(n2)
            if not (1 <= num1 <= 100 and 1 <= num2 <= 100): raise ValueError
        except:
            messagebox.showwarning("Error", "Ingrese números válidos entre 1 y 100."); return
            
        if num1 == num2:
            messagebox.showwarning("Error", "No pueden elegir el mismo número."); self.num1_var.set(""); self.num2_var.set(""); return
            
        numero_secreto = random.randint(1, 100)
        dif1 = abs(num1 - numero_secreto); dif2 = abs(num2 - numero_secreto)
        
        if dif1 < dif2:
            ganador_nombre = self.name1
        elif dif2 < dif1:
            ganador_nombre = self.name2
        else:
            ganador_nombre = random.choice([self.name1, self.name2])
            
        # Actualización de la interfaz
        texto = (f"Número secreto: {numero_secreto}\n"
                 f"¡El jugador que comienza es: {ganador_nombre}!")
                 
        self.result_label.config(text=texto)
        self.btn_jugar.config(state="disabled") 
        self.btn_confirmar.config(state="normal") 
        self.played = True
        
        MiniGame2Window.ganador_inicio_static = ganador_nombre
        
        # Mover el foco al botón Confirmar para que el próximo Enter lo active
        self.btn_confirmar.focus_set()
        
    def avanzar_ventana(self):
        if self.played:
            # Asegurarse que el foco está en el botón para evitar doble avance si se llama desde el binding de entry
            if self.win.focus_get() == self.btn_confirmar:
                destruir_y_abrir(self.win, lambda: WinnerChoosePosWindow(self.name1, self.name2, self.filas_tab, self.cols_tab, MiniGame2Window.ganador_inicio_static, self.ganador_tablero_nombre))


class WinnerChoosePosWindow:
    def __init__(self, name1, name2, filas_tab, cols_tab, ganador_nombre, ganador_tablero_nombre):
        self.name1 = name1; self.name2 = name2; self.filas_tab = filas_tab; self.cols_tab = cols_tab
        self.ganador_nombre = ganador_nombre; self.ganador_tablero_nombre = ganador_tablero_nombre
        self.win = tk.Tk(); self.win.title(f"{ganador_nombre} - Elegir posición inicial")
        centrar_ventana(self.win, 520, 220) 
        
        tk.Label(self.win, text=f"{ganador_nombre} (J1 - Naranja), elegí tu posición (fila y columna)", font=("Arial", 11)).pack(pady=8)
        frame = tk.Frame(self.win); frame.pack(pady=4)
        tk.Label(frame, text=f"Fila (1-{filas_tab}):").grid(row=0, column=0, padx=6, pady=4)
        tk.Label(frame, text=f"Columna (1-{cols_tab}):").grid(row=1, column=0, padx=6, pady=4)
        
        self.fila_var = tk.StringVar(); self.col_var = tk.StringVar()
        e1 = tk.Entry(frame, textvariable=self.fila_var); e2 = tk.Entry(frame, textvariable=self.col_var)
        e1.grid(row=0, column=1, padx=6, pady=4); e2.grid(row=1, column=1, padx=6, pady=4)
        
        btn_confirm = tk.Button(self.win, text="Confirmar posición (Enter)", command=self.confirmar)
        btn_confirm.pack(pady=8)
        
        e1.bind("<Return>", lambda ev: self.confirmar()); e2.bind("<Return>", lambda ev: self.confirmar())
        
        self.win.mainloop()
        
    def confirmar(self):
        try:
            f_in = int(self.fila_var.get()); c_in = int(self.col_var.get())
        except:
            messagebox.showwarning("Error", "Ingrese coordenadas válidas (enteros)."); return
            
        if not (1 <= f_in <= self.filas_tab and 1 <= c_in <= self.cols_tab):
            messagebox.showwarning("Error", f"Las filas deben estar entre 1 y {self.filas_tab} y columnas entre 1 y {self.cols_tab}."); return
        
        f = f_in - 1
        c = c_in - 1
        
        jugador_inicio = Jugador(self.ganador_nombre, 1, (f, c))
        
        otro_nombre = self.name2 if self.ganador_nombre == self.name1 else self.name1
        otro_jugador = Jugador(otro_nombre, 2, None) 
        
        destruir_y_abrir(self.win, lambda: OtherChoosePosWindow(self.name1, self.name2, self.filas_tab, self.cols_tab, jugador_inicio, otro_jugador))

class OtherChoosePosWindow:
    jugador1_static = None 
    jugador2_static = None 
    
    def __init__(self, name1, name2, filas_tab, cols_tab, jugador_inicio, otro_jugador):
        self.name1 = name1; self.name2 = name2; self.filas_tab = filas_tab; self.cols_tab = cols_tab
        self.jugador_inicio = jugador_inicio; self.otro_jugador = otro_jugador
        self.win = tk.Tk(); self.win.title(f"{otro_jugador.nombre} - Elegir posición inicial")
        centrar_ventana(self.win, 520, 220)
        
        tk.Label(self.win, text=f"{otro_jugador.nombre} (J2 - Azul), elegí tu posición (fila y columna)", font=("Arial", 11)).pack(pady=8)
        frame = tk.Frame(self.win); frame.pack(pady=4)
        tk.Label(frame, text=f"Fila (1-{filas_tab}):").grid(row=0, column=0, padx=6, pady=4)
        tk.Label(frame, text=f"Columna (1-{cols_tab}):").grid(row=1, column=0, padx=6, pady=4)
        
        self.fila_var = tk.StringVar(); self.col_var = tk.StringVar()
        e1 = tk.Entry(frame, textvariable=self.fila_var); e2 = tk.Entry(frame, textvariable=self.col_var)
        e1.grid(row=0, column=1, padx=6, pady=4); e2.grid(row=1, column=1, padx=6, pady=4)
        
        btn_confirm = tk.Button(self.win, text="Confirmar posición (Enter)", command=self.confirmar)
        btn_confirm.pack(pady=8)
        
        e1.bind("<Return>", lambda ev: self.confirmar()); e2.bind("<Return>", lambda ev: self.confirmar())
        
        self.win.mainloop()
        
    def confirmar(self):
        try:
            f_in = int(self.fila_var.get()); c_in = int(self.col_var.get())
        except:
            messagebox.showwarning("Error", "Ingrese coordenadas válidas (enteros)."); return
            
        if not (1 <= f_in <= self.filas_tab and 1 <= c_in <= self.cols_tab):
            messagebox.showwarning("Error", f"Las filas deben estar entre 1 y {self.filas_tab} y columnas entre 1 y {self.cols_tab}."); return
        
        f = f_in - 1
        c = c_in - 1
        nueva_pos_0_index = (f, c)
        
        if nueva_pos_0_index == self.jugador_inicio.posicion:
            messagebox.showwarning("Error", "Esa posición ya está ocupada por el otro jugador. Elegí otra."); return
        
        self.otro_jugador.posicion = nueva_pos_0_index
        self.otro_jugador.posicion_inicial = nueva_pos_0_index
        
        jugador1_base = self.jugador_inicio if self.jugador_inicio.id_jugador == 1 else self.otro_jugador
        jugador2_base = self.otro_jugador if self.otro_jugador.id_jugador == 2 else self.jugador_inicio

        OtherChoosePosWindow.jugador1_static = jugador1_base 
        OtherChoosePosWindow.jugador2_static = jugador2_base

        destruir_y_abrir(self.win, lambda: GameWindow(jugador1_base, jugador2_base, self.filas_tab, self.cols_tab))

class PowerUpSorteoWindow:
    def __init__(self, parent_game_window, pos_power_up, jugador_ganador):
        self.parent_game = parent_game_window
        self.jugador_ganador = jugador_ganador
        
        self.win = tk.Toplevel(self.parent_game.win)
        self.win.title("Sorteo de Power-Ups 🎁")
        self.win.grab_set() 
        centrar_ventana(self.win, 550, 280) 
        self.power_up_pos = pos_power_up
        self.power_up_tocado = None
        
        tk.Label(self.win, text=f"Sorteo de Power-Ups para {jugador_ganador.nombre}", font=("Arial", 14, "bold"), fg=COLOR_J1 if jugador_ganador.id_jugador==1 else COLOR_J2).pack(pady=10)
        tk.Label(self.win, text="Ingresa un número del 1 al 4 para realizar el sorteo:", font=("Arial", 11)).pack(pady=5)
        
        input_frame = tk.Frame(self.win)
        input_frame.pack(pady=5)
        self.num_var = tk.StringVar()
        self.entry = tk.Entry(input_frame, textvariable=self.num_var, width=5)
        self.entry.grid(row=0, column=0, padx=5)
        
        self.btn_sortear = tk.Button(input_frame, text="Sortear (Enter)", command=self.sortear)
        self.btn_sortear.grid(row=0, column=1, padx=5)
        
        self.result_label = tk.Label(self.win, text="", font=("Arial", 11, "italic"), fg="blue")
        self.result_label.pack(pady=10)
        
        self.btn_volver = tk.Button(self.win, text="Volver al Tablero", state="disabled", command=self.regresar_a_tablero)
        self.btn_volver.pack(pady=10)
        
        self.entry.bind("<Return>", lambda event: self.sortear())
        self.win.protocol("WM_DELETE_WINDOW", self.disable_close) 

    def disable_close(self):
        if self.btn_volver['state'] == 'disabled':
            messagebox.showwarning("Advertencia", "Debes sortear un Power-Up primero.")
            return
        self.regresar_a_tablero()

    def sortear(self):
        num_str = self.num_var.get().strip()
        try:
            num = int(num_str)
            if not (1 <= num <= 4): 
                raise ValueError
        except:
            messagebox.showwarning("Error", "Número inválido. Debe ser un entero entre 1 y 4.")
            return

        self.power_up_tocado = random.choice(POWER_UP_LISTA)
        self.parent_game.tablero.consumir_power_up(self.power_up_pos)

        descripcion = f"¡Felicidades, {self.jugador_ganador.nombre}! Ganaste: **{self.power_up_tocado}**."
        
        if self.power_up_tocado == "Una Vida Más":
            self.jugador_ganador.vidas += 1
            descripcion += "\nSe te ha agregado una vida extra (Resurrección)."
        elif self.power_up_tocado == "Cambio de Posición":
             self.parent_game.power_up_recibido_pendiente = self.power_up_tocado
             descripcion += "\nAl volver al tablero, podrás elegir la coordenada de teletransporte. ¡El turno termina con esta acción!"
        elif self.power_up_tocado == "Intercambio de Posición":
            self.parent_game.power_up_recibido_pendiente = self.power_up_tocado
            descripcion += "\nAl volver al tablero, se realizará el intercambio instantáneo de posiciones. ¡El turno termina con esta acción!"
        elif self.power_up_tocado == "Ojo de Halcón":
            self.parent_game.power_up_recibido_pendiente = self.power_up_tocado
            descripcion += "\nAl volver al tablero, se revelará la ubicación de un Power-Up oculto (y se desactivará)."
        
        self.result_label.config(text=descripcion)
        self.btn_sortear.config(state="disabled")
        self.entry.config(state="disabled")
        
        self.btn_volver.config(state="normal", text="Volver al Tablero (Enter)")
        self.win.unbind("<Return>")
        self.win.bind("<Return>", lambda event: self.regresar_a_tablero())


    def regresar_a_tablero(self):
        self.win.grab_release()
        self.win.destroy()
        self.parent_game.manejar_efecto_post_sorteo()
        
# -------------------------------
# Clase principal del juego (GameWindow)
# -------------------------------
class GameWindow:
    def __init__(self, jugador1, jugador2, filas, cols):
        self.win = tk.Tk()
        self.win.title("Juego - Sistema Dinámico Repulsor")
        self.filas = filas; self.cols = cols
        
        self.jugador1_base = copy.deepcopy(jugador1)
        self.jugador2_base = copy.deepcopy(jugador2)
        
        ancho_req = cols * (CELL_SIZE + 2*PADDING_X) + 120
        # El alto se mantendrá para que puedas ajustarlo manualmente.
        alto_req = filas * (CELL_SIZE + 2*PADDING_Y) + 350
        centrar_ventana(self.win, ancho_req, alto_req)
        self.tablero = Tablero(filas, cols)
        
        self.jugador1 = jugador1
        self.jugador2 = jugador2
        
        self.turno_actual = self.jugador1 if self.jugador1.id_jugador == 1 else self.jugador2
        self.oponente = self.jugador2 if self.turno_actual == self.jugador1 else self.jugador1
        
        self.power_up_recibido_pendiente = None 
        
        self.tablero.inicializar_power_ups(self.jugador1.posicion, self.jugador2.posicion)

        # Panel de Información
        info_frame = tk.Frame(self.win); info_frame.pack(pady=6)
        self.lbl_turno = tk.Label(info_frame, text=f"Turno: {self.turno_actual.nombre}", font=("Arial", 12, "bold")); self.lbl_turno.grid(row=0, column=0, columnspan=2, pady=2)
        
        self.lbl_info1 = tk.Label(info_frame, text=f"**{self.jugador1.nombre}** (Naranja)", font=("Arial", 11), fg=COLOR_J1); self.lbl_info1.grid(row=1, column=0, padx=10, pady=2)
        self.lbl_vidas1 = tk.Label(info_frame, text=f"Vida: {self.jugador1.vidas}", font=("Arial", 10)); self.lbl_vidas1.grid(row=2, column=0, padx=10, pady=2)
        self.lbl_dir_j1 = tk.Label(info_frame, text="Dir. J1: --", font=("Arial", 10, "italic")); self.lbl_dir_j1.grid(row=3, column=0, padx=10, pady=2)
        
        self.lbl_info2 = tk.Label(info_frame, text=f"**{self.jugador2.nombre}** (Azul)", font=("Arial", 11), fg=COLOR_J2); self.lbl_info2.grid(row=1, column=1, padx=10, pady=2)
        self.lbl_vidas2 = tk.Label(info_frame, text=f"Vida: {self.jugador2.vidas}", font=("Arial", 10)); self.lbl_vidas2.grid(row=2, column=1, padx=10, pady=2)
        self.lbl_dir_j2 = tk.Label(info_frame, text="Dir. J2: --", font=("Arial", 10, "italic")); self.lbl_dir_j2.grid(row=3, column=1, padx=10, pady=2)

        self.lbl_status = tk.Label(self.win, text="", font=("Arial", 10, "bold"), fg="red"); self.lbl_status.pack(pady=4) 

        # Frame tablero visual
        self.frame_tab = tk.Frame(self.win); self.frame_tab.pack(pady=6)

        # Crear widgets de celdas
        self.cell_widgets = [[None for _ in range(cols)] for _ in range(filas)]
        for i in range(filas):
            for j in range(cols):
                canvas = tk.Canvas(self.frame_tab, width=CANVAS_WIDTH, height=CANVAS_HEIGHT, 
                                    bg=CELL_BG_DEFAULT, relief="solid", 
                                    highlightthickness=HIGHLIGHT_WIDTH_DEFAULT, highlightbackground="grey") 
                canvas.grid(row=i, column=j, padx=PADDING_X, pady=PADDING_Y)
                self.cell_widgets[i][j] = canvas
                
        self.actualizar_tablero_visual()

        # Botones y Binds
        btn_frame = tk.Frame(self.win); btn_frame.pack(pady=10)
        self.btn_avanzar = tk.Button(btn_frame, text="Avanzar turno (Enter)", width=20, command=self.avanzar_turno)
        self.btn_avanzar.grid(row=0, column=0, padx=6)
        
        btn_reiniciar_partida = tk.Button(btn_frame, text="Reiniciar Partida", command=self.reiniciar_partida_confirm)
        btn_reiniciar_partida.grid(row=0, column=1, padx=6)
        
        btn_volver_menu = tk.Button(btn_frame, text="Volver al menú", command=self.volver_al_menu_confirm)
        btn_volver_menu.grid(row=0, column=2, padx=6)
        
        self.final_label = tk.Label(self.win, text="", font=("Arial", 12, "bold"))
        
        self.win.bind("<Return>", lambda event: self.avanzar_turno())
        
        self.win.mainloop()

    def _dibujar_triangulo(self, canvas, direccion, fill_color="black"):
        canvas.delete("arrow") 
        c = CANVAS_WIDTH / 2
        d = CANVAS_WIDTH / 6 
        puntos = []
        if direccion == 0: 
            puntos = (c, c - d, c + d, c + d, c - d, c + d)
        elif direccion == 1: 
            puntos = (c + d, c, c - d, c - d, c - d, c + d)
        elif direccion == 2: 
            puntos = (c, c + d, c + d, c - d, c - d, c - d)
        elif direccion == 3: 
            puntos = (c - d, c, c + d, c - d, c + d, c + d)
        if puntos:
            canvas.create_polygon(puntos, fill=fill_color, outline=fill_color, tags="arrow")
    
    def _dibujar_posicion_jugador(self, canvas, jugador_id, offset_x=0):
        cx = CANVAS_WIDTH / 2
        cy = CANVAS_HEIGHT / 2
        canvas.delete("player_marker") 
        canvas.create_text(cx + offset_x, cy, 
                           text=str(jugador_id), 
                           font=("Arial", 14, "bold"), 
                           fill=COLOR_NUMERO, 
                           tags="player_marker")

    def actualizar_info_panel(self):
        self.lbl_vidas1.config(text=f"Vida: {self.jugador1.vidas}")
        self.lbl_vidas2.config(text=f"Vida: {self.jugador2.vidas}")
        self.lbl_turno.config(text=f"Turno: {self.turno_actual.nombre}")
        self.lbl_status.config(text="")
        
    def actualizar_tablero_visual(self):
        self.actualizar_info_panel()

        pos_destino_j1 = self.tablero.obtener_destino(self.jugador1.posicion)
        dir_str_j1 = "--"
        if self.jugador1.posicion and self.tablero.dentro_de_limites(self.jugador1.posicion):
            i, j = self.jugador1.posicion
            dir_str_j1 = self.tablero.casillas[i][j].obtener_nombre_direccion()
        self.lbl_dir_j1.config(text=f"Dir. J1: {dir_str_j1}")

        pos_destino_j2 = self.tablero.obtener_destino(self.jugador2.posicion)
        dir_str_j2 = "--"
        if self.jugador2.posicion and self.tablero.dentro_de_limites(self.jugador2.posicion):
            i, j = self.jugador2.posicion
            dir_str_j2 = self.tablero.casillas[i][j].obtener_nombre_direccion()
        self.lbl_dir_j2.config(text=f"Dir. J2: {dir_str_j2}")
        
        for i in range(self.tablero.filas):
            for j in range(self.tablero.columnas):
                canvas = self.cell_widgets[i][j]
                pos = (i, j)
                casilla = self.tablero.casillas[i][j]
                
                jugador_en_celda = None
                color_remarcado = "grey"
                grosor_borde = HIGHLIGHT_WIDTH_OCCUPIED
                bg_color = CELL_BG_DEFAULT

                is_j1_pos = self.jugador1.posicion == pos
                is_j2_pos = self.jugador2.posicion == pos

                if is_j1_pos and is_j2_pos:
                    jugador_en_celda = "BOTH"
                    color_remarcado = COLOR_J1 if self.turno_actual.id_jugador == 1 else COLOR_J2
                    grosor_borde = HIGHLIGHT_WIDTH_OCCUPIED
                elif is_j1_pos:
                    jugador_en_celda = self.jugador1
                    color_remarcado = COLOR_J1
                    grosor_borde = HIGHLIGHT_WIDTH_OCCUPIED
                elif is_j2_pos:
                    jugador_en_celda = self.jugador2
                    color_remarcado = COLOR_J2
                    grosor_borde = HIGHLIGHT_WIDTH_OCCUPIED
                else:
                    grosor_borde = HIGHLIGHT_WIDTH_DEFAULT

                
                is_j1_destino = pos == pos_destino_j1 and not is_j1_pos
                is_j2_destino = pos == pos_destino_j2 and not is_j2_pos

                if is_j1_destino and is_j2_destino:
                    bg_color = COLOR_J1 if self.turno_actual.id_jugador == 1 else COLOR_J2
                elif is_j1_destino:
                    bg_color = COLOR_J1
                elif is_j2_destino:
                    bg_color = COLOR_J2
                    
                canvas.config(highlightbackground=color_remarcado, 
                              highlightthickness=grosor_borde,
                              bg=bg_color) 
                canvas.delete("all") 
                
                if jugador_en_celda:
                    if jugador_en_celda == "BOTH":
                        self._dibujar_posicion_jugador(canvas, self.jugador1.id_jugador, offset_x=-8)
                        self._dibujar_posicion_jugador(canvas, self.jugador2.id_jugador, offset_x=8)
                    else:
                        self._dibujar_posicion_jugador(canvas, jugador_en_celda.id_jugador)
                else:
                    self._dibujar_triangulo(canvas, casilla.direccion, fill_color="black")


    def avanzar_turno(self):
        jugador = self.turno_actual
        
        sigue, nueva_pos_o_pos_rotada = jugador.mover(self.tablero)
        
        if not sigue:
            if jugador.vidas > 1:
                jugador.vidas -= 1
                jugador.posicion = jugador.posicion_inicial
                f_ini, c_ini = jugador.posicion_inicial
                messagebox.showinfo("Resurrección", f"¡{jugador.nombre} salió del tablero! Consumes una vida (quedan {jugador.vidas}). Vuelves a la posición inicial (Fila {f_ini+1}, Columna {c_ini+1}).")
            else:
                self.actualizar_tablero_visual() 
                ganador = self.jugador1 if jugador == self.jugador2 else self.jugador2
                message = f"¡{jugador.nombre} salió del tablero! (Vida 0)¡ {ganador.nombre}  gana!"
                messagebox.showinfo("Partida finalizada", message)
                
                self.btn_avanzar.config(state="disabled")
                self.win.unbind("<Return>")
                self.final_label.config(text=message)
                self.final_label.pack(pady=12) 
                self.lbl_dir_j1.config(text="Dir. J1: FINALIZADA")
                self.lbl_dir_j2.config(text="Dir. J2: FINALIZADA")
                return
        
        if self.tablero.tiene_power_up(jugador.posicion):
            self.win.withdraw()
            PowerUpSorteoWindow(self, jugador.posicion, jugador) 
            return

        self.actualizar_tablero_visual()
        self.alternar_turno()
        
    def alternar_turno(self):
        self.turno_actual = self.jugador1 if self.turno_actual == self.jugador2 else self.jugador2
        self.oponente = self.jugador2 if self.turno_actual == self.jugador1 else self.jugador1
        self.actualizar_info_panel()

    def manejar_efecto_post_sorteo(self):
        self.win.deiconify() 
        self.btn_avanzar.config(state="normal") 

        if self.power_up_recibido_pendiente == "Cambio de Posición":
            self.power_up_recibido_pendiente = None
            TeleportWindow(self)
            return 
            
        elif self.power_up_recibido_pendiente == "Intercambio de Posición":
            self.power_up_recibido_pendiente = None
            self.intercambiar_posicion()
            return 
            
        elif self.power_up_recibido_pendiente == "Ojo de Halcón":
            self.power_up_recibido_pendiente = None
            self.usar_ojo_de_halcon()
            
        self.actualizar_tablero_visual()
        self.alternar_turno()

    def intercambiar_posicion(self):
        jugador_actual = self.turno_actual
        jugador_oponente = self.oponente 
        
        temp_pos = jugador_actual.posicion
        jugador_actual.posicion = jugador_oponente.posicion
        jugador_oponente.posicion = temp_pos
        
        messagebox.showinfo("Intercambio", f"¡{jugador_actual.nombre} y {jugador_oponente.nombre} han intercambiado posiciones! Tu turno ha terminado.")
        self.actualizar_tablero_visual()
        self.alternar_turno()
        
    def usar_ojo_de_halcon(self):
        if not self.tablero.power_up_posiciones:
            messagebox.showinfo("Ojo de Halcón", "El Power-Up se consume, pero no quedan Power-Ups ocultos en el tablero.")
            return

        pos_revelada_0_index = random.choice(self.tablero.power_up_posiciones)
        self.tablero.consumir_power_up(pos_revelada_0_index)

        f_1_index = pos_revelada_0_index[0] + 1
        c_1_index = pos_revelada_0_index[1] + 1
        messagebox.showinfo("Ojo de Halcón", f"Se revela la posición de un Power-Up oculto (ahora desactivado) en: Fila {f_1_index}, Columna {c_1_index}.")


    def reiniciar_partida_confirm(self):
        if messagebox.askyesno("Confirmar Reinicio", "¿Reiniciar la partida? El tablero y la jugabilidad se restablecerán, manteniendo la configuración inicial (nombres, tamaño, posiciones iniciales)."):
            self.win.destroy()
            self.reiniciar_partida_a_jugabilidad()
            
    def reiniciar_partida_a_jugabilidad(self):
        
        jugador1_nuevo = copy.deepcopy(self.jugador1_base)
        jugador2_nuevo = copy.deepcopy(self.jugador2_base)
        
        destruir_y_abrir(None, lambda: GameWindow(
            jugador1_nuevo, 
            jugador2_nuevo, 
            self.filas, 
            self.cols)
        )

    def volver_al_menu_confirm(self):
        if messagebox.askyesno("Confirmar", "¿Volver al menú principal? Se perderá la partida actual y la configuración inicial de posiciones."):
            destruir_y_abrir(self.win, MenuWindow)

# -------------------------------
# Teleport Window
# -------------------------------

class TeleportWindow:
    def __init__(self, parent_game_window):
        self.parent_game = parent_game_window
        self.win = tk.Toplevel(self.parent_game.win)
        self.win.title("Teletransporte (Cambio de Posición) ⚡")
        self.win.grab_set()
        centrar_ventana(self.win, 520, 220)
        
        tk.Label(self.win, text=f"{self.parent_game.turno_actual.nombre}, elige tu nueva posición (Fila, Columna) libre de jugadores:", font=("Arial", 11)).pack(pady=8)
        
        frame = tk.Frame(self.win); frame.pack(pady=4)
        tk.Label(frame, text=f"Fila (1-{self.parent_game.filas}):").grid(row=0, column=0, padx=6, pady=4)
        tk.Label(frame, text=f"Columna (1-{self.parent_game.cols}):").grid(row=1, column=0, padx=6, pady=4)
        
        self.fila_var = tk.StringVar(); self.col_var = tk.StringVar()
        e1 = tk.Entry(frame, textvariable=self.fila_var); e2 = tk.Entry(frame, textvariable=self.col_var)
        e1.grid(row=0, column=1, padx=6, pady=4); e2.grid(row=1, column=1, padx=6, pady=4)
        
        self.btn_confirm = tk.Button(self.win, text="Confirmar Teletransporte (Enter)", command=self.confirmar)
        self.btn_confirm.pack(pady=8)
        
        self.win.protocol("WM_DELETE_WINDOW", lambda: messagebox.showwarning("Advertencia", "Debes completar el teletransporte para continuar."))
        
        e1.bind("<Return>", lambda ev: self.confirmar()); e2.bind("<Return>", lambda ev: self.confirmar())


    def confirmar(self):
        try:
            f_in = int(self.fila_var.get()); c_in = int(self.col_var.get())
        except:
            messagebox.showwarning("Error", "Ingrese coordenadas válidas (enteros)."); return
            
        if not (1 <= f_in <= self.parent_game.filas and 1 <= c_in <= self.parent_game.cols):
            messagebox.showwarning("Error", "Coordenadas fuera del tablero (recuerda que empiezan en 1)."); return

        nueva_pos_0_index = (f_in - 1, c_in - 1)
        
        oponente = self.parent_game.oponente
        
        if nueva_pos_0_index == oponente.posicion or nueva_pos_0_index == self.parent_game.turno_actual.posicion:
            messagebox.showwarning("Error", "Esa posición está ocupada por un jugador. Elegí una casilla libre."); return
        
        self.parent_game.turno_actual.posicion = nueva_pos_0_index
        
        if self.parent_game.tablero.tiene_power_up(nueva_pos_0_index):
            messagebox.showinfo("Teletransporte", "¡Aterrizaste en un Power-Up! Sin embargo, este Power-Up se inhibe y no se activa. Tu turno ha terminado.")
        else:
            messagebox.showinfo("Teletransporte", f"{self.parent_game.turno_actual.nombre} se teletransportó a (Fila {f_in}, Columna {c_in}). Tu turno ha terminado.")
        
        self.parent_game.actualizar_tablero_visual()
        self.parent_game.alternar_turno()
        
        self.win.grab_release()
        self.win.destroy()

if __name__ == "__main__":
    MenuWindow()




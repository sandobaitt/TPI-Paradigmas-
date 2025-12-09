instance creation
abrirConJuego: unJuego
    | pantalla |
    pantalla := self new juego: unJuego.
	 pantalla := pantalla open.
	 pantalla window
		 removeCollapseBox;
		 removeExpandBox;
		 removeMenuBox;
		 removeCloseBox;
		 beUnresizeable.
   ^pantalla.
accessing
obtenerNombreIntroducido
	"Devuelve el nombre de jugador
	introducido por el usuario."
	(caja_txt text) ifNil: [
		^self error: '¡Introduzca un nombre para el jugador!'.
	].
	
	(caja_txt text size > 5) ifTrue: [
		^self error: 'La longitud máxima que se permite para un nombre es de 5 caracteres.'.
	].
	
	^caja_txt text.
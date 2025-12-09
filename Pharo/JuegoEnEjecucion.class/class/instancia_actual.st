instance creation
instancia_actual
	"
	instancia_actual es un método que se
	utiliza para aplicar el patrón de
	diseño Singleton: la idea es que esta
	clase (Juego) se pueda utilizar para
	mantener un control del estado global
	del juego, por lo que solo debe existir
	como máximo una instancia de esta clase
	en cualquier momento dado.
	
	Este método actúa como un getter que
	permite acceder al atributo de clase
	homónimo, y que si este no tiene un
	objeto almacenado, lo crea.
	
	En el atributo de clase homónimo se
	almacena un objeto de esta clase, el
	cual se utiliza durante la ejecución
	del juego para acceder a datos globales
	y relevantes del juego, como los objetos
	que representan a los jugadores que
	participan del juego.
	
	Al almacenar el objeto en un atributo
	de clase, nos aseguramos de que el
	recolector de basura de Smalltalk no
	lo borre en ningún momento, y que por
	lo tanto la información que necesitamos
	almacenar en los atributos de instancia
	del objeto almacenado sea accesible en
	cualquier momento.
	
	Más información: https://es.wikipedia.org/wiki/Singleton.
	"
	instancia_actual ifNil: [
		instancia_actual := self new.
	].
	^instancia_actual.
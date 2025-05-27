{
	-Overflow: El overflow se produce cuando se quiere agregar una clave a un nodo el cual ya tiene la cantidad máxima de claves permitidas.
	
	-Underflow: El underflow se produce cuando se quiere eliminar una clave de un nodo el cual ya tiene la cantidad mínima de claves permitidas.
	
	-Redistribucion: La redistribución sucede cuando un nodo tiene underflow, se puede trasladar una llave de un hermano adyacenente a este nodo, 
	 para que el underflow deje de ocurrir.
	
	-Fusion o concatenacion: Si un nodo adyacente hermano está al mínimo y no se puede redistribuir, se concatena con un nodo adyacente disminuyendo
	 la cantidad de nodos, y en algunos casos la altura del árbol.
}

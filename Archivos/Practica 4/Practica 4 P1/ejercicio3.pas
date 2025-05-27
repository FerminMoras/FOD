const
	M = ..  //orden del arbol
type
	alumno = record
		nomApe: string;
		legajo: integer;
		dni: integer;
		año: integer;
	end;
	
	lista = ^nodo;
	nodo = record
		claves: array[1..M-1] of longint;
		enlaces: array[1..M-1] of integer;
		hijos: array[1..M] of integer;
		cantDatos: integer;
		sig: lista;
	end;
	
	archivo = file of alumno;
	arbolB+ = file of nodo;
var
	archivoDatos: archivo;
	archivoIndice: arbolB+;
	
{
	a- El árbol B+ incorpora las características del Árbol B además del tratamiento secuencial
	ordenado del archivo.
	Propiedades del árbol B+:
	- Cada nodo del árbol puede contener, como máximo, M descendientes y M-1
	elementos.
	- La raíz no posee descendientes o tiene al menos dos.
	- Un nodo con x descendientes contiene x-1 elementos.
	- Los nodos terminales tienen, como mínimo, ([M/2] – 1) elementos, y como máximo,
	M-1 elementos.
	- Los nodos que no son terminales ni raíz tienen, como mínimo, [M/2] descendientes.
	- Todos los nodos terminales se encuentran al mismo nivel.
	- Los nodos terminales representan un conjunto de datos y son enlazados entre ellos.
	
	b- Arriba se establece la principal diferencia entre un árbol B y un árbol B+. Para poder realizar
	acceso secuencial ordenado a todos los registros del archivo, es necesario que cada
	elemento (clave asociada a un registro de datos) aparezca almacenado en un nodo
	terminal.
	
	d- El proceso de busqueda de un alumno con un DNI haciendo uso del árbol B+, consiste en aprovechar el criterio de orden y los 
	separadores de los nodos internos, hasta encontrar el dato en una hoja. La diferencia con respecto a un árbol B, es que en el árbol B+, 
	todos los datos están en las hojas enlazadas, lo que mejora el recorrido ordenado y hace más eficiente la búsqueda de rangos o listados completos.
	En el árbol B, los datos pueden estar dispersos y no hay un enlace directo entre nodos hojas, lo que lo hace menos eficiente para recorridos secuenciales.
	
	e- Para buscar los alumnos que tienen DNI entre 40000000 y 45000000 usando un índice organizado como un árbol B+, hago lo siguiente:
	Empiezo desde la raíz del árbol, que contiene claves (DNI) que me indican hacia qué hijo bajar.
	Sigo bajando por los nodos internos, comparando el valor 40000000 hasta que llego al nodo hoja que contiene o está cerca de ese DNI.
	Una vez en la hoja correcta, empiezo a recorrer las claves en orden, dentro de ese nodo.
	Como las hojas están enlazadas entre sí como una lista, voy pasando de una hoja a otra fácilmente, y voy recogiendo todos los DNI que están en el rango hasta llegar a uno mayor que 45000000.
	
	Gracias a esta estructura, puedo buscar de forma rápida y secuencial todos los alumnos del rango, sin tener que volver a recorrer todo el árbol.
	Ventajas:
	En un árbol B, los datos pueden estar en cualquier nodo (interno o hoja), y los nodos no están enlazados entre sí.
	Por eso, si quiero buscar un rango de DNI como en este caso, tengo que:
	Hacer una búsqueda por cada posible valor x, ecorrer muchas ramas del árbol para encontrar todos los valores,
	lo cual es más lento y más costoso. En cambio, en el árbol B+, como todos los datos están en las hojas y además están conectadas, 
	una vez que encuentro la hoja inicial, el resto del recorrido es muy rápido y eficiente.
}	

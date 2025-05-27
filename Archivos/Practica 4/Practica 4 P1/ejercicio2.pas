type
	alumno = record
		nomApe: string;
		legajo: integer;
		dni: integer;
		año: integer;
	end;
	
	type nodo = record
		claves: array[1..M-1] of longint;
		enlaces: array[1..M-1] of integer;
		hijos: array[1..M] of integer;
		cantDatos: integer;
	end;
	
	archivo = file of alumno;
	arbolB = file of nodo;
var
	archivoDatos: archivo;
	archivoIndice: arbolB;
	
{
	b- realizando la formula N = (M-1) * A + (M-1) * A + M * B + C. El orden del arbol da 43.
	
	c- Incrementar el orden del arbol B significa aumentar la cantidad de registros que caben en un nodo, en este caso indices a registros,
	como consecuencia, nuestro arbol va a ser menos profundo y se requieren menos accesos (lecturas) a los nodos.
	
	d- Se busca el dni 12345678, aprovechando el criterio de orden, moviendonos a la izquierda si es menor o igual, y en caso contrario a la
	derecha. Una vez q encontre la clave, uso el NRR guardado en el enlace para buscar el registro en el archivo de datos.
	
	e- Para buscar por numero de legajo se tiene que realizar una busqueda secuencial hasta encontrarlo. No tiene sentido usar el indice
	que organiza el acceso al archivo por numero de dni. Para realizar el acceso indizado por legajo tendriamos q crear un nuevo arbol
	con el legajo como criterio de orden.
}	

//PUNTO A

type
	alumno = record
		nomApe: string;
		legajo: integer;
		dni: integer;
		año: integer;
	end;
	
	type nodo = record
		claves: array[1..M - 1] of alumno;
		hijos: array[1..M] of integer;
		cantDatos: integer;
	end;
	
	arbolB = file of nodo;	
var
	archivoDatos: arbolB;
{
//PUNTO B
tamaño total: 512b, reg: 64b, enteros: 4b
1 registro pesa: 64 + 4 + 4 (reg, hi, hd)
¿cuántos registros de persona entrarían en un nodo del árbol B?
72 x 7 = 504b, entran 7 registros.

la formula N = (M-1) * A + M * B + C dio como resultado 7, entonces por nodo
entran M-1, 7-1 = 6 registros por nodo.

Cuanto mayor sea el tamaño del registro, menor sera M(orden del arbol), y este mismo sera mas profundo(mas lento).
Si los registros son mas pequeños, mayor sera M y el arbol sera mas eficiente en operaciones de busqueda e insercion.

Se puede elegir cualquiera de los datos, pero tenes que ver cual es el que mas conviene en cuanto organizacion del arbol,
y para que las busquedas sean mas eficientes, por ejemplo los nombres las comparaciones pueden ser mas costosas y puede haber
repeticiones. Yo elegiria el dni, ya que es un dato unico y de tamaño fijo.

Para describir el proceso de busqueda voy a usar el dato dni.
Se arranca de la raiz del arbol comparando si el dato de ese nodo es igual al dni, si no lo es se determina por que hijo seguir
la busqueda(cuando el dato buscado es menor al dato actual, se baja al hijo correspondiente). las lecturas que se necesitan dependen 
claramente de donde este ubicado el elemento, el mejor caso es que se encuentre en la raiz, entonces es 1 sola lectura, 
el peor de los casos es que este en un nodo hoja y en la ultima posicion, ahi la cantidad de lecturas sera igual a la altura del arbol.

Si se desea buscar por otro criterio diferentes al usado para ordenar el arbol (DNI), se pierde la eficiencia del arbol b, 
es decir, no podes evaluar y descartar por cual hijo buscar ya que no existe ningun orden. Entonces, hay que realizar un 
recorrido completo del arbol y esto implica un mayor costo de lecturas, por lo tanto, es menos eficiente.
}

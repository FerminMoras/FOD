//PUNTO A

type
	alumno = record
		nomApe: string;
		legajo: integer;
		dni: integer;
		año: integer;
	end;
	
	type arbol = record
		elemento: alumno;
		HI: integer;
		HD: integer;
	end;
	
	indice = file of arbol;	

{
//PUNTO B
tamaño total: 512b, reg: 64b, enteros: 4b
1 registro pesa: 64 + 4 + 4 (reg, hi, hd)
¿cuántos registros de persona entrarían en un nodo del árbol B?
72 x 7 = 504b, entran 7 registros.


}

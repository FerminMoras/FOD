{
	a- posicionarYLeerNodo(A, nodo, NRR) es un procedimiento que se posiciona en un nodo hijo de la raíz para poder seguir buscando la clave buscada. 
	La variable nodo corresponde al array de claves correspondiente al nodo hijo, A es el árbol y NRR el índice. 
	NRR debe ser pasado por valor, mientras que nodo y A por referencia.

	b- El método claveEncontrada() es un procedimiento que almacena en la variable clave_encontrada true o false, 
	dependiendo si la variable clave se encontró en el árbol, y si se encontró almacena la posición en la variable pos.
	La variable clave_encontrada debe ser pasada por referencia ya que se debe cambiar su valor, al igual que pos, 
	clave por valor porque sólo se necesita su valor y no modificarlo, y nodo y A se deben pasar por referencia.
	
	c-  function buscar(NRR,clave:integer;var A:arbol;var pos_encontrada:integer; var NRR_encontrado:integer):boolean;
		var
			nodo: array[1..M] of integer;
			pos:integer;
		begin
			if (nodo=nil) then buscar:=false;
			else begin
					posicionarYLeerNodo(NRR,A,nodo);
					if (claveEncontrada(A,nodo,clave,pos)) then begin
						pos_encontrada:=pos;
						NRR_encontrado:=NRR
					end
					else buscar:= buscar(nodo.hijo[pos],clave,A,pos_encontrada,NRR_encontrado);
			end;
		end;
	
	d- para que funcione en un arbol b+ el procedimiento tendria que finalizar al llegar a una hoja.	
}

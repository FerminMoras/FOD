program ejercicio5;
const
	codAlto = 9999;
	DF = 3; //son 5 pero para q sea mas corto
type
	rango = 1..DF;
	regDetalle = record
		cod: integer;
		fecha: string;
		tiempo: real;
	end;
	
	maestro = file of regDetalle;
	detalle = file of regDetalle;
	vecDetalles = array [rango] of detalle;
	vecRegistros = array [rango] of regDetalle;	
	
	procedure leer(var det: detalle; var regd: regDetalle);
	begin
		if(not eof(det)) then
			read(det,regd)
		else
			regd.cod:= codAlto;
	end;
	
	procedure unDetalle(var det: detalle);
	var
		regd: regDetalle;
		t: text;
		nombre: string;
	begin
		writeln('Ingrese el archivo de texto a leer');
		readln(nombre);
		assign(t,nombre);
		reset(t);
		
		writeln('Ingrese el archivo binario a crear');
		readln(nombre);
		assign(det,nombre);
		rewrite(det);
		
		while(not eof(t)) do begin
			readln(t, regd.cod, regd.tiempo, regd.fecha);
			write(det,regd);
		end;
		
		close(t);
		close(det);
	end;
	
	procedure crearDetalles(var v: vecDetalles);
	var
		i: rango;
	begin
		for i:= 1 to DF do begin
			unDetalle(v[i]);
			writeln('Archivo detalle numero ', i, ' creado con exito');
		end;
	end;
	
	procedure minimo(var vD: vecDetalles; var vR: vecRegistros; var min: regDetalle);
	var
		i: rango;
		pos: integer;
	begin
		for i:= 1 to DF do begin //recorre los 3 registros
			if(vR[i].cod <= min.cod) and (vR[i].fecha < min.fecha) then begin //busca el minimo
				min:= vR[i]; //guarda el minimo
				pos:= i; //guarda el numero del registro minimo
			end;
		if(min.cod <> codAlto) then //si no llego al valor alto
			leer(vD[pos],vR[pos]); //lee de nuevo con el detalle y su registro que guardo
		end;
	end;			
	
	procedure crearMaestro(var mae: maestro; var vD: vecDetalles);
	var
		min, aux: regDetalle;
		i: rango;
		vR: vecRegistros;
	begin
		assign(mae, 'maestro.dat');
		rewrite(mae);
		for i:= 1 to DF do begin //reseteas detalles y lees para poder buscar el minimo
			reset(vD[i]);
			leer(vD[i],vR[i]);
		end;
		minimo(vD,vR,min); //buscamos el minimo
		while(min.cod <> codAlto) do begin //mientras no lleguemos al final del archivo
			aux.cod:= min.cod;
			while(aux.cod = min.cod) do begin
				aux.fecha:= min.fecha;
				aux.tiempo:= 0;
				while (aux.cod = min.cod) and (aux.fecha = min.fecha) do begin
					aux.tiempo:= aux.tiempo + min.tiempo;
					minimo(vD,vR,min);
				end;
				write(mae,aux);
			end;
		end;
		close(mae);
		for i:= 1 to DF do
			close(vD[i]);
			writeln('Archivo maestro creado con exito');
	end;
		
var
	v: vecDetalles;
	mae: maestro;
begin
	crearDetalles(v);
	crearMaestro(mae,v);
end.

program ejercicio3;
type
	info = record
		codigo: integer;
		fecha: string;
		tiempo: real;
	end;
	
	archivo = file of info;
	vector = array [1..5] of archivo;
	
	procedure unDetalle(var arc: archivo);
	var
		t: text;
		i: info;
		nombre: string;
	begin
		writeln('ingrese el nombre del archivo de texto a leer');
		readln(nombre);
		assign(t,nombre);
		reset(t);
		writeln('ingrese el nombre del archivo a crear');
		readln(nombre);
		assign(arc,nombre);
		rewrite(arc);
		while(not eof(t)) do begin
			readln(t, i.codigo, i.fecha, i.tiempo);
			write(arc,i);
		end;
		close(t);
		close(arc);
		writeln('archivo creado con exito');
	end;
	
	procedure crearDetalles(var v: vector);
	var
		i: integer;
	begin
		for i:= 1 to 3 do 
			unDetalle(v[i]);
	end;
	
	procedure generarMaestro(var mae: archivo; var v: vector);
	var
		regDet,aux: info;
		i: integer;
		ok: boolean;
	begin
		assign(mae,'maestro.dat');
		rewrite(mae);
		for i:= 1 to 3 do begin
			reset(v[i]);
			while(not eof(v[i])) do begin
				ok:= false;
				read(v[i], regDet);
				seek(mae,0);
				while(not eof(mae)) do begin
					read(mae,aux);
					if(aux.codigo = regDet.codigo) then
						ok:= true;
				end;
				if (ok) then begin
					aux.tiempo:= aux.tiempo + regDet.tiempo;
					seek(mae,filepos(mae)-1);
					write(mae,aux);
				end
				else
					write(mae,regDet);
			end;		
			close(v[i]);
		end;
		close(mae);
	end;			
var
	v: vector;
	mae: archivo;
begin
	crearDetalles(v);
	generarMaestro(mae,v);
end.	

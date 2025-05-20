program ejercicio7;
const 
	valorAlto = 9999;
type
	ave = record
		codigo: integer;
		nombre: string;
		familia: string;
		descripcion: string;
		zona: string;
	end;
	
	maestro = file of aves;
	
	procedure leerAve(var a: ave);
	begin
		writeln('ingrese codigo');
		readln(a.codigo);
		if(a.codigo <> -1) then begin
			writeln('ingrese nombre');
			readln(a.nombre);
			writeln('ingrese familia');
			readln(a.familia);
			writeln('ingrese descripcion');
			readln(a.descripcion);
			writeln('ingrese zona');
			readln(a.zona);
		end;
	end;
	
	procedure crearMaestro(var mae: maestro);
	var
		a: ave;
	begin
		assign(mae, 'maestro.dat');
		rewrite(mae);
		leerAve(a);
		while (a.codigo <> -1) do begin
			write(mae,a);
			leerAve(a);
		end;
		close(mae);
		writeln('archivo maestro creado con exito');
	end;
	
	procedure bajaLogica(var mae: maestro);
	var
		cod: integer;
		a,ultimo: ave;
		posActual: integer;
	begin
		reset(mae);
		writeln('ingrese el codigo del ave que desea eliminar');
		readln(cod);
		while(not eof(mae)) do begin
			read(mae,a);
			if(a.codigo = cod) then begin
				seek(filepos(mae)-1);
				a.codigo:= -1;
				write(mae,a);
			end;
		end;
		close(mae);
	end;
	
	procedure compactarArchivoDeAuno(var mae: maestro);
	var
		a,ultimo: ave;
		ok: boolean;
		posActual: integer
	begin
		reset(mae);
		ok:= false;
		while (not eof(mae)) do begin
			posActual:= filepos(arc);
			read(mae,a);
			if(a.codigo <= 0) and (not ok) then
				ok:= true;
		end;
		
		if(ok) then begin
			seek(mae, filepos(mae)-1);
			read(mae,ultimo);
			seek(mae,posActual);
			write(mae,ultimo);
			seek(arc, filepos(arc)-1)
			Trucante(arc);
		end;
		close(mae);
		writeln('archivo truncado con exito');
	end;
	
	procedure leer(var mae: maestro, a: ave);
	begin
		if(not eof(mae)) then
			read(mae,a)
		else
			a.codigo:= valorAlto;
	end;		
	
	procedure compactarArchivoCompleto(var mae: maestro);
	var
		a: ave;
		pos: integer;
	begin
		reset(mae);
		leer(mae,a);
		while (a.codigo <> valorAlto) do begin
			if(a.codigo < 0 ) then begin
				pos:= (filepos(mae)-1);
				seek(mae,filesize(mae)-1);
				read(mae,a);
				if()
var
	
begin

end.

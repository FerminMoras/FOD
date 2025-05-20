program ejercicio8;
type
	linux = record
		nombre: string;
		anio: integer;
		version: integer;
		cantD: integer;
		descripcion: string;
	end;
	
	archivo = file of linux;
	
	procedure leerLinux(var l:linux);
	begin
		writeln('ingrese el nombre de la distribucion');
		readln(l.nombre);
		if(l.nombre <> 'ZZZ') then begin
			writeln('ingrese el año');
			readln(l.anio);
			writeln('ingrese la version');
			readln(l.version);
			writeln('ingrese la cantidad de desarrolladores');
			readln(l.cantD);
			writeln('ingrese la descripcion');
			readln(l.descripcion);
		end;	
	end;
	
	procedure crearArchivo(var arc: archivo);
	var
		l:linux;
	begin
		assign(arc,'archivo.dat');
		rewrite(arc);
		leerLinux(l);
		while(l.nombre <> 'ZZZ') do begin
			write(arc,l);
			leerLinux(l);
		end;
		close(arc);
		writeln('archivo creado con exito');
	end;
	
	procedure buscarDescripcion(var arc: archivo; var pos: integer);
	var
		l: linux;
		ok: boolean;
		desc: string;
		pos: integer;
	begin
		ok:= false;
		reset(arc);
		writeln('ingrese el nombre de la descripcion a buscar');
		readln(desc);
		while (not eof(arc)) and (not ok) do begin
			read(arc,l);
			if(l.descripcion = desc) then begin
				ok:= true;
				seek(arc, filepos(arc)-1); //vuelvo a la posicion anterior.
				pos:= filepos(arc); //guardo la posicion del registro con igual descripcion.
			end;
		end;
		if (ok) then
			writeln('se encontro la descripcion en la posicion ', pos)
		else begin
			writeln('no se encontro la descripcion');
			pos:= -1;
		end;	
	end;		
var

begin

end.

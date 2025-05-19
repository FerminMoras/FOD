program ejercicio2;

type
	asistentes = record
		numero: integer;
		apellido: String;
		nombre: String;
		email: String;
		telefono: integer;
		dni: integer;
	end;	
	
	archivo = file of asistentes;
	
	procedure leerAsistentes(var a: asistentes);
	begin
		writeln('ingrese un numero de asistentes');
		readln(a.numero);
		if (a.numero <> -1) then begin
			writeln('ingrese un apellido');
			readln(a.apellido);
			writeln('ingrese un nombre');
			readln(a.nombre);
			writeln('ingrese un email');
			readln(a.email);
			writeln('ingrese un telefonp');
			readln(a.telefono);
			writeln('ingrese un dni');
			readln(a.dni);
		end;
	end;	
					
	procedure crearArchivo(var arc: archivo);
	var
		a: asistentes;
		nombreAr: String;
	begin
		writeln('ingrese un nombre para el archivo');
		readln(nombreAr);
		assign(arc,nombreAr);
		rewrite(arc);
		leerAsistentes(a);
		while (a.numero <> -1) do begin
			write(arc,a);
			leerAsistentes(a);
		end;
		close(arc);
		writeln('archivo creado con exito'); 
	end;
	
	procedure bajaLogica(var arc:archivo);
	var
		a: asistentes;
	begin
		reset(arc);
		while (not eof(arc)) do begin
			read(arc,a);
			if(a.numero < 1000) then begin
				a.nombre:= '@' + a.apellido;
				seek(arc,filepos(arc)-1);
				write(arc,a);
			end;
		end;
		close(arc);
	end;
	
	procedure imprimirArc(var arc:archivo);
	var
		a: asistentes;
	begin
		reset(arc);
		read(arc,a);
		while (not eof(arc)) do begin
			with a do
				writeln(numero,nombre,apellido,email,telefono,dni);
			read(arc,a);	
		end;	
		close(arc);
	end;
var	
	arc: archivo;
begin
	crearArchivo(arc);
	writeln('Archivo original');
	imprimirArc(arc);
	bajaLogica(arc);
	writeln('Archivo con baja logica');
	imprimirArc(arc);
end.

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
	
	maestro = file of ave;
	
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
		a: ave;
	begin
		reset(mae);
		writeln('ingrese el codigo del ave que desea eliminar');
		readln(cod);
		while(not eof(mae)) do begin
			read(mae,a);
			if(a.codigo = cod) then begin
				seek(mae,filepos(mae)-1);
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
		posActual: integer;
	begin
		reset(mae);
		ok:= false;
		while (not eof(mae)) do begin
			posActual:= filepos(mae);
			read(mae,a);
			if(a.codigo <= 0) and (not ok) then
				ok:= true;
		end;
		if(ok) then begin
			seek(mae, filepos(mae)-1);
			read(mae,ultimo);
			seek(mae,posActual);
			write(mae,ultimo);
			seek(mae, filepos(mae)-1);
			truncate(mae);
		end;
		close(mae);
		writeln('archivo truncado con exito');
	end;
	
	procedure leer(var mae: maestro; var a: ave);
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
				pos:= (filepos(mae)-1); //me guardo la posicion del primer archivo borrado que encontre
				seek(mae,filesize(mae)-1); // me posiciono en el ultimo registro del archivo.
				read(mae,a); //leo la ultima pos del registro
				if (filepos(mae)-1 <> 0) then begin //si la posicion actual del registro es distinta de 0, es decir, si no llegue al principio.
					while(a.codigo < 0) do begin
						seek(mae, filesize(mae)-1); //me posiciono en el ultimo registro del archivo.
						truncate(mae); // lo elimino
						seek(mae, filesize(mae)-1); //me posiciono en el nuevo ultimo registro del archivo.
						read(mae,a); //leo el nuevo ultimo registro.
					end;
				end;
				seek(mae,pos); //me posiciono en la primera posicion que encontre un registro borrado.
				write(mae,a); //sobrescribo ese registro con el ultimo valido leido.
				seek(mae, filesize(mae)-1); //me posiciono en el ultimo registro del archivo.
				truncate(mae); //elimino la ultima pos(ya copiada, para evitar duplicados).
				seek(mae,pos); //vuelvo a la posicion en la que estaba.
			end;
			leer(mae,a);
		end;
		close(mae);
		writeln('se compacto el archivo con exito');
	end;					
var
	mae: maestro;
begin
	crearMaestro(mae);
	//realizamos dos bajas	
	bajaLogica(mae);
	bajaLogica(mae);
	//compactamos el archivo
	compactarArchivoCompleto(mae);
end.

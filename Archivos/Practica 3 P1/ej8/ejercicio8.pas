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
	
	procedure buscarDistribucion(var arc: archivo; var pos: integer; distri: string);
	var
		l: linux;
		ok: boolean;
		pos: integer;
	begin
		ok:= false;
		reset(arc);
		while (not eof(arc)) and (not ok) do begin
			read(arc,l);
			if(l.descripcion = distri) then begin
				ok:= true;
				seek(arc, filepos(arc)-1); //vuelvo a la posicion anterior.
				pos:= filepos(arc); //guardo la posicion del registro con igual descripcion.
			end;
		end;
		if (ok) then
			writeln('se encontro la distribucion en la posicion ', pos)
		else begin
			writeln('no se encontro la distribucion');
			pos:= -1;
		end;	
	end;
	
	procedure altaDistribucion(var arc: archivo; var lin: linux);
	var
		l,aux:linux;
		pos: integer;
	begin
		reset(arc);
		buscarDistribucion(arc,pos,distri);
		if (pos = -1) then begin
			read(arc,aux);
			if(aux.codigo = 0) then begin
				seek(arc,filesize(arc)-1);
				write(arc,lin);
			end
			else begin
				seek(arc, aux.codigo * -1);
				read(arc,aux);
				seek(arc,filepos(arc)-1);
				write(arc,lin);
				seek(arc,0);
				write(arc,aux);
			end;
		writeln('distribucion agregada con exito');	
		end
		else 
			writeln('ya existe la distribucion');
		close(arc);
	end;	
	
	procedure bajaDistribucion(var arc: archivo; distri: string);
	var
		l,aux: linux;
		pos: integer;
	begin
		ok:= false;
		reset(arc);
		read(arc,aux);
		buscarDistribucion(arc,pos,distri);
		if(pos <> -1) then begin
			seek(arc,pos); //nos movemos a la posicion donde encontro el registro.
			read(arc,l); // leemos el registro
			l.cantD:= aux.cantD; //actualizamos el valor del registro con el valor de la cabecera.
			aux.cantD:= -pos; //guardamos en el reg auxiliar la posicion del q se encontro de forma negativa.
			seek(arc,pos); //nos movemos a la posicion donde encontro el registro. 
			write(arc,l); //actualizamos la posicion del registro.
			seek(arc,0); //volvemos a la cabecera.
			write(arc,aux);	//actualizamos el valor que nos indica la posicion libre.
		end;
		writeln('Distribucion borrada logicamente con exito');
		else
			writeln('Distribucion no existente');
		close(arc);
	end;		
var
	arc: archivo;
	reg: linux;
	distri: string;
begin
	crearArchivo(arc);
	writeln('Datos para realizar alta');
	leerLinux(reg);
	altaDistribucion(arc,reg);
	writeln('ingrese el nombre del archivo que desea eliminar');
	readln(distri);
	bajaDistribucion(arc,distri);
end.
